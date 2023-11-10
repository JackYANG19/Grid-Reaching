clear

% ==== Load Mean Angle Data for one experiment === %

Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\MeanAngle_Arrays_2'

Participant = '\P13';
load([Path,Participant,'_healthy_v_Mean.mat'])

Elbow_A = Elbow_mean_Array;
Sh_Y_A = Shoulder_mean_Array_Y;
Sh_X_A = Shoulder_mean_Array_X;

Participant = '\PNA';
load([Path,Participant,'_healthy_v_mAngle.mat'])

Elbow_A = PNA_healthy_v_Elbow_mAngle;
Sh_Y_A = PNA_healthy_v_Shoulder_Y_mAngle;
Sh_X_A = PNA_healthy_v_Shoulder_X_mAngle;

Elbow_A = reshape(Elbow_A,1,7*7);
Sh_Y_A = reshape(Sh_Y_A,1,7*7);
Sh_X_A = reshape(Sh_X_A,1,7*7);

Arm2_A = [Sh_Y_A;Elbow_A]';
Arm3_A = [Sh_X_A;Sh_Y_A;Elbow_A]';


%load([Path,'\P09_brace1_v_Mean.mat'])

Participant = '\PNA';
load([Path,Participant,'_brace1_v_mAngle.mat'])

Elbow_B = PNA_brace1_v_Elbow_mAngle;
Sh_Y_B =  PNA_brace1_v_Shoulder_Y_mAngle;
Sh_X_B =  PNA_brace1_v_Shoulder_X_mAngle;

% Elbow_B = Elbow_mean_Array;
% Sh_Y_B = Shoulder_mean_Array_Y;
% Sh_X_B = Shoulder_mean_Array_X;

Elbow_B = reshape(Elbow_B,1,7*7);
Sh_Y_B = reshape(Sh_Y_B,1,7*7);
Sh_X_B = reshape(Sh_X_B,1,7*7);

Arm2_B = [Sh_Y_B;Elbow_B]';
Arm3_B = [Sh_X_B;Sh_Y_B;Elbow_B]';


% load([Path,'\P09_brace2_v_Mean.mat'])
% 
% Elbow_C = Elbow_mean_Array;
% Sh_Y_C = Shoulder_mean_Array_Y;
% Sh_X_C = Shoulder_mean_Array_X;

Participant = '\PNA';
load([Path,Participant,'_brace2_v_mAngle.mat'])

Elbow_C = PNA_brace2_v_Elbow_mAngle;
Sh_Y_C =  PNA_brace2_v_Shoulder_Y_mAngle;
Sh_X_C =  PNA_brace2_v_Shoulder_X_mAngle;



Elbow_C = reshape(Elbow_C,1,7*7);
Sh_Y_C = reshape(Sh_Y_C,1,7*7);
Sh_X_C = reshape(Sh_X_C,1,7*7);

Arm2_C = [Sh_Y_C;Elbow_C]';
Arm3_C = [Sh_X_C;Sh_Y_C;Elbow_C]';




figure(1)
clf
subplot(2,1,1)
hold on
grid on
ylabel('Elbow Mean Angle')
xlabel('Shoulder Y Mean Angle')
axis square 

%scatter(Sh_Y,Elbow,25,'filled','r')
%scatter(Sh_Y(1),Elbow(1),25,'filled','b')

scatter(Arm2_A(:,1),Arm2_A(:,2),25,'filled','r')
scatter(Arm2_B(:,1),Arm2_B(:,2),25,'filled','b')
scatter(Arm2_C(:,1),Arm2_C(:,2),25,'filled','k')

legend('Unimpaired','Brace 1', 'Brace 2')

% subplot(2,2,2)
% hold on
% grid on
% zlabel('Elbow Mean Angle')
% ylabel('Shoulder Y Mean Angle')
% xlabel('Shoulder X Mean Angle')
% 
% axis equal 
% 
% scatter3(Sh_X,Sh_Y,Elbow,25,'filled','r')
% scatter3(Sh_X(1),Sh_Y(1),Elbow(1),25,'filled','b')
% view(3)

% ===== PCA Part 2D ===== %

% find the principle components for the data
coeff = pca(Arm2_A)

% find the principle component coefficients, scores, and variances 
[coeff_A,score_A,latent_A] = pca(Arm2_A);
[coeff_B,score_B,latent_B] = pca(Arm2_B);
[coeff_C,score_C,latent_C] = pca(Arm2_C);

%Reconstruct the centered measurements data.
Xcentered_A = score_A*coeff'
Xcentered_B = score_B*coeff'
Xcentered_C = score_C*coeff'


subplot(2,1,2)
hold on
grid on
title('PCA')

hPlot1 = biplot(coeff_A(:,1:2),'scores',score_A(:,1:2),'varlabels',{'v_1A','v_2A'});
set( hPlot1, 'Color', 'r' )

hPlot2 = biplot(coeff_B(:,1:2),'scores',score_B(:,1:2),'varlabels',{'v_1B','v_2B'});
set( hPlot1, 'Color', 'b' )

hPlot3 = biplot(coeff_C(:,1:2),'scores',score_C(:,1:2),'varlabels',{'v_1C','v_2C'});
set( hPlot1, 'Color', 'k' )

axis square 

% % ===== PCA Part 3D ===== %
% 
% % find the principle components for the data
% coeff = pca(Arm3)
% 
% % find the principle component coefficients, scores, and variances 
% [coeff,score,latent] = pca(Arm3);
% 
% %Reconstruct the centered measurements data.
% Xcentered = score*coeff';
% 
% subplot(2,2,4)
% hold on
% grid on
% biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',{'v_1','v_2','v_3'});
% axis equal 
% view(3)