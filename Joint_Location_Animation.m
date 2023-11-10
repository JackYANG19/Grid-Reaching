close all
clear

Subject = "P14";
Condition = "healthy";
Direction = "h";
Name_Prefix = Subject + "_" + Condition + "_" + Direction;
load(strcat('Processed_Origin\',Name_Prefix,'_Labelled_OM.mat'))
load(strcat('Determined_Intervals_Dwell\',Name_Prefix,'_Intervals.mat'))

% Fix NaN
if (Name_Prefix == "P13_brace2_v")
    Pelvis_OM = fillmissing(Pelvis_OM,'makima');
elseif (Name_Prefix == "P10_brace1_v")
    RWrist_OM= fillmissing(RWrist_OM,'makima');
end

gifFile = "Visualization\" + Subject + "\" + Condition + "\" + Direction + "\" + Name_Prefix + ".gif";


% Fix NaN Values
% Thrx_OM_P = fixNans(Thorax_OM);
% Sh_OM_P = fixNans(RSh_OM);
% Elb_OM_P = fixNans(RElbow_OM);
% Wr_OM_P = fixNans(RWrist_OM);
% Pv_OM_P = fixNans(Pelvis_OM);
% He_OM_P = fixNans(Head_OM);

Thrx_OM_P = Thorax_OM;
Sh_OM_P = RSh_OM;
Elb_OM_P = RElbow_OM;
Wr_OM_P = RWrist_OM;
Pv_OM_P = Pelvis_OM;
He_OM_P = Head_OM;

num1 = 35;
num2 = 35;
Start = Intervals(num1:num2,1);
Fin = Intervals(num1:num2,2);




% ANGLE = -45;
GRIDY = 0; % 200 for P11 0 for others

for j = 1:length(Start)
    A = Start(j);
    B = Fin(j);
    for i = A:10:B

        clf

        title(join(split(Name_Prefix,"_")))
        hold on
        grid on

        % Wrist Trace
        plot3(Wr_OM_P(A:B,1),Wr_OM_P(A:B,2),Wr_OM_P(A:B,3),'linewidth',0.5,'Color','b');

        % Origins (reaach is from right to left)
        scatter3(Wr_OM_P(i,1),Wr_OM_P(i,2),Wr_OM_P(i,3),40,'MarkerFaceColor','r');
        scatter3(Elb_OM_P(i,1),Elb_OM_P(i,2),Elb_OM_P(i,3),40,'MarkerFaceColor','r');
        scatter3(Sh_OM_P(i,1),Sh_OM_P(i,2),Sh_OM_P(i,3),40,'MarkerFaceColor','r');
        scatter3(Thrx_OM_P(i,1),Thrx_OM_P(i,2),Thrx_OM_P(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
        scatter3(Pv_OM_P(i,1),Pv_OM_P(i,2),Pv_OM_P(i,3),40,'MarkerFaceColor','k','MarkerEdgeColor','k');
        scatter3(He_OM_P(i,1),He_OM_P(i,2),He_OM_P(i,3),40,'MarkerFaceColor','b','MarkerEdgeColor','b');

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
        plot3([Wr_OM_P(i,1), Elb_OM_P(i,1)], [Wr_OM_P(i,2), Elb_OM_P(i,2)], [Wr_OM_P(i,3), Elb_OM_P(i,3)],'linewidth',2,'Color','k')
        plot3([Elb_OM_P(i,1), Sh_OM_P(i,1)], [Elb_OM_P(i,2), Sh_OM_P(i,2)], [Elb_OM_P(i,3), Sh_OM_P(i,3)],'linewidth',2,'Color','k')
        plot3([Sh_OM_P(i,1), Thrx_OM_P(i,1)], [Sh_OM_P(i,2), Thrx_OM_P(i,2)], [Sh_OM_P(i,3), Thrx_OM_P(i,3)],'linewidth',2,'Color','k')
        plot3([Thrx_OM_P(i,1), He_OM_P(i,1)], [Thrx_OM_P(i,2), He_OM_P(i,2)], [Thrx_OM_P(i,3), He_OM_P(i,3)],'linewidth',2,'Color','k')
        plot3([Thrx_OM_P(i,1), Pv_OM_P(i,1)], [Thrx_OM_P(i,2), Pv_OM_P(i,2)], [Thrx_OM_P(i,3), Pv_OM_P(i,3)],'linewidth',2,'Color','k')
        plot3([Pv_OM_P(i,1), RX], [Pv_OM_P(i,2), RY], [Pv_OM_P(i,3), RZ],'linewidth',2,'Color','k','LineStyle','--')
        plot3([Pv_OM_P(i,1), LX], [Pv_OM_P(i,2), LY], [Pv_OM_P(i,3), LZ],'linewidth',2,'Color','k','LineStyle','--')
        

        % Grid
        % % Horizontal Lines
        % line([-800 900],[-100 -100],[1200 1200],'color','k','linestyle','--','linewidth',2)
        % line([-800 900],[-100 -100],[-300 -300],'color','k','linestyle','--','linewidth',2)
        % 
        % % Vertical Lines
        % line([900 900],[-100 -100],[1200 -300],'color','k','linestyle','--','linewidth',2)
        % line([-800 -800],[-100 -100],[1200 -300],'color','k','linestyle','--','linewidth',2)

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

        axis([-1000,1500,-1500,500,-1000,1500])
        axis equal
        
        view(30, 10)
         % view(45,70)
        %ANGLE = ANGLE + 1;

        xlabel('X(mm)')
        ylabel('Y(mm)')
        zlabel('Z(mm)')
        
        % Store GIF

        pause(0.01)
        % exportgraphics(gca, gifFile, "Append",true);

    end

    pause(0.75)
    % exportgraphics(gca, gifFile, "Append",true);
% 
    % ANGLE = ANGLE + 15;
end



