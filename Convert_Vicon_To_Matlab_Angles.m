% Interpret Yuri's ISB Output into Matlab Variables and adds Wrist XYZ
% Saves '_Processed_AnglesWrist' into Processed_Data Folder

clear

%Name_Prefix = 'P16_brace1_v'
%Name_Prefix = 'P16_brace2_v'
%Name_Prefix = 'P16_healthy_h'
%Name_Prefix = 'P18_healthy_h'
Name_Prefix = 'P18r_amputee_h'


% Load virtual wrist
Filename = strcat('Raw_Data\virtualWrist\',Name_Prefix,'_WristXYZ.mat');
load(Filename);

WristR_Mid = [Wrist_X,Wrist_Y,Wrist_Z];

% % Load Angles (This loads a different Wrist_X, Wrist_Y, Wrist_Z)
Filename = strcat('Raw_Data\Angles\',Name_Prefix,'_Angles.mat');
load(Filename);

% -- Group and Name Variables --- %

RElbow_Angle = Elbow;
RShoulder_Angle = [Shoulder_X,Shoulder_Y,Shoulder_Z];
RWrist_Angle = [Wrist_X,Wrist_Y,Wrist_Z];
Trunk_Angle = [Torso_X,Torso_Y,Torso_Z];

Frame = 1:length(Elbow)';

% -- Save as .mat file -- %
save(strcat('Processed_AnglesWrist\',Name_Prefix,'_Processed_AnglesWrist'),'Frame','RElbow_Angle','RShoulder_Angle','RWrist_Angle','Trunk_Angle','WristR_Mid')

%--------------------------------------%

set(0,'defaultlinelinewidth',2)

figure(1)
clf
subplot(5,1,1)
    hold on
    grid on
    title('Wrist Pos')
    plot(Frame,WristR_Mid(:,1),':')
   plot(Frame,WristR_Mid(:,2))
    plot(Frame,WristR_Mid(:,3),':')

    legend('X','Y','Z')

subplot(5,1,2)
    hold on
    grid on
    title('Shoulder Angle')
    plot(RShoulder_Angle(:,1))
    plot(RShoulder_Angle(:,2))
    plot(RShoulder_Angle(:,3))
    legend('X','Y','Z')
    
subplot(5,1,3)
hold on
grid on
title('Elbow Angle')
%plot(RElbow_Angle(:,1))
plot(RElbow_Angle)
legend('X')
%plot(RElbow_Angle(:,3))

subplot(5,1,4)
hold on
grid on
title('Wrist Angle')
plot(RWrist_Angle(:,1))
plot(RWrist_Angle(:,2))
plot(RWrist_Angle(:,3))

legend('X','Y','Z')

subplot(5,1,5)
hold on
grid on
title('Trunk Angle')
plot(Trunk_Angle(:,1))
plot(Trunk_Angle(:,2))
plot(Trunk_Angle(:,3))
legend('X','Y','Z')

figure(2)
clf
hold on
plot3(WristR_Mid(:,1),WristR_Mid(:,2),WristR_Mid(:,3))
%plot3(WristL_Mid(:,1),WristL_Mid(:,2),WristL_Mid(:,3))
zlabel('z')
ylabel('y')
xlabel('x')
view(3)
grid on

