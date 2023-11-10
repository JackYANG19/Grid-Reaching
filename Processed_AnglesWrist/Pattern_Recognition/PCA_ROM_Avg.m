clear
% Takes PCA of all joint angles to make 1 value'

% ==== Load Mean Angle Data for one experiment === %

%Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\MeanAngle_Arrays_2';

Path = 'C:\Users\braks\Dropbox\Yale Grid Reaching Shared\Analysis\Grid_Reaching_2020\ROM_Arrays_2';

%Path = '..\ROM_Arrays_2';

Participant = '\PNA';
load([Path,Participant,'_healthy_v_ROM.mat'])
load([Path,Participant,'_healthy_h_ROM.mat'])

load([Path,Participant,'_brace1_vh_ROM.mat'])
load([Path,Participant,'_brace2_vh_ROM.mat'])

% healthy vertical
El_v_U = PNA_healthy_v_Elbow_ROM; 
Sh_Yv_U = PNA_healthy_v_Shoulder_Y_ROM; 
Sh_Xv_U = PNA_healthy_v_Shoulder_X_ROM;
Sh_Zv_U = PNA_healthy_v_Shoulder_Z_ROM;

% convert into vectors
El_v_U = reshape(El_v_U,1,7*7);
Sh_Xv_U = reshape(Sh_Xv_U,1,7*7);
Sh_Yv_U = reshape(Sh_Yv_U,1,7*7);
Sh_Zv_U = reshape(Sh_Zv_U,1,7*7);

% healthy horizontal
El_h_U = PNA_healthy_h_Elbow_ROM; 
Sh_Yh_U = PNA_healthy_h_Shoulder_Y_ROM; 
Sh_Xh_U = PNA_healthy_h_Shoulder_X_ROM;
Sh_Zh_U = PNA_healthy_h_Shoulder_Z_ROM;

% convert into vectors
El_h_U = reshape(El_h_U,1,7*7);
Sh_Xh_U = reshape(Sh_Xh_U,1,7*7);
Sh_Yh_U = reshape(Sh_Yh_U,1,7*7);
Sh_Zh_U = reshape(Sh_Zh_U,1,7*7);


%% ----------------------- %%

El_v_B1 = PNA_brace1_v_Elbow_ROM; 
Sh_Yv_B1 = PNA_brace1_v_Shoulder_Y_ROM;
Sh_Xv_B1 = PNA_brace1_v_Shoulder_X_ROM;
Sh_Zv_B1 = PNA_brace1_v_Shoulder_Z_ROM;

% % % convert into vectors
El_v_B1 = reshape(El_v_B1,1,7*7);
Sh_Xv_B1 = reshape(Sh_Xv_B1,1,7*7);
Sh_Yv_B1 = reshape(Sh_Yv_B1,1,7*7);
Sh_Zv_B1 = reshape(Sh_Zv_B1,1,7*7);

El_h_B1 = PNA_brace1_h_Elbow_irom_Array; 
Sh_Yh_B1 = PNA_brace1_h_Shoulder_Y_ROM;
Sh_Xh_B1 = PNA_brace1_h_Shoulder_X_ROM;
Sh_Zh_B1 = PNA_brace1_h_Shoulder_Z_ROM;

% % % convert into vectors
El_h_B1 = reshape(El_h_B1,1,7*7);
Sh_Xh_B1 = reshape(Sh_Xh_B1,1,7*7);
Sh_Yh_B1 = reshape(Sh_Yh_B1,1,7*7);
Sh_Zh_B1 = reshape(Sh_Zh_B1,1,7*7);

 
%% ----------------------- %%

El_v_B2 = PNA_brace2_v_Elbow_ROM; 
Sh_Yv_B2 = PNA_brace2_v_Shoulder_Y_ROM;
Sh_Xv_B2 = PNA_brace2_v_Shoulder_X_ROM;
Sh_Zv_B2 = PNA_brace2_v_Shoulder_Z_ROM;

% % % convert into vectors
El_v_B2 = reshape(El_v_B2,1,7*7);
Sh_Xv_B2 = reshape(Sh_Xv_B2,1,7*7);
Sh_Yv_B2 = reshape(Sh_Yv_B2,1,7*7);
Sh_Zv_B2 = reshape(Sh_Zv_B2,1,7*7);


El_h_B2 = PNA_brace2_h_Elbow_irom_Array; 
Sh_Yh_B2 = PNA_brace2_h_Shoulder_Y_ROM;
Sh_Xh_B2 = PNA_brace2_h_Shoulder_X_ROM;
Sh_Zh_B2 = PNA_brace2_h_Shoulder_Z_ROM;

% % % convert into vectors
El_h_B2 = reshape(El_h_B2,1,7*7);
Sh_Xh_B2 = reshape(Sh_Xh_B2,1,7*7);
Sh_Yh_B2 = reshape(Sh_Yh_B2,1,7*7);
Sh_Zh_B2 = reshape(Sh_Zh_B2,1,7*7);

% ------------------------- %

% Perform PCA

% Standardise the data so that larger roms don't influence overall output
All_Uv = zscore([El_v_U' Sh_Xv_U' Sh_Yv_U' Sh_Zv_U']);
Sh_B1v = zscore([El_v_B1' Sh_Xv_B1' Sh_Yv_B1' Sh_Zv_B1']);
Sh_B2v = zscore([El_v_B2' Sh_Xv_B2' Sh_Yv_B2' Sh_Zv_B2']);

