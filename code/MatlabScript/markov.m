%% C转化成P：竞争矩阵转换成概率转移矩阵
P=zeros(size(C));
m=size(C,1);
for i=1:m
    for j=1:m
        if i==j
            P(i,j)=getp(i,j,1:m,C,m);
        end
    end
end    
%% markov predict——要给定p0-初始的各个菌群的分布情况；p_new为单次迭代的结果，p_limit为极限概率
% 单次迭代
p_new=p0*P;
% 极限概率分布——长期、多次迭代趋于稳定的结果
a=[p'-eye(m);ones(1,m)];
b=[zeros(3,1);1];
p_limit=a\b;
