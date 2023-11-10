% Determine reaching intervals
% Splits recorded data into individual reaching motions by looking at peaks
% of wrist motion

% WristR_Mid comes from Convert Vicon to Matlab Angles
% Determined intervals are used for ROM analysis

function [Num_Traj] = Det_Int_Dwell(Name_Prefix)

close all

%     if ~exist('Name_Prefix')
%         Name_Prefix = 'P18r_amputee_h'
%         disp 'P18r'
%     end

%% For P09_brace2_h' number 12 is wrong!!

Name_Prefix = "P14_healthy_h";

Filename = strcat('Processed_AnglesWrist\',Name_Prefix,'_Processed_AnglesWrist.mat');
load(Filename);


% Only plot a limited region to aid debugging
X_lim = 15000; %length(WristR_Mid); % 1000; %%15000
Y_lim = 800;

Half_Reaching_Thresh = -400;

% Typically -400
% For P11_b1_v -200

% Calculate movement velocity averaged over all DOF
Wrist_Sum = sum(WristR_Mid,2)/3;
Wrist_Vel_Mean = diff(Wrist_Sum);

%Calculte RMS
Wrist_RMS = rms(WristR_Mid');
Wrist_Vel_Y = diff(WristR_Mid(:,2));



% figure(1)
% clf
%
% subplot(2,1,2)
% title('Wrist Y Motion and Determined Trajectories')
% hold on
% grid on
% plot(WristR_Mid(:,2),':','linewidth',1,'color','k')
%
% subplot(2,1,1)
% hold on
% grid on
% title('Wrist Y Velocity')
% plot(Wrist_Vel_Y,'linewidth',1,'color','k')
%
% thresh_plot = ones(1,length(WristR_Mid(:,2)))*0.2;
%
% plot(1:length(thresh_plot),thresh_plot)
%
% axis([0, X_lim,-10,10])
%
% ylabel('Wrist Y Velocity')
% xlabel('Time (samples)')


% % Locate peaks closest to body (invert Z)
% [Body_Peaks_Y,Body_Peaks_X] = findpeaks(-WristR_Mid(:,2),Frame,'MinPeakHeight',200,'MinPeakProminence',200); % P10H = 30
% Body_Peaks_X = Body_Peaks_X';
%
% % Locate peaks closest to Grid (furthest from body).
% [Grid_Peaks_Y,Grid_Peaks_X] = findpeaks(WristR_Mid(:,2),Frame,'MinPeakHeight',-400,'MinPeakProminence',150,'MinPeakDistance',10); %P10H = 30


%% ====== FIND VELOCITY PEAKS AND +/- THRESHOLD CROSSINGS ====== %%

threshold = 0.2; %0.2
location = threshold >= Wrist_Vel_Y;
crossover = diff(location);

RMS_PC = find(crossover<0);     % Trough - PC - positive crossing
RMS_NC = find(crossover>0);       % Peak - NC - Negative Crossing

Frame2 = 1:length(Wrist_Vel_Y); % Frame2 is different to Frame due to derivative

[RMS_Peaks_Y,RMS_Peaks_X]= findpeaks(Wrist_Vel_Y,Frame2,'MinPeakHeight',1.5,'MinPeakProminence',2);
% plot(RMS_Peaks_X,RMS_Peaks_Y,'ko','MarkerFaceColor','g','MarkerSize',7)
%
% plot(RMS_PC,Wrist_Vel_Y(RMS_PC),'Rs','MarkerFaceColor','r')
% plot(RMS_NC,Wrist_Vel_Y(RMS_NC),'Rs','MarkerFaceColor','b')

% The peak should be between a PC and NC. Prune all others
RMS_Good = [0 0;0 0];
Good = 1;


% Can't have a negative crossing before a positive one
if (RMS_NC(1)<RMS_PC(1))
    RMS_NC(1) = [];
end

for i = 1:length(RMS_PC)
    for j = 1:length(RMS_Peaks_X)

        %        disp('Prune')
        %Prune = [RMS_PC(i) RMS_Peaks_X(j) RMS_NC(i)]

        %is there a peak between NC and PC?
        if ((RMS_PC(i)<RMS_Peaks_X(j)) && (RMS_NC(i)>RMS_Peaks_X(j)))

            % If yes, store in matrix
            RMS_Good(Good,:) = [RMS_PC(i),RMS_NC(i)];
            Good = Good+1;
        end
    end
end

% Good;
%
% disp('before remove duplicates')
% RMS_Good

%%% ======== REMOVE DUPLICATE ROWS ======== %%%

Duplicates = [0];
j = 1;


for i = 2:length(RMS_Good)
    if (RMS_Good(i,:) == RMS_Good(i-1,:))
        Duplicates(j) = i;
        j = j+1;
    end
end

% Remove duplicates
for i = 1:length(Duplicates)
    RMS_Good(Duplicates(i)-(i-1),:) = [];
end

% disp('after remove duplicates')
% RMS_Good

Bad_Rows = [0];
Bad_row = 1;

%% ==== BAD ROWS ARE HAND MOVEMENTS NEAR THE BODY === %%

% If the motion is short and Y is below -400 remove
for i = 1:length(RMS_Good)
    i;
    % Detect short lengths
    if (RMS_Good(i,2)-RMS_Good(i,1) < 80)

        % if <-400 delete
        % RMS_Good;
        % RMS_Good(1,2)
        % RMS_Good(1,1)

        WristR_Mid(RMS_Good(i,2),2)

        if (WristR_Mid(RMS_Good(i,2),2) <Half_Reaching_Thresh)
            i;
            Bad_Rows(Bad_row) = i;
            Bad_row = Bad_row+1;
        end
    end

end

% Remove bad rows
if (Bad_Rows(1) >0)
    for i = 1:length(Bad_Rows)
        RMS_Good(Bad_Rows(i)-(i-1),:) = [];
    end
end


%%% ====== MERGE ROWS ==== %%%

% If motion is short and above -400 then these are just trajectory
% modifications. Merge them together

% % Indexing and length has changed, which is why we run the merge detection in a
% % separate loop to the previous 'bad row' loop

Merge_Rows = [0];
Merge_row = 1;

for i = 1:length(RMS_Good)-1

    % Detect short gaps
    if (RMS_Good(i+1,1)-RMS_Good(i,2) < 70)

        Merge_Rows(Merge_row) = i;
        Merge_row = Merge_row+1;
    end
end

% Merge_Rows

%%  Merge_Rows
if (Merge_Rows(1)>0)
    for i = 1:length(Merge_Rows)
        [i RMS_Good(Merge_Rows(i),:)  RMS_Good(Merge_Rows(i)+1,:)];
        RMS_Good(Merge_Rows(i),2) = RMS_Good(Merge_Rows(i)+1,2);
    end

    % Remove leftover merged rows
    for i = 1:length(Merge_Rows)-1
        RMS_Good(Merge_Rows(i)+1-(i-1),:) = [];
    end
end


% For some reason some leftover merged rows are not automatically removed,
% so remove them here by looking for duplicated last column values.
Duplicates = [0];
j = 1;

% check if rows are the same and record index of first
for i = 2:length(RMS_Good)

    if (RMS_Good(i,2) == RMS_Good(i-1,2))
        Duplicates(j) = i;
        j = j+1;
    end

end

% Remove duplicates
if (Duplicates(1)>0)
    for (i = 1:length(Duplicates))
        RMS_Good(Duplicates(i)-(i-1),:) = [];
        %RMS_Good(Bad_Rows(i),:) = [];
    end
end


%% Manually Remove Bad Segments

% This function contains a list of all bad segments (detected by human)
[Row] = Manual_Remove(Name_Prefix);

if (Row > 0)
    for i = 1:length(Row)
        RMS_Good(Row(i)-(i-1),:) = [];
    end
end


[Repairs] = Manual_Repair(Name_Prefix);

if (Repairs(1,1,1)>0)
    for i = 1:length(Repairs(:,1))
        i;
        RMS_Good(Repairs(i,1),1) = Repairs(i,2);
        RMS_Good(Repairs(i,1),2) = Repairs(i,3);


    end
end



% % Plot
%
% plot(RMS_Good(:,1),Wrist_Vel_Y(RMS_Good(:,1)),'^k','MarkerFaceColor','y','MarkerSize',8)
% plot(RMS_Good(:,2),Wrist_Vel_Y(RMS_Good(:,2)),'vk','MarkerFaceColor','m','MarkerSize',8)
%
%
% legend('Wrist Y Velocity','Velocity Threshold','Identified Peaks','+ve Threshold Crossing','-ve Threshold Crossing','Location','SE')
%
%
% subplot(2,1,2)
% %title('Velocity Based Detection')
% hold on
% grid on
%
% plot(WristR_Mid(:,2),':','linewidth',1)
%
% Wrist Y
% WY = WristR_Mid(:,2);
%
% ylabel('Wrist Y Position (mm)')
% xlabel('Time (samples)')
%
%
% for (i = 1: length(RMS_Good))
%     % This is the interval between the peaks
%     A = RMS_Good(i,1);  % End of motion (at grid)
%     B = RMS_Good(i,2);    % Start of motion (near body)
%
%     plot(A:B,WY(A:B),'b','linewidth',2.5);
%
%     text(B,WY(B)+60,num2str(i))
% end

intervals_start = RMS_Good(:,1);
intervals_end = RMS_Good(:,2);

% axis([0, X_lim, -Y_lim, 0])

Intervals = [intervals_start,intervals_end];


% Now save the intervals for this participant
if (Name_Prefix == "P09_brace2_h")
    Intervals(12,:) = [3888, 4047];
    Intervals(7,:) = [2252, 2492];
elseif (Name_Prefix == "P09_brace1_h")
    Intervals(49,:) = [15403, 15608];
    Intervals(35,:) = [10759, 10942];
elseif (Name_Prefix == "P10_brace2_h")
    Intervals(43,:) = [14407, 14544];
    Intervals(45,:) = [15039, 15162];
elseif (Name_Prefix == "P11_healthy_h")
    Intervals(6,:) = [1881, 2043];
    Intervals(8,:) = [2760, 2901];
    Intervals(21,:) = [7350, 7520];
    Intervals(37,:) = [13640, 13759];
    Intervals(40,:) = [14412, 14520];
    Intervals(46,:) = [17009, 17113];
    Intervals(51,:) = [18658, 18832];
    %
    Intervals(47,:) = [];
    Intervals(38,:) = [];
elseif (Name_Prefix == "P11_brace1_h")
    Intervals(2,:) = [472, 628];
    Intervals(16,:) = [6403, 6577];
    Intervals(31,:) = [12144, 12266];
    Intervals(45,:) = [17724, 17884];
    Intervals(48,:) = [18534, 18735];
    Intervals(49,:) = [19014, 19188];
    %
    Intervals(47,:) = [];
    Intervals(39,:) = [];
elseif (Name_Prefix == "P11_brace2_h")
    Intervals(52,:) = [];
    Intervals(46,:) = [];
    Intervals(39,:) = [];
    Intervals(20,:) = [];
    Intervals(36,:) = [15808, 16035];
    Intervals(39,:) = [17225, 17404];
    Intervals(45,:) = [20228, 20354];
    Intervals(46,:) = [20619, 20794];
    Intervals(47,:) = [21034, 21241];
    Intervals(48,:) = [21457, 21659];
    Intervals(49,:) = [22053, 22208];
elseif (Name_Prefix == "P13_brace1_h")
    Intervals(39,:) = [15483, 15597];
    Intervals(42,:) = [16662, 16812];
elseif (Name_Prefix == "P13_brace2_h")
    Intervals(7,:) = [2764, 3034];
    Intervals(19,:) = [7911, 8081];
elseif (Name_Prefix == "P14_healthy_h")
    Intervals(5,:) = [1667, 1837];
elseif (Name_Prefix == "P14_brace1_h")
    Intervals(21,:) = [8314, 8571];
elseif (Name_Prefix == "P14_brace2_h")
    Intervals(1,:) = [172, 370];
elseif (Name_Prefix == "P15_healthy_h")
    Intervals(4,:) = [1302, 1469];
    Intervals(6,:) = [2016, 2260];
    Intervals(12,:) = [4952, 5148];
    Intervals(18,:) = [7617, 7749];
elseif (Name_Prefix == "P15_brace1_h")
    Intervals(19,:) = [7906, 8072];
elseif (Name_Prefix == "P15_brace2_h")
    Intervals(5,:) = [2055, 2264];
    Intervals(20,:) = [8802, 9048];
    Intervals(21,:) = [9223, 9460];
    Intervals(35,:) = [15935, 16246];
    Intervals(42,:) = [19079, 19267];
elseif (Name_Prefix == "P16_brace1_h")
    Intervals(46,:) = [17858, 18029];
elseif (Name_Prefix == "P16_brace2_h")
    Intervals(7,:) = [2751, 2939];
    Intervals(18,:) = [7472, 7633];
    Intervals(36,:) = [14383, 14577];
elseif (Name_Prefix == "P09_healthy_v")
    Intervals(45,:) = [13831, 13921];
elseif (Name_Prefix == "P09_brace1_v")
    Intervals(48,:) = [14445, 14647];
elseif (Name_Prefix == "P09_brace2_v")
    Intervals(7,:) = [2323, 2550];
    Intervals(29,:) = [9582, 9695];
    Intervals(42,:) = [13683, 13899];
    Intervals(47,:) = [15607, 15796];
    Intervals(48,:) = [15970, 16160];
elseif (Name_Prefix == "P10_healthy_v")
    Intervals(3,:) = [822, 935];
elseif (Name_Prefix == "P10_brace1_v")
    Intervals(7,:) = [2113, 2358];
elseif (Name_Prefix == "P11_healthy_v")
    Intervals(1,:) = [123, 308];
    Intervals(3,:) = [809, 999];
    Intervals(4,:) = [1203, 1287];
    Intervals(16,:) = [5563, 5675];
    Intervals(25,:) = [8335, 8423];
    Intervals(26,:) = [8600, 8724];
    Intervals(32,:) = [10404, 10520];
    Intervals(33,:) = [10720, 10815];
    Intervals(39,:) = [12716, 12819];
    Intervals(43,:) = [14121, 14293];
    Intervals(49,:) = [16206, 16383];
    %
    Intervals(48,:) = [];
    Intervals(29,:) = [];
elseif (Name_Prefix == "P11_brace1_v")
    Intervals(13,:) = [6618, 6801];
elseif (Name_Prefix == "P11_brace2_v")
    Intervals(1,:) = [125, 347];
    Intervals(8,:) = [2783, 2993];
    Intervals(42,:) = [17575, 17722];
    Intervals(43,:) = [18025, 18234];
    Intervals(45,:) = [19038, 19257];
    Intervals(49,:) = [20634, 20767];
    Intervals(52,:) = [22021, 22180];
    %
    Intervals(53,:) = [];
    Intervals(46,:) = [];
    Intervals(39,:) = [];
    Intervals(4,:) = [];
elseif (Name_Prefix == "P13_healthy_v")
    Intervals(4,:) = [1511, 1649];
    Intervals(5,:) = [1969, 2122];
    Intervals(7,:) = [2932, 3172];
    Intervals(12,:) = [5300, 5434];
elseif (Name_Prefix == "P13_brace1_v")
    Intervals(5,:) = [1629, 1807];
    Intervals(33,:) = [12934, 13089];
elseif (Name_Prefix == "P13_brace2_v")
    Intervals(5,:) = [1724, 1882];
    Intervals(7,:) = [2456, 2706];
    Intervals(11,:) = [4005, 4148];
    Intervals(35,:) = [13501, 13696];
    Intervals(41,:) = [15761, 15932];
    Intervals(44,:) = [17164, 17292];
    Intervals(46,:) = [17914, 18106];
elseif (Name_Prefix == "P14_healthy_v")
    Intervals(5,:) = [1731, 1938];
elseif (Name_Prefix == "P14_brace1_v")
    Intervals(1,:) = [128, 344];
    Intervals(39,:) = [16037, 16223];
    Intervals(46,:) = [18976, 19131];
elseif (Name_Prefix == "P15_healthy_v")
    Intervals(1,:) = [166, 352];
    Intervals(3,:) = [1042, 1168];
    Intervals(5,:) = [1745, 1931];
    Intervals(13,:) = [5218, 5408];
    Intervals(32,:) = [14958, 15143];
    Intervals(37,:) = [17689, 17847];
    Intervals(40,:) = [19084, 19247];
    Intervals(47,:) = [22670, 22830];
    Intervals(48,:) = [23256, 23402];
elseif (Name_Prefix == "P15_brace1_v")
    Intervals(5,:) = [1881, 2058];
    Intervals(6,:) = [2260, 2513];
    Intervals(7,:) = [2822, 3051];
    Intervals(25,:) = [10998, 11134];
elseif (Name_Prefix == "P15_brace2_v")
    Intervals(4,:) = [1261, 1459];
    Intervals(5,:) = [1704, 1896];
    Intervals(8,:) = [3571, 3795];
    Intervals(11,:) = [5000, 5202];
    Intervals(12,:) = [5473, 5670];
    Intervals(13,:) = [5989, 6178];
    Intervals(15,:) = [7121, 7360];
    Intervals(33,:) = [15806, 15973];
    Intervals(35,:) = [16561, 16755];
    Intervals(42,:) = [19716, 20017];
elseif (Name_Prefix == "P16_healthy_v")
    Intervals(5,:) = [1625, 1767];
elseif (Name_Prefix == "P16_brace1_v")
    Intervals(10,:) = [3915, 4057];
    Intervals(27,:) = [10509, 10604];
elseif (Name_Prefix == "P16_brace2_v")
    Intervals(4,:) = [1306, 1461];
    Intervals(13,:) = [4790, 4973];
    Intervals(46,:) = [17902, 18065];
end

Intervals
length(Intervals)

save(strcat('Determined_Intervals_Dwell\',Name_Prefix,'_Intervals'),'Intervals')



figure(1)
clf

hold on
grid on

% Grid
GRIDY = 0;
% Horizontal Lines
line([-900 900],[GRIDY GRIDY],[1300 1300],'color','k','linestyle','--','linewidth',2)
line([-900 900],[GRIDY GRIDY],[1000 1000],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[700 700],'color','k','linestyle','--','linewidth',1)
%center
line([-900 900],[GRIDY GRIDY],[400 400],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[100 100],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[-200 -200],'color','k','linestyle','--','linewidth',1)
line([-900 900],[GRIDY GRIDY],[-500 -500],'color','k','linestyle','--','linewidth',2)
% Vertical Lines
line([900 900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)
line([-900 -900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)

view(-133,13)

%title('Identified Reaching Trajectories')


for i = 1:length(Intervals(:,1))


    % This is the interval between the peaks
    A = Intervals(i,1);    % Start of motion (near body)
    B = Intervals(i,2);    % End of motion (at grid)


    map = lines(7);

    if (i<8)
        C = map(1,:);
    elseif (i<15)
        C = map(2,:);
    elseif (i<22)
        C = map(3,:);
    elseif (i<29)
        C = map(4,:);
    elseif (i<36)
        C = map(5,:);
    elseif (i<43)
        C = map(6,:);
    elseif (i<49)
        C = map(7,:);
    end

    plot3(WristR_Mid(A:B,1),WristR_Mid(A:B,2),WristR_Mid(A:B,3),'linewidth',1.2,'Color',C);

    %text(WristR_Mid(B,1),WristR_Mid(B,2)+40,WristR_Mid(B,3)+50,num2str(i),'FontSize',13)


    if (i == 1)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+60,'1','FontSize',13)
    elseif (i == 8)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+60,'8','FontSize',13)
    elseif (i == 15)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+60,'15','FontSize',13)
    elseif (i == 22)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+10,WristR_Mid(B,3)+70,'22','FontSize',13)
    elseif (i == 29)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+70,'29','FontSize',13)
    elseif (i == 36)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+70,'36','FontSize',13)
    elseif (i == 43)
        text(WristR_Mid(B,1),WristR_Mid(B,2)+30,WristR_Mid(B,3)+70,'43','FontSize',13)
    end

end

xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')

set(gca,'FontSize',16)


axis([-1000,1500,-800,250,-1000,1500])
axis square



figure(2)
clf
hold on
plot(WristR_Mid(:,2),':','linewidth',1)
ylabel('Wrist Y Position (mm)')
xlabel('Time (samples)')
for i = 1: length(Intervals(:,1))
    % This is the interval between the peaks
    A = Intervals(i,1); % End of motion (at grid)
    B = Intervals(i,2);   % Start of motion (near body)

    plot(A:B,WristR_Mid(A:B,2),'b','linewidth',2.5);

    text(B,WristR_Mid(B,2)+60,num2str(i))
end

axis([0, X_lim, -Y_lim, 0])

end



