clear

% ==== Load Mean Angle Data for one experiment === %

%Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\MeanAngle_Arrays_2';

Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\ROM_Arrays_2';

Participant = '\P2';
%load([Path,Participant,'_healthy_v_Mean.mat'])

% Elbow_A = Elbow_mean_Array;
% Sh_Y_A = Shoulder_mean_Array_Y;
% Sh_X_A = Shoulder_mean_Array_X;

Participant = '\PNA';
load([Path,Participant,'_healthy_v_ROM.mat'])
load([Path,Participant,'_brace1_vh_ROM.mat'])
load([Path,Participant,'_brace2_vh_ROM.mat'])

% This loads the mean angles for the matrix of targets
% Elbow_U = PNA_healthy_v_Elbow_mAngle;
% Sh_Yv_U = PNA_healthy_v_Shoulder_Y_mAngle; 
% Sh_Xv_U = PNA_healthy_v_Shoulder_X_mAngle;
% Sh_Zv_U = PNA_healthy_v_Shoulder_Z_mAngle;

El_v_U = PNA_healthy_v_Elbow_ROM; 
Sh_Yv_U = PNA_healthy_v_Shoulder_Y_ROM; 
Sh_Xv_U = PNA_healthy_v_Shoulder_X_ROM;
Sh_Zv_U = PNA_healthy_v_Shoulder_Z_ROM;


% convert into vectors
El_v_U = reshape(El_v_U,1,7*7);
Sh_Xv_Uv = reshape(Sh_Xv_U,1,7*7);
Sh_Yv_Uv = reshape(Sh_Yv_U,1,7*7);
Sh_Zv_Uv = reshape(Sh_Zv_U,1,7*7);

