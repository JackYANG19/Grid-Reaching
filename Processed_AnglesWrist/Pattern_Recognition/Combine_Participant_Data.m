% Combine Data From Multiple Participants

clear

Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\MeanAngle_Arrays_2'

Participant = '\P09';
load([Path,Participant,'_healthy_v_Mean.mat'])

P09_v_healthy_Elbow_Mean = Elbow_mean_Array;
P09_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P09_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P09_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P10';
load([Path,Participant,'_healthy_v_Mean.mat'])

P10_v_healthy_Elbow_Mean = Elbow_mean_Array;
P10_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P10_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P10_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P11';
load([Path,Participant,'_healthy_v_Mean.mat'])

P11_v_healthy_Elbow_Mean = Elbow_mean_Array;
P11_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P11_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P11_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P13';
load([Path,Participant,'_healthy_v_Mean.mat'])

P13_v_healthy_Elbow_Mean = Elbow_mean_Array;
P13_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P13_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P13_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P14';
load([Path,Participant,'_healthy_v_Mean.mat'])

P14_v_healthy_Elbow_Mean = Elbow_mean_Array;
P14_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P14_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P14_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P15';
load([Path,Participant,'_healthy_v_Mean.mat'])

P15_v_healthy_Elbow_Mean = Elbow_mean_Array;
P15_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P15_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P15_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P16';
load([Path,Participant,'_healthy_v_Mean.mat'])

P16_v_healthy_Elbow_Mean = Elbow_mean_Array;
P16_v_healthy_ShX_Mean = Shoulder_mean_Array_X;
P16_v_healthy_ShY_Mean = Shoulder_mean_Array_Y;
P16_v_healthy_ShZ_Mean = Shoulder_mean_Array_Y;




%% ---- Brace 1 Condition --- %%

Participant = '\P09';
load([Path,Participant,'_brace1_v_Mean.mat'])

P09_v_brace1_Elbow_Mean = Elbow_mean_Array;
P09_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P09_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P09_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P10';
load([Path,Participant,'_brace1_v_Mean.mat'])

P10_v_brace1_Elbow_Mean = Elbow_mean_Array;
P10_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P10_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P10_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P11';
load([Path,Participant,'_brace1_v_Mean.mat'])

P11_v_brace1_Elbow_Mean = Elbow_mean_Array;
P11_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P11_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P11_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P13';
load([Path,Participant,'_brace1_v_Mean.mat'])

P13_v_brace1_Elbow_Mean = Elbow_mean_Array;
P13_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P13_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P13_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;


Participant = '\P14';
load([Path,Participant,'_brace1_v_Mean.mat'])

P14_v_brace1_Elbow_Mean = Elbow_mean_Array;
P14_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P14_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P14_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P15';
load([Path,Participant,'_brace1_v_Mean.mat'])

P15_v_brace1_Elbow_Mean = Elbow_mean_Array;
P15_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P15_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P15_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P16';
load([Path,Participant,'_brace1_v_Mean.mat'])

P16_v_brace1_Elbow_Mean = Elbow_mean_Array;
P16_v_brace1_ShX_Mean = Shoulder_mean_Array_X;
P16_v_brace1_ShY_Mean = Shoulder_mean_Array_Y;
P16_v_brace1_ShZ_Mean = Shoulder_mean_Array_Y;


%% ---- Brace 2 Condition --- %%

Participant = '\P09';
load([Path,Participant,'_brace2_v_Mean.mat'])

P09_v_brace2_Elbow_Mean = Elbow_mean_Array;
P09_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P09_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P09_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P10';
load([Path,Participant,'_brace2_v_Mean.mat'])

P10_v_brace2_Elbow_Mean = Elbow_mean_Array;
P10_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P10_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P10_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P11';
load([Path,Participant,'_brace2_v_Mean.mat'])

P11_v_brace2_Elbow_Mean = Elbow_mean_Array;
P11_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P11_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P11_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P13';
load([Path,Participant,'_brace2_v_Mean.mat'])

P13_v_brace2_Elbow_Mean = Elbow_mean_Array;
P13_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P13_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P13_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;


Participant = '\P14';
load([Path,Participant,'_brace2_v_Mean.mat'])

P14_v_brace2_Elbow_Mean = Elbow_mean_Array;
P14_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P14_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P14_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P15';
load([Path,Participant,'_brace2_v_Mean.mat'])

