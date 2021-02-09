function ind = my_find(pre_mat,x,y)
% 找到所有x==x0的行号
indd = find(pre_mat(:,1)==x);
is_exist = false;
for i = 1:length(indd)
    % 判断所在行的y是否与y0相等
    if pre_mat(indd(i),2) == y
        ind = indd(i);
        is_exist = true;
        break;
    end
end

if ~is_exist
    ind = 0;
end
