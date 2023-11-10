close all
clear

%% Load files
foldername = "D:\1_Project\1_Reaching\Data\End_Joint_Location\";
savefolder = "D:\1_Project\1_Reaching\Data\Variance\";
all_data_norm = load(foldername + "all_data_norm");
direction = "h";

colors = [[0 0.4470 0.7410];
    [0.8500 0.3250 0.0980];
    [0.9290 0.6940 0.1250];
    [0.4940 0.1840 0.5560];
    [0.4660 0.6740 0.1880];
    [0.3010 0.7450 0.9330];
    [0.6350 0.0780 0.1840]];

%% Control Parameter
joint = "wrist";
condition = "healthy";
boxwidth_x = 55;
boxwidth_z = 45;

ms = zeros(49,3);
meds = zeros(49,3);
vs = zeros(49,3);
ss = zeros(49,3);
X.data = zeros(7,49);
X.name = "X";
Y.data = zeros(7,49);
Y.name = "Y";
Z.data = zeros(7,49);
Z.name = "Z";

% All data
tmp_all = all_data_norm.all_data.(joint).(condition).(direction).target;

for num=1:49
    tmp_single = tmp_all(num,:,:);
    tmp_single = reshape(tmp_single,size(tmp_single,2),[]).';
    X.data(:,num) = tmp_single(:,1);
    Y.data(:,num) = tmp_single(:,2);
    Z.data(:,num) = tmp_single(:,3);
end

% std
std_x = std(X.data);
std_y = std(Y.data);
std_z = std(Z.data);
if direction=="h" & condition=="healthy"
    z_49 = Z.data(:,49);
    z_49(6) = [];
    x_35 = X.data(:,35);
    x_35(5) = [];
    std_z(:,49) = std(z_49);
    std_x(:,35) = std(x_35);
    disp("Remove outlier")
end
all_std = sum([std_x;std_y;std_z],1);

ave_std_x = mean(std_x);
ave_std_y = mean(std_y);
ave_std_z = mean(std_z);
ave_all_std = mean(all_std);

% Median
med_x = median(X.data);
med_y = median(Y.data);
med_z = median(Z.data);

%% Heatmap
clim = [15,75];
std_x_square = zeros(7,7);
std_y_square = zeros(7,7);
std_z_square = zeros(7,7);
all_std_square = zeros(7,7);
for i=1:7
    std_x_square(i,1:7) = std_x(1+(7*(i-1)):7+(7*(i-1)));
    std_y_square(i,1:7) = std_y(1+(7*(i-1)):7+(7*(i-1)));
    std_z_square(i,1:7) = std_z(1+(7*(i-1)):7+(7*(i-1)));
    all_std_square(i,1:7) = all_std(1+(7*(i-1)):7+(7*(i-1)));
end
std_x_square = fliplr(std_x_square);
std_y_square = fliplr(std_y_square);
std_z_square = fliplr(std_z_square);
all_std_square = fliplr(all_std_square);

xvalues  = {'7','6','5','4','3','2','1'};
yvalues  = {'7','14','21','28','35','42','49'};

% figure(1)
% subplot(1,3,1)
% h_sx = heatmap(xvalues,yvalues,std_x_square);
% h_sx.Title = join([joint, condition, direction, "x-axis", "(Average std:",ave_std_x,")"]);
% subplot(1,3,2)
% h_sy = heatmap(xvalues,yvalues,std_y_square);
% h_sy.Title = join([joint, condition, direction, "y-axis", "(Average std:",ave_std_y,")"]);
% subplot(1,3,3)
% h_sz = heatmap(xvalues,yvalues,std_z_square);
% h_sz.Title = join([joint, condition, direction, "z-axis", "(Average std:",ave_std_z,")"]);
% sgtitle("Standard Deviation")
% set(gcf,"Position", [30,200,1200,300])
% savefile = savefolder+direction+"\"+joint+"\"+joint+"_"+condition+"_std_xyz.png";
% saveas(gcf,savefile)
% 
% figure(2)
% h_all_s = heatmap(xvalues,yvalues,all_std_square);
% h_all_s.Title = join([joint, condition, direction, "overall std", "(Average std:",ave_all_std,")"]);
% savefile = savefolder+direction+"\"+joint+"\"+joint+"_"+condition+"_std_all.png";
% saveas(gcf,savefile)