P15_v_brace2_Elbow_Mean = Elbow_mean_Array;
P15_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P15_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P15_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;

Participant = '\P16';
load([Path,Participant,'_brace2_v_Mean.mat'])

P16_v_brace2_Elbow_Mean = Elbow_mean_Array;
P16_v_brace2_ShX_Mean = Shoulder_mean_Array_X;
P16_v_brace2_ShY_Mean = Shoulder_mean_Array_Y;
P16_v_brace2_ShZ_Mean = Shoulder_mean_Array_Y;



%% --- Combine into Master Arrays --- %%

Pn_v_Unim_Elbow(:,:,1) = P09_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,2) = P10_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,3) = P11_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,4) = P13_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,5) = P14_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,6) = P15_v_healthy_Elbow_Mean;
Pn_v_Unim_Elbow(:,:,7) = P16_v_healthy_Elbow_Mean;

Pn_v_Unim_ShX(:,:,1) = P09_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,2) = P10_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,3) = P11_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,4) = P13_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,5) = P14_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,6) = P15_v_healthy_ShX_Mean;
Pn_v_Unim_ShX(:,:,7) = P16_v_healthy_ShX_Mean;

Pn_v_Unim_ShY(:,:,1) = P09_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,2) = P10_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,3) = P11_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,4) = P13_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,5) = P14_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,6) = P15_v_healthy_ShY_Mean;
Pn_v_Unim_ShY(:,:,7) = P16_v_healthy_ShY_Mean;

Pn_v_Unim_ShZ(:,:,1) = P09_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,2) = P10_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,3) = P11_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,4) = P13_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,5) = P14_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,6) = P15_v_healthy_ShZ_Mean;
Pn_v_Unim_ShZ(:,:,7) = P16_v_healthy_ShZ_Mean;

%% ---- Master Brace 1 ---- %%


Pn_v_Brac1_Elbow(:,:,1) = P09_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,2) = P10_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,3) = P11_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,4) = P13_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,5) = P14_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,6) = P15_v_brace1_Elbow_Mean;
Pn_v_Brac1_Elbow(:,:,7) = P16_v_brace1_Elbow_Mean;


Pn_v_Brac1_ShX(:,:,1) = P09_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,2) = P10_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,3) = P11_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,4) = P13_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,5) = P14_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,6) = P15_v_brace1_ShX_Mean;
Pn_v_Brac1_ShX(:,:,7) = P16_v_brace1_ShX_Mean;

Pn_v_Brac1_ShY(:,:,1) = P09_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,2) = P10_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,3) = P11_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,4) = P13_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,5) = P14_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,6) = P15_v_brace1_ShY_Mean;
Pn_v_Brac1_ShY(:,:,7) = P16_v_brace1_ShY_Mean;


Pn_v_Brac1_ShZ(:,:,1) = P09_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,2) = P10_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,3) = P11_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,4) = P13_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,5) = P14_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,6) = P15_v_brace1_ShZ_Mean;
Pn_v_Brac1_ShZ(:,:,7) = P16_v_brace1_ShZ_Mean;



%% ---- Master Brace 2 ---- %%

Pn_v_Brac2_Elbow(:,:,1) = P09_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,2) = P10_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,3) = P11_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,4) = P13_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,5) = P14_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,6) = P15_v_brace2_Elbow_Mean;
Pn_v_Brac2_Elbow(:,:,7) = P16_v_brace2_Elbow_Mean;

Pn_v_Brac2_ShX(:,:,1) = P09_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,2) = P10_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,3) = P11_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,4) = P13_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,5) = P14_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,6) = P15_v_brace2_ShX_Mean;
Pn_v_Brac2_ShX(:,:,7) = P16_v_brace2_ShX_Mean;

Pn_v_Brac2_ShY(:,:,1) = P09_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,2) = P10_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,3) = P11_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,4) = P13_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,5) = P14_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,6) = P15_v_brace2_ShY_Mean;
Pn_v_Brac2_ShY(:,:,7) = P16_v_brace2_ShY_Mean;

Pn_v_Brac2_ShZ(:,:,1) = P09_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,2) = P10_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,3) = P11_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,4) = P13_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,5) = P14_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,6) = P15_v_brace2_ShZ_Mean;
Pn_v_Brac2_ShZ(:,:,7) = P16_v_brace2_ShZ_Mean;
