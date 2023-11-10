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
conditions = ["healthy","brace2"]; % "healthy","brace2"
joints = ["wrist","elbow","shoulder","thorax","pelvis"];
distance_method = "minkowski"; % 'minkowski','euclidean', 'cityblock', 'chebychev'
distance_coes = [0.5,1,2,3];
link_methods = ["single","complete","average","ward","weighted"];

% all_data = load(foldername + "all_data_"+direction);
all_data_norm = load(foldername + "all_data_norm");

%% Control Parameters

direction = "v";
joint = joints(5);

%% Clustering

ave_accuracies_dic = configureDictionary("string","double");

for l=1:length(link_methods)
    link_method = link_methods(l);
    if link_method=="median" | link_method=="ward"
        distance_coe = 2;

        [accuracies,cophenetics] = Hierarchical_Cluster(all_data_norm,joint,conditions,direction,distance_method,distance_coe,link_method);

        % Get Average
        ave_accuracy = mean(accuracies);

        % Save result
        distance_coe_str = num2str(distance_coe);
        method = join([distance_method,distance_coe_str,link_method],"_");
        ave_accuracies_dic(method) = ave_accuracy;
        results.(method).accuracies = accuracies;
        results.(method).cophenetics = cophenetics;
        results.(method).name = method;

    else
        for dc=1:length(distance_coes)
            distance_coe = distance_coes(dc);

            [accuracies,cophenetics] = Hierarchical_Cluster(all_data_norm,joint,conditions,direction,distance_method,distance_coe,link_method);

            % Get Average
            ave_accuracy = mean(accuracies);
            cophenetic_ave = mean(cophenetics);

            % Save result
            distance_coe_str = num2str(distance_coe);
            if distance_coe < 1
                distance_coe_str = "negative";
            end
            method = join([distance_method,distance_coe_str,link_method],"_");
            ave_accuracies_dic(method) = ave_accuracy;
            results.(method).accuracies = accuracies;
            results.(method).cophenetics = cophenetics;
            results.(method).name = method;
        end
    end
end

results.average_accuricies = ave_accuracies_dic;
ave_accuracies_arr = ave_accuracies_dic.values;
[best_acc,best_idx] = max(ave_accuracies_arr);
methods = keys(ave_accuracies_dic);
best_method = methods(best_idx);
disp("Best method is: "+best_method+", and the accuracy is: "+best_acc)
results.best_method = results.(best_method);
results.best_method.name = best_method;

save("D:\1_Project\1_Reaching\Data\Clustering\Hierarchical\"+direction+"\"+joint,"results")

function[accuracies,cophenetics]=Hierarchical_Cluster(all_data_norm,joint,conditions,direction,distance_method,distance_coe,link_method)

accuracies = zeros(1,49);
cophenetics = zeros(1,49);

for num=1:49
    % disp([link_method, num])
    % get data
    nc = length(conditions);
    data = double.empty(0,3);
    for i=1:nc
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
    T = cluster(Z,"maxclust",nc);

    % Evaluation
    idx = [];
    for i=1:nc
        id = [i,i,i,i,i,i,i];
        idx = cat(2,idx,id);
    end
    [Acc,rand_index,match] = AccMeasure(T,idx);
    
    accuracies(num) = Acc;
    cophenetics(num) = cophenetic;
end

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
