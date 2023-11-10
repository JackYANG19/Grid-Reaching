clear
close all

%% Pre-defined
colors = [0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880;
    0.3010 0.7450 0.9330;
    0.6350 0.0780 0.1840];

subjects = ["P09","P10","P11","P13","P14","P15","P16"];
conditions = ["Healthy","Brace1","Brace2"];
joints = ["Wrist","Elbow","Shoulder","Throax","Pelvis"];
foldername = "D:\1_Project\1_Reaching\Data\End_Joint_Location\";
directions = ["v","h"];

%% Load files
norm_flag = 1; % 0 1

all_data.norm_flag = norm_flag;
for i=1:length(directions)
    direction = directions(i);
    all_data = Final_Pose(foldername,direction,norm_flag,all_data);
end


% Save files
% if norm_flag==0
%     save(foldername+"all_data","all_data")
% elseif norm_flag==1
%     save(foldername+"all_data_norm","all_data")
% end


%% Plot

% 1:wrist 2:elbow 3:shoulder 4:throax 5:pelvis
joint = "elbow";

% 1:healthy 2:brace1 3:brace2
% 4:healthy_brace1 5:healthy_brace2 6:brace1_brace2
% 7:healthy_brace1_brace2
condition = "healthy";
plot_direction = "h";

% subject or sondition
based_on = "subject";

sub1=1; % 1
sub2=7; % 7
num1 = 33; % 1
num2 = 33; % 49

cond_vect = [0,0,0];
conds = split(condition,"_");
if sum(ismember("healthy",conds)) > 0
    cond_vect(1) = 1;
end
if sum(ismember("brace1",conds)) > 0
    cond_vect(2) = 1;
end
if sum(ismember("brace2",conds)) > 0
    cond_vect(3) = 1;
end

target = double.empty(0,3,7);
reference = double.empty(0,3,7);
for i=1:length(conds)
    target = cat(1,target,all_data.(joint).(conds(i)).(plot_direction).target);
    reference = cat(1,reference,all_data.(joint).(conds(i)).(direction).reference);
end

plot_title = "subject " + sub1 + " to " + sub2 + " / " + join(conds) + " / " + joint + " / reach " + num1 + " to " + num2 + " " + plot_direction;
Plot_All(based_on,plot_title,target,reference,sub1,sub2,num1,num2,cond_vect,norm_flag,colors,subjects,conditions)

% Title = "Subject " + sub1 + " to " + sub2 + " / " + Joint + " / Reach " + num1 + " to " + num2;
% Plot_Cond(Title,Wr_All,sub1,sub2,num1,num2)


%% Functions

% Plot base on subject

function [] = Plot_All(based_on,plot_title,target,reference,sub1,sub2,num1,num2,cond_vect,ref_flag,colors,subjects,conditions)

title(plot_title);
hold on;
grid on;

if ref_flag == 0
    GRIDY = 0;
    Plot_H_Grid(GRIDY);
    axis([-1000, 1500, -1500, 1000, -1000, 1500]);
elseif ref_flag == 1
    axis([-1000, 1000, -1000, 1000, -1000, 1500]);
end

axs = [];

if based_on == "subject"
    for i = sub1:sub2
        for c = 1:sum(cond_vect)
            scatter3(reference(:, 1, i), reference(:, 2, i), reference(:, 3, i), 100, colors(i, :), "filled", "pentagram");
            for j = num1 + 49 * (c - 1):num2 + 49 * (c - 1)
                ax = scatter3(target(j, 1, i), target(j, 2, i), target(j, 3, i), [], colors(i, :), "filled");
            end
        end
        axs = cat(1, axs, ax);
    end
    legend(axs, subjects(sub1:sub2), 'Location', 'best');

elseif based_on == "condition"
    for c = 1:sum(cond_vect)
        for i = sub1:sub2
            scatter3(reference(c, 1, i), reference(c, 2, i), reference(c, 3, i), 100, colors(c, :), "filled", "pentagram");
            for j = num1 + 49 * (c - 1):num2 + 49 * (c - 1)
                ax = scatter3(target(j, 1, i), target(j, 2, i), target(j, 3, i), [], colors(c, :), "filled");
            end
        end
        axs = cat(1, axs, ax);
    end
    legend(axs, conditions(cond_vect > 0), 'Location', 'best');
end


% axis equal

xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
view(30, 10)
end



