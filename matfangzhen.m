%% ����
A=2;B=rand(1000);c=1i*B;
 whos
 linespace();%���Բ���
% ��ֵ��
cat();
%size()  length() ndims()ά��  numel()Ԫ������
% : ���ʶ�Ԫ��
det()%�����������ʽ
%\�����/�ҳ�
A=[2,4;3,1];
B=[3,2;4,6];
%A*B
%A.*B
t=1:0.01:pi;y=sin(t.^3);plot(t,y)

% �ַ���
%num2str();
%str2num();
%disp();
class()%��ѯ��������

% Ԫ������
cell();
%A(1,1)={};
cellplot();
% ������ ���з������������ֿܷ���ע���в�������
%A{}%���ݷ���

% �ṹ������
struct();
data(2,3)=struct('name',[],'id',[],'score',[]);

%% m�ļ�
% script1.m,  M�ű���ϰ-������ά����ͼ  clc;close all
clear	    % ����ڴ��е����б���		
x=linspace(-6,6,36);			
y=linspace(-6,6,36);   % ����������	
[xx,yy]=meshgrid(x,y);	% ��x��y�ľ�����  
               % �ڻ�����������������	
zz=yy./(xx.^2+yy.^2+1);
surf(xx,yy,zz);      % ������ά����ͼ����
axis tight	 
% �����ݷ�Χ��Ϊ���귶Χ��ʹͼ�κ����������
%% �������
%��������
% @ȡ�������
%plot();
% t=0:0.01:pi;  
% y=sin(t.^3);
% plot(t,y,'r-d')
% axis([0 3.5 -1 1]);   %ָ����ķ�Χ
% xlabel('t','FontSize',12); 
% ylabel('sin(t^3)', 'FontSize',12); 
%  % ��x��y����ϱ�ǣ�ͬʱָ��12������
% M�ļ�
% t=(0:0.02:2)*pi;
% x=sin(t); y=cos(t); z=cos(2*t);
% plot3(x,y,z,'b-',x,y,z,'bd')
% view([-82,58])    % �����ӽ�
% xlabel('sint','FontSize',12),ylabel('cost','FontSize',12),zlabel('cos2t','FontSize',12)
% legend('��','��ʯ')    % ��ͼ��

% x=[1,2];
% y=[1,2];
% [X,Y]=meshgrid(x,y);
% plot(X,Y);hold on
% plot(Y,X);
% axis(0,3,0,3);
% get()  gcf gca gco;
%��Ի�����