%Sh_Uv = zscore([Sh_Xv_Uv' Sh_Yv_Uv' Sh_Zv_Uv']);

All_Uv = zscore([El_v_U' Sh_Xv_Uv' Sh_Yv_Uv' Sh_Zv_Uv']);


%% ----------------------- %%

% This loads the mean angles for the matrix of targets
% Elbow_U = PNA_healthy_v_Elbow_mAngle;
% Sh_Yv_B1 = PNA_brace1_v_Shoulder_Y_mAngle;
% Sh_Xv_B1 = PNA_brace1_v_Shoulder_X_mAngle;
% Sh_Zv_B1 = PNA_brace1_v_Shoulder_Z_mAngle;
% 

Sh_Yv_B1 = PNA_brace1_v_Shoulder_Y_ROM;
Sh_Xv_B1 = PNA_brace1_v_Shoulder_X_ROM;
Sh_Zv_B1 = PNA_brace1_v_Shoulder_Z_ROM;

% % % convert into vectors
Sh_Xv_B1v = reshape(Sh_Xv_B1,1,7*7);
Sh_Yv_B1v = reshape(Sh_Yv_B1,1,7*7);
Sh_Zv_B1v = reshape(Sh_Zv_B1,1,7*7);
 
Sh_B1v = zscore([Sh_Xv_B1v' Sh_Yv_B1v' Sh_Zv_B1v']);

% %% ----------------------- %%
% 
% % This loads the mean angles for the matrix of targets
% % Elbow_U = PNA_healthy_v_Elbow_mAngle;
% Sh_Yv_B2 = PNA_brace2_v_Shoulder_Y_mAngle;
% Sh_Xv_B2 = PNA_brace2_v_Shoulder_X_mAngle;
% Sh_Zv_B2 = PNA_brace2_v_Shoulder_Z_mAngle;
% 
% % % convert into vectors
% Sh_Xv_B2v = reshape(Sh_Xv_B2,1,7*7);
% Sh_Yv_B2v = reshape(Sh_Yv_B2,1,7*7);
% Sh_Zv_B2v = reshape(Sh_Zv_B2,1,7*7);
%  
% Sh_B2v = zscore([Sh_Xv_B2v' Sh_Yv_B2v' Sh_Zv_B2v']);
% 
% Class = [ones(1,49) 2*ones(1,49) 3*ones(1,49)]';
% 
%All_Data = [Sh_Uv + Sh_B1v];

All_Data = [All_Uv]

% Points of interest
%poi = [1,7,42,29];
poi= 1:49;


figure(1)
clf
subplot(1,2,1)
hold on
grid on
xlabel('Sh X')
ylabel('Sh Y')
zlabel('Sh Z')
title('Standardised Shoulder Mean Angle')
axis square 

%scatter3(Sh_Uv(poi,1),Sh_Uv(poi,2),Sh_Uv(poi,3),15,'filled')
%scatter3(Sh_B1v(poi,1),Sh_B1v(poi,2),Sh_B1v(poi,3),15,'filled')
%scatter3(Sh_B2v(poi,1),Sh_B2v(poi,2),Sh_B2v(poi,3),15,'filled')

view(3)
set(gca,'fontsize', 18)


Mean_Uv = mean(All_Uv);

%Mean_B1v = mean(Sh_B1v);
%Mean_B2v = mean(Sh_B2v)

scatter3(Mean_Uv(1),Mean_Uv(2),Mean_Uv(3),100,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','r',...
              'LineWidth',1.5)
          
scatter3(Mean_B1v(1),Mean_B1v(2),Mean_B1v(3),100,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','b',...
              'LineWidth',1.5)


subplot(2,2,2)

hold on
grid on
title('PCA')

[eigenvectors,eigenvalues] = eig(cov(All_Data));

Feature_Vector_PCA = [eigenvectors(:,3),eigenvectors(:,2)];

Recast_Sh_Uv = Sh_Uv * Feature_Vector_PCA;
Recast_Sh_B1v = Sh_B1v * Feature_Vector_PCA;
%Recast_Sh_B2v = Sh_B2v * Feature_Vector_PCA;

scatter(Recast_Sh_Uv(poi,1),Recast_Sh_Uv(poi,2),15,'filled')
scatter(Recast_Sh_B1v(poi,1),Recast_Sh_B1v(poi,2),15,'filled')
%scatter(Recast_Sh_B2v(poi,1),Recast_Sh_B2v(poi,2),15,'filled')

axis square

subplot(2,2,4)

hold on
grid on
title('LDA')

Mean_1 = Mean_Uv';
Mean_2 = Mean_B1v';

X_1 = Sh_Uv';
X_2 = Sh_B1v';

Sw1 = (X_1 - Mean_1)*(X_1 - Mean_1)'
Sw2 = (X_2 - Mean_2)*(X_2 - Mean_2)';

Sw = Sw1+Sw2;

Sb = (Mean_1 - Mean_2)*(Mean_1 - Mean_2)';

[eigenvectors,eigenvalues] = eig(inv(Sw)*Sb);

line([0 eigenvectors(1,2)*3],[0 eigenvectors(2,2)*3],'color',[0.6 0.6 0],'linewidth',2)
line([0 -eigenvectors(1,2)*3],[0 -eigenvectors(2,2)*3],'color',[0.6 0.6 0],'linewidth',2)

line([eigenvectors(2,2)*3 0],[-eigenvectors(1,2)*3 0],'color',[0.6 0 0],'linewidth',2,'linestyle','--')
line([-eigenvectors(2,2)*3 0],[eigenvectors(1,2)*3 0],'color',[0.6 0 0],'linewidth',2,'linestyle','--')

Feature_Vector_LDA = [eigenvectors(:,2),eigenvectors(:,1)];

Recast_Sh_Uv = Sh_Uv * Feature_Vector_LDA;
Recast_Sh_B1v = Sh_B1v * Feature_Vector_LDA;

scatter(Recast_Sh_Uv(poi,1),Recast_Sh_Uv(poi,2),15,'filled')
scatter(Recast_Sh_B1v(poi,1),Recast_Sh_B1v(poi,2),15,'filled')

%Recast_M = [Mean_1' Mean_2'] * Feature_Vector;

axis square
set(gca,'fontsize', 18)
