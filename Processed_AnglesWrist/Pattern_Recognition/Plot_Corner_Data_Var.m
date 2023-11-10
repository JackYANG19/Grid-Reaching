clear
% Plot data for specific reaching targets

load('Pn_Unimpaired_Arrays_mAngle.mat')
load('Pn_Brace1_Arrays_mAngle.mat')
load('Pn_Brace2_Arrays_mAngle.mat')

%% --- Top Left -- %%

TL_Unim_El = reshape(Pn_v_Unim_Elbow(1,1,:),7,1);
TL_Unim_ShX = reshape(Pn_v_Unim_ShX(1,1,:),7,1);
TL_Unim_ShY = reshape(Pn_v_Unim_ShY(1,1,:),7,1);
TL_Unim_ShZ = reshape(Pn_v_Unim_ShZ(1,1,:),7,1);

TL_Unim = [TL_Unim_El TL_Unim_ShX TL_Unim_ShY TL_Unim_ShZ]


TL_Brac1_El = reshape(Pn_v_Brac1_Elbow(1,1,:),7,1);
TL_Brac1_ShX = reshape(Pn_v_Brac1_ShX(1,1,:),7,1);
TL_Brac1_ShY = reshape(Pn_v_Brac1_ShY(1,1,:),7,1);
TL_Brac1_ShZ = reshape(Pn_v_Brac1_ShZ(1,1,:),7,1);

TL_Brac1 = [TL_Brac1_El TL_Brac1_ShX TL_Brac1_ShY TL_Brac1_ShZ]

TL_Brac2_El = reshape(Pn_v_Brac2_Elbow(1,1,:),7,1);
TL_Brac2_ShX = reshape(Pn_v_Brac2_ShX(1,1,:),7,1);
TL_Brac2_ShY = reshape(Pn_v_Brac2_ShY(1,1,:),7,1);
TL_Brac2_ShZ = reshape(Pn_v_Brac2_ShZ(1,1,:),7,1);

TL_Brac2 = [TL_Brac2_El TL_Brac2_ShX TL_Brac2_ShY TL_Brac2_ShZ]

%% --- Bottom Right -- %%



BR_Unim_El = reshape(Pn_v_Unim_Elbow(7,7,:),7,1);
BR_Unim_ShX = reshape(Pn_v_Unim_ShX(7,7,:),7,1);
BR_Unim_ShY = reshape(Pn_v_Unim_ShY(7,7,:),7,1);
BR_Unim_ShZ = reshape(Pn_v_Unim_ShZ(7,7,:),7,1);

BR_Unim = [BR_Unim_El BR_Unim_ShX BR_Unim_ShY BR_Unim_ShZ];


BR_Brac1_El = reshape(Pn_v_Brac1_Elbow(7,7,:),7,1);
BR_Brac1_ShX = reshape(Pn_v_Brac1_ShX(7,7,:),7,1);
BR_Brac1_ShY = reshape(Pn_v_Brac1_ShY(7,7,:),7,1);
BR_Brac1_ShZ = reshape(Pn_v_Brac1_ShZ(7,7,:),7,1);

BR_Brac1 = [BR_Brac1_El BR_Brac1_ShX BR_Brac1_ShY BR_Brac1_ShZ];

BR_Brac2_El = reshape(Pn_v_Brac2_Elbow(7,7,:),7,1);
BR_Brac2_ShX = reshape(Pn_v_Brac2_ShX(7,7,:),7,1);
BR_Brac2_ShY = reshape(Pn_v_Brac2_ShY(7,7,:),7,1);
BR_Brac2_ShZ = reshape(Pn_v_Brac2_ShZ(7,7,:),7,1);

BR_Brac2 = [BR_Brac2_El BR_Brac2_ShX BR_Brac2_ShY BR_Brac2_ShZ];

All_Unim = [TL_Unim; BR_Unim];
All_Brac1 = [TL_Brac1; BR_Brac1];
All_Brac2 = [TL_Brac2; BR_Brac2];

figure(1)
clf
hold on
grid on
scatter3(All_Unim(:,2), All_Unim(:,3), All_Unim(:,4), 15,'filled')
scatter3(All_Brac1(:,2), All_Brac1(:,3), All_Brac1(:,4), 15,'filled')
scatter3(All_Brac2(:,2), All_Brac2(:,3), All_Brac2(:,4), 15,'filled')
legend('Unimp','Br1','Br2')
view(3)

% points of interest
 poi = [1:14];
%poi = 1:49;

Elbow_Compare = [All_Unim(poi,1) All_Brac1(poi,1) All_Brac2(poi,1)];
ShX_Compare = [All_Unim(poi,2) All_Brac1(poi,2) All_Brac2(poi,2)];
ShY_Compare = [All_Unim(poi,3) All_Brac1(poi,3) All_Brac2(poi,3)];
ShZ_Compare = [All_Unim(poi,4) All_Brac1(poi,4) All_Brac2(poi,4)];

figure(2)
clf
hold on
grid on

subplot(2,2,1)
hold on
title('Elbow')
boxplot(Elbow_Compare,'Labels',{'Unim','Brace 1','Brace 2'})

subplot(2,2,2)
hold on
title('ShX')
boxplot(ShX_Compare,'Labels',{'Unim','Brace 1','Brace 2'})

subplot(2,2,3)
hold on
title('ShY')
boxplot(ShY_Compare,'Labels',{'Unim','Brace 1','Brace 2'})

subplot(2,2,4)
hold on
title('ShZ')
boxplot(ShZ_Compare,'Labels',{'Unim','Brace 1','Brace 2'})
