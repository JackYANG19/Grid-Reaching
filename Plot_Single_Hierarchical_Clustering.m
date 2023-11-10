close all
clear

%% Load files
foldername = "D:\1_Project\1_Reaching\Data\End_Joint_Location\";
colors = [0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880;
    0.3010 0.7450 0.9330;
    0.6350 0.0780 0.1840];

subjects = ["P09","P10","P11","P13","P14","P15","P16"];
conditions = ["healthy","brace2"];
joints = ["wrist","elbow","shoulder","thorax","pelvis"];

% joint = joints(2);
% tmp_all = all_data_norm.all_data.(joint).(conditions(1)).target;
% tmp_single = tmp_all(18,:,:);
% tmp_single = reshape(tmp_single,size(tmp_single,2),[]).'

%% Control Parameters
joint = joints(3);
direction = "v";

num = 12;
distance_method = "minkowski"; % 'minkowski','euclidean', 'cityblock', 'chebychev'
distance_coe = 2;
link_method = "ward"; % "complete", 'average', 'median', 'single', 'ward', 'weighted'

all_data_norm = load(foldername + "all_data_norm");

%% Clustering

% get data
data = double.empty(0,3);
for i=1:length(conditions)
    tmp_all = all_data_norm.all_data.(joint).(conditions(i)).(direction).target;
    tmp_single = tmp_all(num,:,:);
    tmp_single = reshape(tmp_single,size(tmp_single,2),[]).';
    data = cat(1,data,tmp_single);
end

% Distance
Y = pdist(data,distance_method,distance_coe);

% Link
Z = linkage(Y,link_method);
cophenetic = cophenet(Z,Y);
% I = inconsistent(Z);

% Clustering
nc  = length(conditions);
T = cluster(Z,"maxclust",nc);


for i=1:nc
    class.("c"+num2str(i)) = find(T==i);
end
% class.c2 = find(T==2);
% class.c3 = find(T==3);


% Evaluation
idx = [];
for i=1:nc
    id = [i,i,i,i,i,i,i];
    idx = cat(2,idx,id);
end

[Acc,rand_index,match] = AccMeasure(T,idx);
Acc

locs=[];
lis=[];

for i=1:nc
    [lis(i),locs(i)] = ismember(i,match(2,:));
end

% [li2,loc2] = ismember(2,match(2,:))
% [li3,loc3] = ismember(3,match(2,:))

rematches=[];
for i=1:nc
    rematches(i) = match(1,locs(i));
end
% h = num2str(match(1,loc1));
% b1 = num2str(match(1,loc2));
% b2 = num2str(match(1,loc3));


%% Plot
% Cluster result
figure(2)
subplot(1,2,2)
hold on
grid on
for i=1:nc
    scatter3(data(class.("c"+ num2str(rematches(i))),1), ...
        data(class.("c"+ num2str(rematches(i))),2), ...
        data(class.("c"+ num2str(rematches(i))),3),[],colors(i,:),"filled","DisplayName","Cluster1")
end
% scatter3(data(class.("c"+ b1),1),data(class.("c"+ b1),2),data(class.("c"+ b1),3),[],colors(2,:),"filled","DisplayName","Cluster2")
% scatter3(data(class.("c"+ b2),1),data(class.("c"+ b2),2),data(class.("c"+ b2),3),[],colors(3,:),"filled","DisplayName","Cluster3")
legend("Location","best")
subtitle("Cluster Result")
axis equal
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
view(30, 10)

% True label
subplot(1,2,1)
hold on
grid on
for i=1:nc
    scatter3(data((i-1)*7+1:i*7,1),data((i-1)*7+1:i*7,2),data((i-1)*7+1:i*7,3),[],colors(i,:),"filled","DisplayName","Healthy")
end
% scatter3(data(8:14,1),data(8:14,2),data(8:14,3),[],colors(2,:),"filled","DisplayName","Brace1")
% scatter3(data(15:21,1),data(15:21,2),data(15:21,3),[],colors(3,:),"filled","DisplayName","Brace2")
legend("Location","best")
subtitle("True Label")
axis equal
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
view(30, 10)

sgtitle(joint + " " + num)

% set(gcf,"Position",[300,50,700,650])


figure(1)
cutoff = median([Z(end-2,3) Z(end-1,3)]);
H = dendrogram(Z,"ColorThreshold",cutoff);

%// Changing the colours
lineColours = cell2mat(get(H,'Color'));
colourList = unique(lineColours, 'rows');

%// Replace each colour (colour by colour). Start from 2 because the first colour are the "unclustered" black lines
for colour = 2:size(colourList,1)
    %// Find which lines match this colour
    idx = ismember(lineColours, colourList(colour,:), 'rows');
    %// Replace the colour for those lines
    lineColours(idx, :) = repmat(colors(colour-1,:),sum(idx),1);
end
%// Apply the new colours to the chart's line objects (line by line)
for line = 1:size(H,1)
    set(H(line), 'Color', lineColours(line,:));
end

%% Functions
function [Acc,rand_index,match]=AccMeasure(T,idx)
%Measure percentage of Accuracy and the Rand index of clustering results
% The number of class must equal to the number cluster
%Output
% Acc = Accuracy of clustering results
% rand_index = Rand's Index,  measure an agreement of the clustering results
% match = 2xk mxtrix which are the best match of the Target and clustering results
%Input
% T = 1xn target index
% idx =1xn matrix of the clustering results
% EX:
% X=[randn(200,2);randn(200,2)+6,;[randn(200,1)+12,randn(200,1)]]; T=[ones(200,1);ones(200,1).*2;ones(200,1).*3];
% idx=kmeans(X,3,'emptyaction','singleton','Replicates',5);
%  [Acc,rand_index,match]=AccMeasure(T,idx)
k=max([T(:);idx(:)]);
n=length(T);
for i=1:k
    temp=find(T==i);
    a{i}=temp; %#ok<AGROW>
end
b1=[];
t1=zeros(1,k);
for i=1:k
    tt1=find(idx==i);
    for j=1:k
        t1(j)=sum(ismember(tt1,a{j}));
    end
    b1=[b1;t1]; %#ok<AGROW>
end
Members=zeros(1,k);

P = perms((1:k));
Acc1=0;
for pi=1:size(P,1)
    for ki=1:k
        Members(ki)=b1(P(pi,ki),ki);
    end
    if sum(Members)>Acc1
        match=P(pi,:);
        Acc1=sum(Members);
    end
end
rand_ss1=0;
rand_dd1=0;
for xi=1:n-1
    for xj=xi+1:n
        rand_ss1=rand_ss1+((idx(xi)==idx(xj))&&(T(xi)==T(xj)));
        rand_dd1=rand_dd1+((idx(xi)~=idx(xj))&&(T(xi)~=T(xj)));
    end
end
rand_index=200*(rand_ss1+rand_dd1)/(n*(n-1));
Acc=Acc1/n*100;
match=[1:k;match];
end