All_Uh = zscore([El_h_U' Sh_Xh_U' Sh_Yh_U' Sh_Zh_U']);
Sh_B1h = zscore([El_h_B1' Sh_Xh_B1' Sh_Yh_B1' Sh_Zh_B1']);
Sh_B2h = zscore([El_h_B2' Sh_Xh_B2' Sh_Yh_B2' Sh_Zh_B2']);


% Get Eigenvectors 
[eigenvectors_Uv,eigenvalues_Uv] = eig(cov(All_Uv));
[eigenvectors_B1v,eigenvalues_B1v] = eig(cov(Sh_B1v));
[eigenvectors_B2v,eigenvalues_B2v] = eig(cov(Sh_B2v));

[eigenvectors_Uh,eigenvalues_Uh] = eig(cov(All_Uh))
[eigenvectors_B1h,eigenvalues_B1h] = eig(cov(Sh_B1h))
[eigenvectors_B2h,eigenvalues_B2h] = eig(cov(Sh_B2h))


% Determine feature vector
Feature_Vector_Uv = [eigenvectors_Uv(:,4)];
Feature_Vector_B1v = [eigenvectors_B1v(:,4)];
Feature_Vector_B2v = [eigenvectors_B2v(:,4)];

Feature_Vector_Uh = [eigenvectors_Uh(:,4)];
Feature_Vector_B1h = [eigenvectors_B1h(:,4)];
Feature_Vector_B2h = [eigenvectors_B2h(:,4)];


% Project Original Data
Uv_PCA_1 = All_Uv * Feature_Vector_Uv;
B1v_PCA_1 = Sh_B1v * Feature_Vector_B1v;
B2v_PCA_1 = Sh_B2v * Feature_Vector_B2v;

Uh_PCA_1 = All_Uh * Feature_Vector_Uh;
B1h_PCA_1 = Sh_B1h * Feature_Vector_B1h;
B2h_PCA_1 = Sh_B2h * Feature_Vector_B2h;

% Convert back to matrix form
Uv_PCA_1 = reshape(Uv_PCA_1,7,7)
B1v_PCA_1 = reshape(B1v_PCA_1,7,7)
B2v_PCA_1 = reshape(B2v_PCA_1,7,7)

Uh_PCA_1 = reshape(Uh_PCA_1,7,7)
B1h_PCA_1 = reshape(B1h_PCA_1,7,7)
B2h_PCA_1 = reshape(B2h_PCA_1,7,7)


figure(1)
clf

Copper_Custom = [         
        1.0000    1.0000    1.0000
    0.9125    0.9375    0.9375
    0.8250    0.8750    0.8750
    0.7375    0.8125    0.8125
    0.6500    0.7500    0.7500
    0.5625    0.6875    0.6875
    0.5000    0.6000    0.6250
    0.4375    0.5125    0.5625
    0.3750    0.4250    0.5000
    0.3125    0.3375    0.4375
    0.2500    0.2500    0.3750
    0.1875    0.1875    0.2875
    0.1250    0.1250    0.2000
    0.0625    0.0625    0.1125
         0         0         0
    0.0893    0.0558    0.0355
    0.1786    0.1116    0.0711
    0.2679    0.1674    0.1066
    0.3571    0.2232    0.1421
    0.4464    0.2790    0.1777
    0.5357    0.3348    0.2132
    0.6250    0.3906    0.2487
    0.7143    0.4464    0.2843
    0.8036    0.5022    0.3198
    0.8929    0.5580    0.3554
    0.9821    0.6138    0.3909
    1.0000    0.6696    0.4264
    1.0000    0.7254    0.4620
    1.0000    0.7812    0.4975];

    
colormap(Copper_Custom)
Sq_Ax = [0.5 7.5 0.5 7.5]; % Square axis
Sq_Ax_Rsz = [0.5 210 0.5 210];  % Resized Axis

font_Size = 15;

subplot(3,2,2)
hold on
grid on

%imagesc((Uv_PCA_1))

ReSize = imresize(Uv_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)

title('Unimpaired Vertical PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual

subplot(3,2,4)
hold on
grid on

imagesc((B1v_PCA_1))

ReSize = imresize(B1v_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)


title('Brace 1 Vertical PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual


subplot(3,2,6)
hold on
grid on

imagesc((B2v_PCA_1))

ReSize = imresize(B2v_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)


title('Brace 2 Vertical PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual


%% --------------------- %%

subplot(3,2,1)
hold on
grid on

%imagesc((Uv_PCA_1))

ReSize = imresize(Uh_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)

title('Unimpaired Horizontal PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual

subplot(3,2,3)
hold on
grid on

%imagesc((B1h_PCA_1))

ReSize = imresize(B1h_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)


title('Brace 1 Horizontal PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual


subplot(3,2,5)
hold on
grid on

%imagesc((B2v_PCA_1))

ReSize = imresize(B2h_PCA_1,30,'bicubic');
pcolor(ReSize)
imagesc(ReSize)
axis(Sq_Ax_Rsz)


title('Brace 2 Horizontal PC1')
colorbar()
set(gca,'FontSize',font_Size)
%axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

line([0.5 210],[105 105],'color','w','linewidth',1.5)
line([105 105],[0.5 210],'color','w','linewidth',1.5)

caxis([-3.5 2.5])
caxis manual



get(gcf);
set(gcf,'Position',[500 500 400 300]);