% -------------------------------------------------------------------------
%  File : DynamicWindowApproachSample.m 
%  Discription : Mobile Robot Motion Planning with Dynamic Window Approach 
%  Environment : Matlab
% log: 20181031 增加详细的注释信息 下标的定义 
% 20181101 ：增加画出障碍物的大小，更直观的看到障碍物和机器人之间的位置关系 
% ------------------------------------------------------------------------- 


function [] = dwan() 

close all; 
clear all; %#ok<CLALL>

disp('Dynamic Window Approach sample program start!!')

goal = [10,10]; % 目标点位置 [x(m),y(m)] 
date=load('shuju3.txt');
x=date(:,1);
y=date(:,2);

% obstacle=load('shuju1.txt');
obstacle=[
%           0 2; 
%           2 4; 
%           2 5; 
%           4 2; 
          4 4; 
%           5 4; 
          5 5; 
%           5 6; 
%           5 9 
%           8 8 
%           8 9 
%           7 9
%             0 10
          ]; 
      % obstacle=[0 2; 
      % 4 2; 
      % 4 4; 
      % 5 4; 
      % 5 5; 
      % 5 6; 
      % 5 9 
      % 8 8 
      % 8 9 
      % 7 9 
      % 6 5
      % 6 3 
      % 6 8 
      % 6 7
      % 7 4 
      % 9 8 
      % 9 11
      % 9 6]; 
      
      obstacleR = 0.5;% 冲突判定用的障碍物半径 
      
      area = [-1 15 -1 15];% 模拟区域范围 [xmin xmax ymin ymax] 
      
      % 模拟实验的结果 
%       result.x=[]; %累积存储走过的轨迹点的状态值 
%       tic; % 估算程序运行时间开始 
      
      % movcount=0; 
      %% Main loop 循环运行 5000次 指导达到目的地 或者 5000次运行结束 
      for i = 1:1
          % DWA参数输入 返回控制量 u = [v(m/s),w(rad/s)] 和 轨迹 
          
          % 历史轨迹的保存 
%           result.x = [result.x; x']; %最新结果 以列的形式 添加到result.x 
%          lmy=[x y];
%         disp(i);
%         disp(length(date(:,1)));
%         disp(x(i));
%           if i==length(date(:,1)) % norm函数来求得坐标上的两个点之间的距离 
%               disp('Arrive Goal!!');break; 
%           end
%           plot(x(i),y(i),'-b');hold on; % 绘制走过的所有位置 所有历史数据的 X、Y坐标
          %====Animation==== 
          hold off; % 关闭图形保持功能。 新图出现时，取消原图的显示。 
%           ArrowLength = 0.5; % 箭头长度 
%           plot(x(i),y(i),'-b');hold on; % 绘制走过的所有位置 所有历史数据的 X、Y坐标
          % 机器人 
          % quiver(x,y,u,v) 在 x 和 y 中每个对应元素对组所指定的坐标处将向量绘制为箭头 
%           quiver(x(POSE_X), x(POSE_Y), ArrowLength*cos(x(YAW_ANGLE)), ArrowLength*sin(x(YAW_ANGLE)), 'ok'); % 绘制机器人当前位置的航向箭头 
          hold on; %启动图形保持功能，当前坐标轴和图形都将保持，从此绘制的图形都将添加在这个图形的基础上，并自动调整坐标轴的范围 
          
           plot(x,y,'-b');hold on; % 绘制走过的所有位置 所有历史数据的 X、Y坐标 
          plot(goal(1),goal(2),'*r');hold on; % 绘制目标位置 
          
          %plot(obstacle(:,1),obstacle(:,2),'*k');hold on; % 绘制所有障碍物位置 
          DrawObstacle_plot(obstacle,obstacleR); 
                    
          axis(area); %根据area设置当前图形的坐标范围，分别为x轴的最小、最大值，y轴的最小最大值 
          grid on; 
          drawnow; %刷新屏幕. 当代码执行时间长，需要反复执行plot时，Matlab程序不会马上把图像画到figure上，这时，要想实时看到图像的每一步变化情况，需要使用这个语句。 
          %movcount = movcount+1; 
          %mov(movcount) = getframe(gcf);% 记录动画帧 
      end
%       toc %输出程序运行时间 形式：时间已过 ** 秒。 
      %movie2avi(mov,'movie.avi'); %录制过程动画 保存为 movie.avi 文件 
      
      %% 绘制所有障碍物位置 
      % 输入参数：obstacle 所有障碍物的坐标 obstacleR 障碍物的半径 
      function [] = DrawObstacle_plot(obstacle,obstacleR) 
          r = obstacleR; 
          theta = 0:pi/20:2*pi; 
          for id=1:length(obstacle(:,1)) 
              x = r * cos(theta) + obstacle(id,1); 
              y = r *sin(theta) + obstacle(id,2); 
              plot(x,y,'-m');hold on; 
          end
          % plot(obstacle(:,1),obstacle(:,2),'*m');hold on; % 绘制所有障碍物位置 
                                                      %% END