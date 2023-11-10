close all
clear

Subject = "P15";
Condition = "brace1";
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
Fin = Intervals(num1:num2,2);

Time_Step = Fin
Thrx_Ed = Thorax_OM(Fin,:);
Sh_Ed = RSh_OM(Fin,:);
Elb_Ed = RElbow_OM(Fin,:);
Wr_Ed = RWrist_OM(Fin,:);
Pv_Ed = Pelvis_OM(Fin,:);
He_Ed = Head_OM(Fin,:);




for i = 1:length(Fin)

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
    scatter3(Wr_Ed(i,1),Wr_Ed(i,2),Wr_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Elb_Ed(i,1),Elb_Ed(i,2),Elb_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Sh_Ed(i,1),Sh_Ed(i,2),Sh_Ed(i,3),40,'MarkerFaceColor','r');
    scatter3(Thrx_Ed(i,1),Thrx_Ed(i,2),Thrx_Ed(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(Pv_Ed(i,1),Pv_Ed(i,2),Pv_Ed(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
    scatter3(He_Ed(i,1),He_Ed(i,2),He_Ed(i,3),40,'MarkerFaceColor','b','MarkerEdgeColor','b');

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
    plot3([Wr_Ed(i,1), Elb_Ed(i,1)], [Wr_Ed(i,2), Elb_Ed(i,2)], [Wr_Ed(i,3), Elb_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Elb_Ed(i,1), Sh_Ed(i,1)], [Elb_Ed(i,2), Sh_Ed(i,2)], [Elb_Ed(i,3), Sh_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Sh_Ed(i,1), Thrx_Ed(i,1)], [Sh_Ed(i,2), Thrx_Ed(i,2)], [Sh_Ed(i,3), Thrx_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_Ed(i,1), He_Ed(i,1)], [Thrx_Ed(i,2), He_Ed(i,2)], [Thrx_Ed(i,3), He_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Thrx_Ed(i,1), Pv_Ed(i,1)], [Thrx_Ed(i,2), Pv_Ed(i,2)], [Thrx_Ed(i,3), Pv_Ed(i,3)],'linewidth',2,'Color','k')
    plot3([Pv_Ed(i,1), RX], [Pv_Ed(i,2), RY], [Pv_Ed(i,3), RZ],'linewidth',2,'Color','k','LineStyle','--')
    plot3([Pv_Ed(i,1), LX], [Pv_Ed(i,2), LY], [Pv_Ed(i,3), LZ],'linewidth',2,'Color','k','LineStyle','--')

    axis([-1000,1500,-1500,500,-1000,1500])
    axis equal

    xlabel('X(mm)')
    ylabel('Y(mm)')
    zlabel('Z(mm)')
    view(30, 10)

    picFile = "Visualization\" + Subject + "\" + Condition + "\" + Direction + "\" + Name_Prefix + "_" + i + ".png";

    saveas(gca,picFile)
end

endFile = "End_Joint_Location\" + Name_Prefix + "_End_Loc";
save(endFile,"Time_Step", "Thrx_Ed", "Sh_Ed", "Elb_Ed", "Wr_Ed", "Pv_Ed", "He_Ed");