%% Box plot
locs = [[49,48,47,46,45,44,43];
    [42,41,40,39,38,37,36];
    [35,34,33,32,31,30,29];
    [28,27,26,25,24,23,22];
    [21,20,19,18,17,16,15];
    [14,13,12,11,10,9,8];
    [7,6,5,4,3,2,1]];

yvalues = {'49','42','35','28','21','14','7'};
xvalues = {'7','6','5','4','3','2','1'};

figure(4)
subplot(1,2,1)
hold on
for i=1:7
    for j=1:7
        boxchart(med_z(locs(j,i))*ones(size(X.data(:,locs(j,i)))), X.data(:,locs(j,i)), ...
            Orientation="horizontal",BoxWidth=boxwidth_z,BoxFaceColor=colors(i,:),MarkerColor=colors(i,:))
        boxchart(med_x(locs(j,i))*ones(size(Z.data(:,locs(j,i)))), Z.data(:,locs(j,i)), ...
            BoxWidth=boxwidth_x,BoxFaceColor=colors(i,:),MarkerColor=colors(i,:))
    end
end
xlabel("X(mm)")
ylabel("Z(mm)")
title("Color coded vertically")

subplot(1,2,2)
hold on
for i=1:7
    for j=1:7
        boxchart(med_z(locs(i,j))*ones(size(X.data(:,locs(i,j)))), X.data(:,locs(i,j)), ...
            Orientation="horizontal",BoxWidth=boxwidth_z,BoxFaceColor=colors(i,:),MarkerColor=colors(i,:))
        boxchart(med_x(locs(i,j))*ones(size(Z.data(:,locs(i,j)))), Z.data(:,locs(i,j)), ...
            BoxWidth=boxwidth_x,BoxFaceColor=colors(i,:),MarkerColor=colors(i,:))
    end
end
xlabel("X(mm)")
ylabel("Z(mm)")
title("Color coded horizontally")

sgtitle(join([joint,condition,direction])+" boxplot of X and Z")
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
savefile = savefolder+direction+"\"+joint+"\"+joint+"_"+condition+"_boxplot_2.png";
saveas(gcf,savefile)

% figure(3)
% % Z
% subplot(1,2,1)
% hold on
% Plot_Boxplot(joint,condition,direction,Z,locs,colors,xvalues,yvalues)
% 
% % X
% subplot(1,2,2)
% hold on
% Plot_Boxplot(joint,condition,direction,X,locs,colors,xvalues,yvalues)
% 
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% savefile = savefolder+direction+"\"+joint+"\"+joint+"_"+condition+"_boxplot.png";
% saveas(gcf,savefile)

function []= Plot_Boxplot(joint,condition,direction,xyz,locs,colors,xvalues,yvalues)
if xyz.name == "X"
    for i=1:7
    ax = boxplot(xyz.data(:,locs(:,i)),Orientation="horizontal",Labels=yvalues,Colors=colors(i,:));
    axs.("a"+num2str(i)) = ax;
    end
    xlabel(xyz.name+"(mm)")
    ylabel("#Reach (Not Real Z)")
elseif xyz.name == "Z"
for i=1:7
    ax = boxplot(xyz.data(:,locs(i,:)),Labels=xvalues,Colors=colors(i,:));
    axs.("a"+num2str(i)) = ax;
end
ylabel(xyz.name+"(mm)")
xlabel("#Reach (Not Real X)")
% elseif xyz.name == "Y"
%     for i=1:2
%     ax = boxplot(xyz.data(:,locs(:,i)),Labels=xvalues,Colors=colors(i,:),Orientation="horizontal");
%     axs.("a"+num2str(i)) = ax;
%     end
% ylabel(xyz.name+"(mm)")
% xlabel("#Reach (Not Real X)")
end

title(join([joint,condition,direction,xyz.name])+" boxplot")
set(findobj(gca,'type','line'),'linew',1)
for i=1:7
h = findobj(axs.("a"+i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),colors(i,:),FaceColor=colors(i,:),FaceAlpha=0.1,EdgeColor=colors(i,:));
    end
end
end



