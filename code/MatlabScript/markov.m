%% Cת����P����������ת���ɸ���ת�ƾ���
P=zeros(size(C));
m=size(C,1);
for i=1:m
    for j=1:m
        if i==j
            P(i,j)=getp(i,j,1:m,C,m);
        end
    end
end    
%% markov predict����Ҫ����p0-��ʼ�ĸ�����Ⱥ�ķֲ������p_newΪ���ε����Ľ����p_limitΪ���޸���
% ���ε���
p_new=p0*P;
% ���޸��ʷֲ��������ڡ���ε��������ȶ��Ľ��
a=[p'-eye(m);ones(1,m)];
b=[zeros(3,1);1];
p_limit=a\b;
