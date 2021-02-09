function [position,num] = single_extend(position, quantity, grid_size, rate)
% 抽取群落边界（n*2）row：x y
% disp(position(1:quantity,:));
boundry = [];
% 遍历菌群集合
for i=1:quantity
    x = position(i,1);y = position(i,2);
    A = [x-1,y-1;x-1,y+1;x+1,y-1;x+1,y+1];
%     disp(ismember(A,position,'rows'));
    if sum(ismember(A,position,'rows')) < 4
        boundry(end+1,1:2) = [x,y];
    end
end
% disp(length(boundry(:,1)));
if isempty(boundry)
    num = 0;
    return
end
len = length(boundry(:,1));
% 临时存储扩张格点数据（m*2）row：x y
tmp_grid = [];
% 遍历菌群边界点集合

for i=1:len
%     disp(i);
    x = boundry(i,1);y = boundry(i,2);
    for ii=-rate:rate
        for jj=-rate:rate
%             % 十字型扩展
%             if abs(ii)+abs(jj)<=rate
            % 圆型扩展
            if ii^2+jj^2<=rate^2
                xx=x+ii;yy=y+jj;
                if xx<=grid_size && xx>0 && yy<=grid_size && yy>0
                    tmp_grid(end+1,1:2) = [xx,yy];
                end
            end
        end
    end
end
% 临时格点tmp_grid去重
if isempty(tmp_grid)
    num = 0;
    return
end
tmp_grid = unique(tmp_grid,'rows');
% tmp_grid-position 得到可能产生领土更新时间的格点集合
tmp_matrix = setdiff(tmp_grid,position,'rows','stable');
num = length(tmp_matrix(:,1));
position(1:num,:) = tmp_matrix;
