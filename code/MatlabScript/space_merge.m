function space_2d = space_merge(space_2d,ex_position, num,compe)
[~,~,type] = size(ex_position);
pre_mat = [0,0];
% x y old n new1 new2...

%（除原有菌落外所有在下一次迭代中可以生长至该格点的菌落被定义为挑战者）
for i =1:type
    for j=1:num(i)
        % 获取格点坐标
        x = ex_position(j,1,i);
        y = ex_position(j,2,i);
%         disp([x,y]);
        % 获取挑战者列表中的个数
        ind = my_find(pre_mat,x,y);
        if ind == 0
            % 还没有挑战者 增加该格点的挑战者记录（添加新行）
            pre_mat(end+1,1:5) = [x,y,space_2d(x,y),1,i];
        else
            % 已有挑战者 则在已有的挑战者记录后追加（不添加新行）
            pre_mat(ind,4) = pre_mat(ind,4)+1;
            pre_mat(ind,4+pre_mat(ind,4)) = i;
        end
    end
end
pre_mat(1,:) =[];
% disp(pre_mat);
len = length(pre_mat);

for i=1:len
%     disp(pre_mat(i,1:4+pre_mat(i,4)));
    x = pre_mat(i,1);y = pre_mat(i,2);
    old_type = pre_mat(i,3);
    new_type = pre_mat(i,5:4+pre_mat(i,4));
%     disp(new_type);
    % 获取有关old_type的竞争情况
    row = compe(old_type,:);
    % 地理上生长存在重叠的待选物种 与 生理上会侵占old_type的待选物种 取交集
    new_type = intersect(new_type, find(row == 0));
    % 获取待选菌落的大小
    num = length(new_type);
    % 所有陷入僵局的情况均遵循先来后到原则
    switch(num)
        case 0
%                 disp('无变化');
        case 1
%                 disp('被侵占');
            space_2d(x,y) = new_type;
        otherwise
            % 有多个待选菌落 则等概率地取一个
%                 disp(['被多个侵占',num]);
            space_2d(x,y) = new_type(ceil(rand(1)*num));
    end
end
