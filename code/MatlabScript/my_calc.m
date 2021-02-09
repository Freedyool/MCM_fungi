% %% 模型对温度的敏感度分析
% theta = 1;%mm 精度
% wide = 50;%mm
% grid_size = wide/theta; % 网格大小
% type = 37;% 菌落种类 第38种为空格点（可被任意菌落侵占）
% period = 30;% day 实验时长
% load('compe.mat');
% tempreture = ones(1,period)*22;
% moisture_class = 2;load(strcat('gr',num2str(moisture_class),'.mat'));
% for 22*
%       
% 
% day = 1;
% space_2d = ones(grid_size)*(type+1);
% for i=1:37
%     space_2d(ceil(rand()*grid_size),ceil(rand()*grid_size)) = i;
% end
% space_backup = space_2d;
% [position,quantity(day,:)] = reset_position(space_2d,type);
% extend_position = zeros(grid_size^2,2,type);
% num = zeros(1,type);

%% 实验统计
load('dr.mat');%per_de_rate(37*451)
% load('5-9.mat');%quantity((period+1)*37)
% load('3-k=1.mat'),load('3-k=1_t.mat');
% load('2-28.mat')
[day,type] = size(quantity);
period = day-1;
S = sum(quantity(day,:));

tempreture = ones(1,period)*22;% 温度
de_rate = zeros(1,period);
D = zeros(1,period);

for i = 1:period
    temp = round(tempreture(i)/0.1)*0.1;
    % 计算温度索引
    ind = round((temp+5)/0.1+1);
    
%     disp([day,temp,ind]);
    
    % 计算每日分解率 = 面积占比（格点统计个数*格点单位面积）*单位面积天数的分解率
    de_rate(i) = quantity(i+1,:)/S*per_de_rate(:,ind);
    
    % 计算生物多样性
    N = sum(quantity(i+1,:));
    sum_n2 = sum(quantity(i+1,:).^2);
    D(i) = (N-sqrt(sum_n2))/(N-sqrt(N));
end
% 生物多样性与分解率之间的关系
de_rate = de_rate/122;
disp(sum(de_rate));
% scatter(D(40:180),de_rate(40:180));
subplot(221),plot(tempreture),title('tempreture');
subplot(222),plot(de_rate),title('de_rate');
subplot(223),plot(D),title('D');
