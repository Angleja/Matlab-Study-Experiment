%% 例子
A=2;B=rand(1000);c=1i*B;
 whos
 linespace();%线性采样
% 数值型
cat();
%size()  length() ndims()维度  numel()元素总数
% : 访问多元素
det()%计算矩阵行列式
%\左除，/右除
A=[2,4;3,1];
B=[3,2;4,6];
%A*B
%A.*B
t=1:0.01:pi;y=sin(t.^3);plot(t,y)

% 字符型
%num2str();
%str2num();
%disp();
class()%查询变量类型

% 元胞数组
cell();
%A(1,1)={};
cellplot();
% ”…” 续行符，变量名不能分开，注释行不能续行
%A{}%内容访问

% 结构体数组
struct();
data(2,3)=struct('name',[],'id',[],'score',[]);

%% m文件
% script1.m,  M脚本练习-绘制三维函数图  clc;close all
clear	    % 清除内存中的所有变量		
x=linspace(-6,6,36);			
y=linspace(-6,6,36);   % 创建行向量	
[xx,yy]=meshgrid(x,y);	% 在x、y的矩形区  
               % 内划分网格，输出格点坐标	
zz=yy./(xx.^2+yy.^2+1);
surf(xx,yy,zz);      % 绘制三维曲面图命令
axis tight	 
% 把数据范围设为坐标范围，使图形和坐标轴紧凑
%% 函数句柄
%匿名函数
% @取句柄运算
%plot();
% t=0:0.01:pi;  
% y=sin(t.^3);
% plot(t,y,'r-d')
% axis([0 3.5 -1 1]);   %指定轴的范围
% xlabel('t','FontSize',12); 
% ylabel('sin(t^3)', 'FontSize',12); 
%  % 给x、y轴打上标记，同时指定12号字体
% M文件
% t=(0:0.02:2)*pi;
% x=sin(t); y=cos(t); z=cos(2*t);
% plot3(x,y,z,'b-',x,y,z,'bd')
% view([-82,58])    % 调整视角
% xlabel('sint','FontSize',12),ylabel('cost','FontSize',12),zlabel('cos2t','FontSize',12)
% legend('链','宝石')    % 加图例

% x=[1,2];
% y=[1,2];
% [X,Y]=meshgrid(x,y);
% plot(X,Y);hold on
% plot(Y,X);
% axis(0,3,0,3);
% get()  gcf gca gco;
%相对化坐标