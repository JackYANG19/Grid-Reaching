close all
clear

%% Load files
direction = "v";
foldername = "D:\1_Project\1_Reaching\Data\Start_Joint_Location\";
healthy_files = dir(foldername + "*healthy_" + direction + "_Start_Loc.mat")
brace1_files = dir(foldername + "*brace1_" + direction + "_Start_Loc.mat");
brace2_files = dir(foldername + "*brace2_" + direction + "_Start_Loc.mat");

% Healthy
Wr_healthy_ref = double.empty(1, 3, 0);
Elb_healthy_ref = double.empty(1, 3, 0);
Sh_healthy_ref = double.empty(1, 3, 0);
Thrx_healthy_ref = double.empty(1, 3, 0);
Pv_healthy_ref = double.empty(1, 3, 0);

for i=1:length(healthy_files)
    healthy_filename = healthy_files(i).name;
    load(foldername + healthy_filename)
    Wr_healthy_ref = cat(3,Wr_healthy_ref,mean(Wr_ST));
    Elb_healthy_ref = cat(3,Elb_healthy_ref,mean(Elb_ST));
    Sh_healthy_ref = cat(3,Sh_healthy_ref,mean(Sh_ST));
    Thrx_healthy_ref = cat(3,Thrx_healthy_ref,mean(Thrx_ST));
    Pv_healthy_ref = cat(3,Pv_healthy_ref,mean(Pv_ST));
end

% Brace1
Wr_brace1_ref = double.empty(1, 3, 0);
Elb_brace1_ref = double.empty(1, 3, 0);
Sh_brace1_ref = double.empty(1, 3, 0);
Thrx_brace1_ref = double.empty(1, 3, 0);
Pv_brace1_ref = double.empty(1, 3, 0);

for i=1:length(brace1_files)
    brace1_filename = brace1_files(i).name;
    load(foldername + brace1_filename)
    Wr_brace1_ref = cat(3,Wr_brace1_ref,mean(Wr_ST));
    Elb_brace1_ref = cat(3,Elb_brace1_ref,mean(Elb_ST));
    Sh_brace1_ref = cat(3,Sh_brace1_ref,mean(Sh_ST));
    Thrx_brace1_ref = cat(3,Thrx_brace1_ref,mean(Thrx_ST));
    Pv_brace1_ref = cat(3,Pv_brace1_ref,mean(Pv_ST));
end

% Brace2
Wr_brace2_ref = double.empty(1, 3, 0);
Elb_brace2_ref = double.empty(1, 3, 0);
Sh_brace2_ref = double.empty(1, 3, 0);
Thrx_brace2_ref = double.empty(1, 3, 0);
Pv_brace2_ref = double.empty(1, 3, 0);

for i=1:length(brace2_files)
    brace2_filename = brace2_files(i).name;
    load(foldername + brace2_filename)
    Wr_brace2_ref = cat(3,Wr_brace2_ref,mean(Wr_ST));
    Elb_brace2_ref = cat(3,Elb_brace2_ref,mean(Elb_ST));
    Sh_brace2_ref = cat(3,Sh_brace2_ref,mean(Sh_ST));
    Thrx_brace2_ref = cat(3,Thrx_brace2_ref,mean(Thrx_ST));
    Pv_brace2_ref = cat(3,Pv_brace2_ref,mean(Pv_ST));
end

HealthyRefFile = "Start_Joint_Location\Healthy_" + direction + "_Ref";
save(HealthyRefFile, "Wr_healthy_ref","Pv_healthy_ref","Thrx_healthy_ref","Sh_healthy_ref","Elb_healthy_ref");
Brace1RefFile = "Start_Joint_Location\Brace1_" + direction + "_Ref";
save(Brace1RefFile, "Wr_brace1_ref","Pv_brace1_ref","Thrx_brace1_ref","Sh_brace1_ref","Elb_brace1_ref");
Brace2RefFile = "Start_Joint_Location\Brace2_" + direction + "_Ref";
save(Brace2RefFile, "Wr_brace2_ref","Pv_brace2_ref","Thrx_brace2_ref","Sh_brace2_ref","Elb_brace2_ref");

