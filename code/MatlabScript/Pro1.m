%% 两物种对抗测试
% 情形一：A物种胜利
% 情形二：AB僵持
% 实验环境 网格大小 200*200 实验时长10天 温度恒定22摄氏度 湿度恒定0.4apm
% A在标况下 生长速度为2格/天 B为5格/天
% A的分解率待计算

% sys parameters
theta = 1;%mm 精度
wide = 20;%mm
grid_size = wide/theta; % 网格大小
type = 2;% 菌落种类 第type+1种为空格点（可被任意菌落侵占）
period = 20;%day 实验时长

% env parameters
%   A   B   s
%A  NA  1   1
%B  0   NA  1
%s  0   0   NA
compe = [nan,1,1;0,nan,1;0,0,nan];% 非对称竞争关系 compe(i,j)=1表示i->j中 i获胜
rate = [1,2];
per_de_rate = rand(1,type)*10;% 某种菌落单位面积时间的分解率
tempreture = ones(1,period)*22;% 温度
moisture_class = 1;% 水分

%% 三物种对抗测试
% 情形一：A物种胜利
% 情形二：AB僵持
% 实验环境 网格大小 200*200 实验时长10天 温度恒定22摄氏度 湿度恒定0.4apm
% A在标况下 生长速度为2格/天 B为5格/天
% A的分解率待计算

% sys parameters
theta = 0.5;%mm 精度
wide = 20;%mm
grid_size = wide/theta; % 网格大小
type = 3;% 菌落种类 第type+1种为空格点（可被任意菌落侵占）
period = 50;%day 实验时长

% env parameters
%   A   B   C   s
%A  NA  1   0   1
%B  0   NA  1   1
%C  1   0   NA  1
%s  0   0   0   NA
compe = [nan,1,0,1;0,nan,1,1;1,0,nan,1;0,0,0,nan];% 非对称竞争关系 compe(i,j)=1表示i->j中 i获胜
rate = [1,2,2];% 对应每个菌种的生长速度
per_de_rate = rand(1,type)*10;% 某种菌落单位面积时间的分解率
tempreture = ones(1,period)*22;% 温度
moisture_class = 1;% 水分
load(strcat('gr',num2str(moisture_class),'.mat'));
load('dr.mat');

%% 自然环境完整测试
% sys parameters
theta = 1;%mm 精度
wide = 50;%mm
grid_size = wide/theta; % 网格大小
type = 37;% 菌落种类 第38种为空格点（可被任意菌落侵占）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
period = 20;%day 实验时长
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% env parameters
load('compe.mat');% 非对称竞争关系 compe(i,j)=1表示i-j中 i获胜
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('c1_1.mat');% 温度
% round(rand(1)*(366-period))
% tempreture = temp(1:period);% 获取某段时间的温度
tempreture = ones(1,period)*22;% 温度
moisture_class = 5;% 雨林(1) 树木(2) 温带(3) 半干旱(4) 干旱(5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(strcat('gr',num2str(moisture_class),'.mat'));

%% excu
reset = 0;% 1：重置 0：继续(继续执行需要首先运行上块代码 并修改period的值)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% omit_list = [12,17,18,37,20,10,19,36];% 去除攻击性最强 生长速度最快的菌落 only work when reset==1
omit_list = [12,18,17,37,20,10,19];% 树木和雨林几乎一致
% omit_list = [0];
%14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% init
quantity = zeros(period,type);%记录每个种群的格点总数 122*37
% 构造格点 以及实验的初始化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if reset == 1
    day = 1;
    space_2d = ones(grid_size)*(type+1);
    for i=1:37
        if find(omit_list==i)
            continue;
        end
        space_2d(ceil(rand()*grid_size),ceil(rand()*grid_size)) = i;
    end
    space_backup = space_2d;
else
%     quantity(1:day,:) = quantity_backup;
    day =1;
    space_2d = space_backup;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure,image(space_2d*6);

[position,quantity(day,:)] = reset_position(space_2d,type);%获取种群点集和个数统计 160000*2*37
extend_position = zeros(grid_size^2,2,type);%记录种群迭代过程的临时增长点集 160000*2*37
num = zeros(1,type);% 记录每次即将增长的个数 1*37
tic;
% simulate
while day <= period
    temp = round(tempreture(day)/0.1)*0.1;
    % 计算温度索引
    ind = round((temp+5)/0.1+1);
    
    disp([day,temp,ind]);
    
    % 菌落生长模型
    for i = 1:type
%         disp(['菌种','0'+i]);
        
        % 获取指定物种 指定温度和湿度条件下的 生长速率(格/天)
%         disp('获取生长速度 调用get_growth_rate');
        ex_rate = ceil(growth_rate(i,ind)/theta);
%         disp([growth_rate(i,ind),ex_rate]);
        
        % 单菌落增长（仅受边界控制）获取可能出现冲突的待选集
%         disp('获取生长结果 调用single_extend');
        [extend_position(:,:,i),num(i)] = single_extend(position(:,:,i), quantity(day,i),grid_size,ex_rate);
    end
    
%     disp(num);
    % 解决菌落增长冲突（描述菌落间的相互作用）
%     disp('整合各菌落生长结果 调用space_merge');
    space_2d = space_merge(space_2d,extend_position,num,compe);
%     figure,image(space_2d*6);

    % 逐菌落统计所占格点个数
%     disp('统计格点 调用reset_position');
    [position,quantity(day+1,:)] = reset_position(space_2d,type);
    
    % 显示每天的生长结果
%     disp(quantity(day,:));
    
%     de_rate(day,1) = quantity(day+1,:)/S*per_de_rate(:,ind);
    % 迭代控制
    day = day+1;
end
% rate = [rate, sum(de_rate)];
toc;
figure();
subplot(221),imagesc(space_backup),title('start');
subplot(223),imagesc(space_2d),title('end');
subplot(122),plot(quantity),title('count');
[~,to_choose] = max(quantity(period,:));
disp(to_choose);
quantity_backup = quantity;
