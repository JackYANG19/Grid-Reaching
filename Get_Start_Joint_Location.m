close all
clear

Subject = "P16";
Condition = "healthy";
Direction = "v";
Name_Prefix = Subject + "_" + Condition + "_" + Direction;

load(strcat('Processed_Origin\',Name_Prefix,'_Labelled_OM.mat'))
load(strcat('Determined_Intervals_Dwell\',Name_Prefix,'_Intervals.mat'))

% Fix NaN
if (Name_Prefix == "P13_brace2_v")
    Pelvis_OM = fillmissing(Pelvis_OM,'makima');
end

num1 = 1;
num2 = 49;
Start = Intervals(num1:num2,1);

Time_Step = Start
Thrx_ST = Thorax_OM(Start,:);
Sh_ST = RSh_OM(Start,:);
Elb_ST = RElbow_OM(Start,:);
Wr_ST = RWrist_OM(Start,:);
Pv_ST = Pelvis_OM(Start,:);
He_ST = Head_OM(Start,:);




for i = 1:length(Start)

    clf

    title(join(split(Name_Prefix,"_")) + " Reach " + i)
    hold on
    grid on

    % Grid
    GRIDY = 0;
    % Horizontal Lines
    line([-900 900],[GRIDY GRIDY],[1300 1300],'color','k','linestyle','--','linewidth',2)
    % line([-900 900],[GRIDY GRIDY],[1000 1000],'color','k','linestyle','--','linewidth',1)
    % line([-900 900],[GRIDY GRIDY],[700 700],'color','k','linestyle','--','linewidth',1)
    % %center
    % line([-900 900],[GRIDY GRIDY],[400 400],'color','k','linestyle','--','linewidth',1)
    % line([-900 900],[GRIDY GRIDY],[100 100],'color','k','linestyle','--','linewidth',1)
    % line([-900 900],[GRIDY GRIDY],[-200 -200],'color','k','linestyle','--','linewidth',1)
    line([-900 900],[GRIDY GRIDY],[-500 -500],'color','k','linestyle','--','linewidth',2)

    % Vertical Lines
    line([900 900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)
    line([600 600],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',1)
    line([300 300],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',1)
    % center
    line([0 0],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',1)
    line([-300 -300],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',1)
    line([-600 -600],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',1)
    line([-900 -900],[GRIDY GRIDY],[1300 -500],'color','k','linestyle','--','linewidth',2)

    % Origins (reaach is from right to left)
    scatter3(Wr_ST(i,1),Wr_ST(i,2),Wr_ST(i,3),40,'MarkerFaceColor','r');
    scatter3(Elb_ST(i,1),Elb_ST(i,2),Elb_ST(i,3),40,'MarkerFaceColor','r');
    scatter3(Sh_ST(i,1),Sh_ST(i,2),Sh_ST(i,3),40,'MarkerFaceColor','r');
    scatter3(Thrx_ST(i,1),Thrx_ST(i,2),Thrx_ST(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(Pv_ST(i,1),Pv_ST(i,2),Pv_ST(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(He_ST(i,1),He_ST(i,2),He_ST(i,3),40,'MarkerFaceColor','b','MarkerEdgeColor','b');

    % Fake leg (600mm from the grid)
    RX = 150;
    RY = -600; % -400 for P11 -600 for others
    RZ = -675;

    LX = -50;
    LY = -600; % -400 for P11 -600 for others
    LZ = -675;

    scatter3(RX,RY,RZ,'MarkerFaceColor','k','MarkerEdgeColor','k')
    scatter3(LX,LY,LZ,'MarkerFaceColor','k','MarkerEdgeColor','k')

    % Connections
    plot3([Wr_ST(i,1), Elb_ST(i,1)], [Wr_ST(i,2), Elb_ST(i,2)], [Wr_ST(i,3), Elb_ST(i,3)],'linewidth',2,'Color','k')
    plot3([Elb_ST(i,1), Sh_ST(i,1)], [Elb_ST(i,2), Sh_ST(i,2)], [Elb_ST(i,3), Sh_ST(i,3)],'linewidth',2,'Color','k')
    plot3([Sh_ST(i,1), Thrx_ST(i,1)], [Sh_ST(i,2), Thrx_ST(i,2)], [Sh_ST(i,3), Thrx_ST(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_ST(i,1), He_ST(i,1)], [Thrx_ST(i,2), He_ST(i,2)], [Thrx_ST(i,3), He_ST(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_ST(i,1), Pv_ST(i,1)], [Thrx_ST(i,2), Pv_ST(i,2)], [Thrx_ST(i,3), Pv_ST(i,3)],'linewidth',2,'Color','k')
    plot3([Pv_ST(i,1), RX], [Pv_ST(i,2), RY], [Pv_ST(i,3), RZ],'linewidth',2,'Color','k','LineStyle','--')
    plot3([Pv_ST(i,1), LX], [Pv_ST(i,2), LY], [Pv_ST(i,3), LZ],'linewidth',2,'Color','k','LineStyle','--')

    axis([-1000,1500,-1500,500,-1000,1500])
    axis equal

    xlabel('X(mm)')
    ylabel('Y(mm)')
    zlabel('Z(mm)')
    view(30, 10)

    pause(0.1)

    % picFile = "Visualization\" + Subject + "\" + Condition + "\" + Direction + "\" + Name_Prefix + "_" + i + ".png";
    % 
    % saveas(gca,picFile)
end

StartFile = "Start_Joint_Location\" + Name_Prefix + "_Start_Loc";
save(StartFile,"Time_Step", "Thrx_ST", "Sh_ST", "Elb_ST", "Wr_ST", "Pv_ST", "He_ST");