function [] = Plot_Single_Loc(Time_Step, filename, Wr_Ed, Elb_Ed, Sh_Ed, Thrx_Ed, Pv_Ed, He_Ed)
for i = 1:length(Time_Step)

    clf
    C = split(filename,"_");

    title(join(C(1:3)) + " Reach " + i)
    hold on
    grid on

    % Grid
    GRIDY = 0;
    Plot_H_Grid(GRIDY)
    % Origins (reaach is from right to left)
    scatter3(Wr_Ed(i,1),Wr_Ed(i,2),Wr_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Elb_Ed(i,1),Elb_Ed(i,2),Elb_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Sh_Ed(i,1),Sh_Ed(i,2),Sh_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Thrx_Ed(i,1),Thrx_Ed(i,2),Thrx_Ed(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(Pv_Ed(i,1),Pv_Ed(i,2),Pv_Ed(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(He_Ed(i,1),He_Ed(i,2),He_Ed(i,3),40,'MarkerFaceColor','b','MarkerEdgeColor','b');

    % Fake leg (600mm from the grid)
    RX = 150;
    RY = -600; % -400 for P11 -600 for others
    RZ = -675;

    LX = -50;
    LY = -600; % -400 for P11 -600 for others
    LZ = -675;

    scatter3(RX,RY,RZ,'MarkerFaceColor','k','MarkerEdgeColor','k')
    scatter3(LX,LY,LZ,'MarkerFaceColor','k','MarkerEdgeColor','k')

    % Connections
    plot3([Wr_Ed(i,1), Elb_Ed(i,1)], [Wr_Ed(i,2), Elb_Ed(i,2)], [Wr_Ed(i,3), Elb_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Elb_Ed(i,1), Sh_Ed(i,1)], [Elb_Ed(i,2), Sh_Ed(i,2)], [Elb_Ed(i,3), Sh_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Sh_Ed(i,1), Thrx_Ed(i,1)], [Sh_Ed(i,2), Thrx_Ed(i,2)], [Sh_Ed(i,3), Thrx_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_Ed(i,1), He_Ed(i,1)], [Thrx_Ed(i,2), He_Ed(i,2)], [Thrx_Ed(i,3), He_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_Ed(i,1), Pv_Ed(i,1)], [Thrx_Ed(i,2), Pv_Ed(i,2)], [Thrx_Ed(i,3), Pv_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Pv_Ed(i,1), RX], [Pv_Ed(i,2), RY], [Pv_Ed(i,3), RZ],'linewidth',2,'Color','k','LineStyle','--')
    plot3([Pv_Ed(i,1), LX], [Pv_Ed(i,2), LY], [Pv_Ed(i,3), LZ],'linewidth',2,'Color','k','LineStyle','--')

    axis([-1000,1500,-1500,500,-1000,1500])
    axis equal

    xlabel('X(mm)')
    ylabel('Y(mm)')
    zlabel('Z(mm)')
    view(30, 10)

    pause(0.25)
end
end

function [] = Plot_H_Grid(GRIDY)
% Horizontal Lines
line([-900 900],[GRIDY GRIDY],[1300 1300],'color','k','linestyle','--','linewidth',2)
line([-900 900],[GRIDY GRIDY],[1000 1000],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[700 700],'color','k','linestyle','--','linewidth',1)
%center
line([-900 900],[GRIDY GRIDY],[400 400],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[100 100],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[-200 -200],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[-500 -500],'color','k','linestyle','--','linewidth',2)

% Vertical Lines
line([900 900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)
line([-900 -900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)

end


function [all_data]=Final_Pose(foldername,direction,norm_flag,all_data)

healthy_files = dir(foldername + "*healthy_" + direction + "_End_Loc.mat");
brace1_files = dir(foldername + "*brace1_" + direction + "_End_Loc.mat");
brace2_files = dir(foldername + "*brace2_" + direction + "_End_Loc.mat");
load("D:\1_Project\1_Reaching\Data\Start_Joint_Location\Healthy_" + direction + "_Ref.mat")
load("D:\1_Project\1_Reaching\Data\Start_Joint_Location\Brace1_" + direction + "_Ref.mat")
load("D:\1_Project\1_Reaching\Data\Start_Joint_Location\Brace2_" + direction + "_Ref.mat")


% Healthy
Time_healthy = double.empty(49,0);
Wr_healthy = double.empty(49, 3, 0);
Elb_healthy = double.empty(49, 3, 0);
Sh_healthy = double.empty(49, 3, 0);
Thrx_healthy = double.empty(49, 3, 0);
Pv_healthy = double.empty(49, 3, 0);

for i=1:length(healthy_files)
    healthy_filename = healthy_files(i).name;
    load(foldername + healthy_filename)
    Wr_healthy = cat(3,Wr_healthy,Wr_Ed); % 49 3 7
    Elb_healthy = cat(3,Elb_healthy,Elb_Ed);
    Sh_healthy = cat(3,Sh_healthy,Sh_Ed);
    Thrx_healthy = cat(3,Thrx_healthy,Thrx_Ed);
    Pv_healthy = cat(3,Pv_healthy,Pv_Ed);
    Time_healthy = cat(2,Time_healthy,Time_Step);
end

% Brace1
Time_brace1 = double.empty(49,0);
Wr_brace1 = double.empty(49, 3, 0);
Elb_brace1 = double.empty(49, 3, 0);
Sh_brace1 = double.empty(49, 3, 0);
Thrx_brace1 = double.empty(49, 3, 0);
Pv_brace1 = double.empty(49, 3, 0);

for i=1:length(brace1_files)
    brace1_filename = brace1_files(i).name;
    load(foldername + brace1_filename)
    Wr_brace1 = cat(3,Wr_brace1,Wr_Ed); % 49 3 7
    Elb_brace1 = cat(3,Elb_brace1,Elb_Ed);
    Sh_brace1 = cat(3,Sh_brace1,Sh_Ed);
    Thrx_brace1 = cat(3,Thrx_brace1,Thrx_Ed);
    Pv_brace1 = cat(3,Pv_brace1,Pv_Ed);
    Time_brace1 = cat(2,Time_brace1,Time_Step);
end

% Brace2
Time_brace2 = double.empty(49,0);
Wr_brace2 = double.empty(49, 3, 0);
Elb_brace2 = double.empty(49, 3, 0);
Sh_brace2 = double.empty(49, 3, 0);
Thrx_brace2 = double.empty(49, 3, 0);
Pv_brace2 = double.empty(49, 3, 0);

for i=1:length(brace2_files)
    brace2_filename = brace2_files(i).name;
    load(foldername + brace2_filename)
    Wr_brace2 = cat(3,Wr_brace2,Wr_Ed); % 49 3 7
    Elb_brace2 = cat(3,Elb_brace2,Elb_Ed);
    Sh_brace2 = cat(3,Sh_brace2,Sh_Ed);
    Thrx_brace2 = cat(3,Thrx_brace2,Thrx_Ed);
    Pv_brace2 = cat(3,Pv_brace2,Pv_Ed);
    Time_brace2 = cat(2,Time_brace2,Time_Step);
end


% wrist
all_data.wrist.healthy.(direction).target = Wr_healthy-Wr_healthy_ref*norm_flag;
all_data.wrist.healthy.(direction).reference = Wr_healthy_ref-Wr_healthy_ref*norm_flag;
all_data.wrist.brace1.(direction).target = Wr_brace1-Wr_brace1_ref*norm_flag;
all_data.wrist.brace1.(direction).reference = Wr_brace1_ref-Wr_brace1_ref*norm_flag;
all_data.wrist.brace2.(direction).target = Wr_brace2-Wr_brace2_ref*norm_flag;
all_data.wrist.brace2.(direction).reference = Wr_brace2_ref-Wr_brace2_ref*norm_flag;

% elbow
all_data.elbow.healthy.(direction).target = Elb_healthy-Elb_healthy_ref*norm_flag;
all_data.elbow.healthy.(direction).reference = Elb_healthy_ref-Elb_healthy_ref*norm_flag;
all_data.elbow.brace1.(direction).target = Elb_brace1-Elb_brace1_ref*norm_flag;
all_data.elbow.brace1.(direction).reference = Elb_brace1_ref-Elb_brace1_ref*norm_flag;
all_data.elbow.brace2.(direction).target = Elb_brace2-Elb_brace2_ref*norm_flag;
all_data.elbow.brace2.(direction).reference = Elb_brace2_ref-Elb_brace2_ref*norm_flag;

% shoulder
all_data.shoulder.healthy.(direction).target = Sh_healthy-Sh_healthy_ref*norm_flag;
all_data.shoulder.healthy.(direction).reference = Sh_healthy_ref-Sh_healthy_ref*norm_flag;
all_data.shoulder.brace1.(direction).target = Sh_brace1-Sh_brace1_ref*norm_flag;
all_data.shoulder.brace1.(direction).reference = Sh_brace1_ref-Sh_brace1_ref*norm_flag;
all_data.shoulder.brace2.(direction).target = Sh_brace2-Sh_brace2_ref*norm_flag;
all_data.shoulder.brace2.(direction).reference = Sh_brace2_ref-Sh_brace2_ref*norm_flag;

% thorax
all_data.thorax.healthy.(direction).target = Thrx_healthy-Thrx_healthy_ref*norm_flag;
all_data.thorax.healthy.(direction).reference = Thrx_healthy_ref-Thrx_healthy_ref*norm_flag;
all_data.thorax.brace1.(direction).target = Thrx_brace1-Thrx_brace1_ref*norm_flag;
all_data.thorax.brace1.(direction).reference = Thrx_brace1_ref-Thrx_brace1_ref*norm_flag;
all_data.thorax.brace2.(direction).target = Thrx_brace2-Thrx_brace2_ref*norm_flag;
all_data.thorax.brace2.(direction).reference = Thrx_brace2_ref-Thrx_brace2_ref*norm_flag;

% pelvis
all_data.pelvis.healthy.(direction).target = Pv_healthy-Pv_healthy_ref*norm_flag;
all_data.pelvis.healthy.(direction).reference = Pv_healthy_ref-Pv_healthy_ref*norm_flag;
all_data.pelvis.brace1.(direction).target = Pv_brace1-Pv_brace1_ref*norm_flag;
all_data.pelvis.brace1.(direction).reference = Pv_brace1_ref-Pv_brace1_ref*norm_flag;
all_data.pelvis.brace2.(direction).target = Pv_brace2-Pv_brace2_ref*norm_flag;
all_data.pelvis.brace2.(direction).reference = Pv_brace2_ref-Pv_brace2_ref*norm_flag;

end
