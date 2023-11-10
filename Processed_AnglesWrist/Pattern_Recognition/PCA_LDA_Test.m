clear
clc
% Try PCA and LDA on multiple participants

load('Pn_Brace2_Arrays.mat')
load('Pn_Unimpaired_Arrays.mat')

% Specify position on reaching grid
X = 1;
Y = 7;

ShX_A = squeeze([Pn_v_Unim_ShX(X,Y,:)])
ShY_A = squeeze([Pn_v_Unim_ShY(X,Y,:)])
ShZ_A = squeeze([Pn_v_Unim_ShZ(X,Y,:)])

ShX_B = squeeze([Pn_v_Brac2_ShX(X,Y,:)])
ShY_B = squeeze([Pn_v_Brac2_ShY(X,Y,:)])
ShZ_B = squeeze([Pn_v_Brac2_ShZ(X,Y,:)])


figure(1)
clf
subplot(3,1,1)
hold on
grid on

All_Data = [ShX_A,ShY_A;;ShX_A,ShY_B]

scatter(ShX_A,ShY_A,25,'filled','r')
scatter(ShX_B,ShY_B,25,'filled','b')

ylabel('ShX')
xlabel('ShY')
%axis square 

legend('Unimpaired','Brace')


% ===== PCA Part 2D ===== %


% find the principle component coefficients, scores, and variances 
 [coeff_A,score_A,latent_A] = pca(All_Data);

% %Reconstruct the centered measurements data.
 Xcentered_A = score_A*coeff_A'
% Xcentered_B = score_B*coeff'
% Xcentered_C = score_C*coeff'

subplot(3,1,2)
 hold on
 grid on
 title('PCA')
 
 hPlot1 = biplot(coeff_A(:,1:2),'scores',score_A(:,1:2),'varlabels',{'PCA_1','PCA_2'});
 set( hPlot1, 'Color', 'k' )

 
 
 %% LDA

 subplot(3,1,3)
 hold on
 grid on
 title('LDA')

 Group = [1 1 1 1 1 1 1 2 2 2 2 2 2 2];
 
 h1 = gscatter(All_Data(:,1),All_Data(:,2),Group,'rb');
 legend('Unim','Br2','Location','NE')

 % Create a linear discriminant analysis classifier
 MdlLinear = fitcdiscr(All_Data,Group)
 
 MdlLinear.Coeffs.Const
 
 K = MdlLinear.Coeffs(1,2).Const  
 L = MdlLinear.Coeffs(1,2).Linear

 f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
 h2 = fimplicit(f,':');
 h2.Color = 'k';
 h2.LineWidth = 2;
 
 

