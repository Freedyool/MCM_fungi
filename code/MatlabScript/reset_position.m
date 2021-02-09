function [position,quantity] = reset_position(space_2d,type)
grid_size = length(space_2d);

position = zeros(grid_size^2,2,type);%记录每个种群所占的格点位置
quantity = zeros(1,type);%记录每个种群的格点总数

% 按种类提取
for i=1:type
    [x,y]=find(space_2d==i);
    quantity(i) = length(x);
    position(1:quantity(i),1:2,i) = [x y];
end

% 按格点归类
% for i=1:size
%     for j=1:size
%         type_ind = spce_2d(i,j);
%         quantity(type_ind) = quantity(type_ind) + 1;
%         position(quantity(type_ind),:,type_ind) = [i,j];
%     end
% end

