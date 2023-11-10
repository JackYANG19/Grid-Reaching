clear
% Plot data for specific reaching targets

load('Pn_Unimpaired_Arrays_mAngle.mat')
load('Pn_Brace1_Arrays_mAngle.mat')
load('Pn_Brace2_Arrays_mAngle.mat')

% Pn_v_Unim_Elbow = zscore(Pn_v_Unim_Elbow);
% Pn_v_Unim_ShX = zscore(Pn_v_Unim_ShX);
% Pn_v_Unim_ShY = zscore(Pn_v_Unim_ShY);


El_Var_Unim_Matrix = zeros(7,7);
ShX_Var_Unim_Matrix = zeros(7,7);
ShY_Var_Unim_Matrix = zeros(7,7);
ShZ_Var_Unim_Matrix = zeros(7,7);


for (x = 1:7)
    for (y = 1:7)
    Unim_El_var =  var(reshape(Pn_v_Unim_Elbow(y,x,:),7,1))
    Unim_ShX_var = var(reshape(Pn_v_Unim_ShX(y,x,:),7,1))
    Unim_ShY_var = var(reshape(Pn_v_Unim_ShY(y,x,:),7,1))
    Unim_ShZ_var = var(reshape(Pn_v_Unim_ShZ(y,x,:),7,1))
    
    El_Var_Unim_Matrix(y,x) = Unim_El_var;
    ShX_Var_Unim_Matrix(y,x) = Unim_ShX_var;
    ShY_Var_Unim_Matrix(y,x) = Unim_ShY_var;
    ShZ_Var_Unim_Matrix(y,x) = Unim_ShZ_var;

    
    Br1_El_var =  var(reshape(Pn_v_Brac1_Elbow(y,x,:),7,1))
    Br1_ShX_var = var(reshape(Pn_v_Brac1_ShX(y,x,:),7,1))
    Br1_ShY_var = var(reshape(Pn_v_Brac1_ShY(y,x,:),7,1))
    Br1_ShZ_var = var(reshape(Pn_v_Brac1_ShZ(y,x,:),7,1))
    
    El_Var_Br1_Matrix(y,x) = Br1_El_var;
    ShX_Var_Br1_Matrix(y,x) = Br1_ShX_var;
    ShY_Var_Br1_Matrix(y,x) = Br1_ShY_var;
    ShZ_Var_Br1_Matrix(y,x) = Br1_ShZ_var;
    
    end
end


% TL_Unim_ShX = reshape(Pn_v_Unim_ShX(1,1,:),7,1);
% TL_Unim_ShY = reshape(Pn_v_Unim_ShY(1,1,:),7,1);
% TL_Unim_ShZ = reshape(Pn_v_Unim_ShZ(1,1,:),7,1);
% 
% TL_Unim = [TL_Unim_El TL_Unim_ShX TL_Unim_ShY TL_Unim_ShZ]
% 
% 
% TL_Brac1_El = reshape(Pn_v_Brac1_Elbow(1,1,:),7,1);
% TL_Brac1_ShX = reshape(Pn_v_Brac1_ShX(1,1,:),7,1);
% TL_Brac1_ShY = reshape(Pn_v_Brac1_ShY(1,1,:),7,1);
% TL_Brac1_ShZ = reshape(Pn_v_Brac1_ShZ(1,1,:),7,1);
% 
% TL_Brac1 = [TL_Brac1_El TL_Brac1_ShX TL_Brac1_ShY TL_Brac1_ShZ]
% 
% TL_Brac2_El = reshape(Pn_v_Brac2_Elbow(1,1,:),7,1);
% TL_Brac2_ShX = reshape(Pn_v_Brac2_ShX(1,1,:),7,1);
% TL_Brac2_ShY = reshape(Pn_v_Brac2_ShY(1,1,:),7,1);
% TL_Brac2_ShZ = reshape(Pn_v_Brac2_ShZ(1,1,:),7,1);
% 
% TL_Brac2 = [TL_Brac2_El TL_Brac2_ShX TL_Brac2_ShY TL_Brac2_ShZ]

%% --- Bottom Right -- %%


% All_Unim = [TL_Unim; BR_Unim];
% All_Brac1 = [TL_Brac1; BR_Brac1];
% All_Brac2 = [TL_Brac2; BR_Brac2];

figure(1)
clf
hold on
grid on

% ----------- Plot As Matricies ------------ %
figure(1)
clf

% H = suptitle('Healthy Horizontal');
% H.VerticalAlignment = 'baseline';
% H.FontWeight = 'bold';

font_Size = 10;

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
         0         0         0];
%     0.0893    0.0558    0.0355
%     0.1786    0.1116    0.0711
%     0.2679    0.1674    0.1066
%     0.3571    0.2232    0.1421
%     0.4464    0.2790    0.1777
%     0.5357    0.3348    0.2132
%     0.6250    0.3906    0.2487
%     0.7143    0.4464    0.2843
%     0.8036    0.5022    0.3198
%     0.8929    0.5580    0.3554
%     0.9821    0.6138    0.3909
%     1.0000    0.6696    0.4264
%     1.0000    0.7254    0.4620
%     1.0000    0.7812    0.4975];

Sq_Ax = [0.5 7.5 0.5 7.5]; % Square axis

colormap(Copper_Custom)

subplot(3,4,1)
hold on
grid on

imagesc((El_Var_Unim_Matrix))

title('Elbow')
colorbar()
set(gca,'FontSize',font_Size)
axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

subplot(3,4,2)
hold on
grid on

set(gca,'FontSize',font_Size)

title('Elbow')
imagesc((ShX_Var_Unim_Matrix))
    
colorbar()
    
axis(Sq_Ax)
axis square
    
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

subplot(3,4,3)
hold on
grid on

set(gca,'FontSize',font_Size)

title('ShY')
imagesc((ShY_Var_Unim_Matrix))
    
colorbar()
    
axis(Sq_Ax)
axis square
    
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

subplot(3,4,4)
hold on
grid on

set(gca,'FontSize',font_Size)

title('ShZ')
imagesc((ShZ_Var_Unim_Matrix))
    
colorbar()
    
axis(Sq_Ax)
axis square
    
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   

%% ---------------------- %%

subplot(3,4,5)
hold on
grid on

imagesc((El_Var_Br1_Matrix))

title('Elbow')
colorbar()
set(gca,'FontSize',font_Size)
axis(Sq_Ax)
axis square
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])   
