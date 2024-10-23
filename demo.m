%% 计算混沌系统的熵值分布-连续参数
clc;
clear;
addpath('./chao');
addpath('./entropy');
addpath('./util');


% 生成混沌序列
x0=rand;    
r = 4;
n=5000;
startR=3.5;
stepR=0.001;
endR=4.0;

% 存储熵值
pes = [];
aspes = [];

% 计算参数
m=5;
d=1;

for r=startR:stepR:endR
    x=logistic(x0, r, n);
    % 计算熵值
    [peValue]  = pe(x, m, d);
    [aspeValue]  = aspe(x, m, d);
    % 存储熵值
    pes = [pes,peValue];
    aspes = [aspes,aspeValue]; 
end

% 绘制

figure1 = figure;
set(figure1,'position',[708,352,860,320]);
color1 = [0.200000000000000	0.298039215686275	0.800000000000000];
color2 = [0.698039215686275	0	0.200000000000000];
% 加载数据
xs = startR:stepR:endR;
% 选择熵值
ys = pes;
name = 'Entropy';
% 选择熵值

linewidth = 2.5;
plot(xs,pes,'linewidth',linewidth,'Color',color1);
hold on;
plot(xs,aspes,'linewidth',linewidth,'Color',color2);
% 创建 legend
legend1 = legend({'PE','ASPE'});
set(legend1,'Position',[0.79390503875969 0.20468749696156 0.1 0.1453125],...
    'FontSize',18);
grid on;
box('on');
xlim([3.5,4]);
xlabel({'\alpha'},'FontSize',16,'fontname','Times New Roman');
ylabel({name},'FontSize',16,'fontname','Times New Roman')
