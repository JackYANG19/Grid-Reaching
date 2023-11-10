close all
clear

%% Load files
joints = ["wrist","elbow","shoulder","thorax","pelvis"];

direction = "v";
joint = joints(5);

foldername = "D:\1_Project\1_Reaching\Data\Clustering\Hierarchical\"+direction+"\";
load(foldername+joint)

target = "best_method"; % "minkowski_2_complete" "best_method"
method = results.(target).name;
accuracies = results.(target).accuracies;
cophenetics = results.(target).cophenetics;


% Get Average
accuracy_ave = mean(accuracies);
cophenetic_ave = mean(cophenetics);

% Heatmap
[acc_h,cop_h]=Plot_Heatmap(joint,method,direction,accuracies,cophenetics,accuracy_ave,cophenetic_ave);

function [acc_h,cop_h]=Plot_Heatmap(joint,method,direction,accuracies,cophenetics,accuracy_ave,cophenetic_ave)
accuracies_square = zeros(7,7);
cophenetics_square = zeros(7,7);

for i=1:7
    accuracies_square(i,1:7) = accuracies(1,1+(7*(i-1)):7+(7*(i-1)));
    cophenetics_square(i,1:7) = cophenetics(1,1+(7*(i-1)):7+(7*(i-1)));
end

accuracies_square = fliplr(accuracies_square);
cophenetics_square = fliplr(cophenetics_square);

xvalues  = {'7','6','5','4','3','2','1'};
yvalues  = {'7','14','21','28','35','42','49'};


figure(1)
cop_h = heatmap(xvalues,yvalues,cophenetics_square);
figure(2)
acc_h = heatmap(xvalues,yvalues,accuracies_square);

acc_h.Title = join([joint,join(split(method,"_")),direction,"accuracy (Ave: ",accuracy_ave,")"]);
cop_h.Title = join([joint,join(split(method,"_")),direction,"cophenetic (Ave: ",cophenetic_ave,")"]);
end

