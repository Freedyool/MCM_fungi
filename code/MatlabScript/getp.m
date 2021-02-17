function p_ij=getp(i,j,tind,cmat,new_m)
%% 转化
% new_m为行数列数
% c为竞争矩阵
tm=max(2,new_m);
tsum=0;
if(i==j)
    p_ij=1;
    for k=1:m
        if(k~=i && k~=j)
            p_ij=p_ij*(1-cmat(k,i)) ;
        end
    end
else
    p_ij=1/(tm-1)*cmat(i,j);
    if(length(tind)>3)
        for k=1:m
            if(k~=i && k~=j)
                tsum=tsum+cmat(j,k)*getp(i,j,tind(tind~=k),cmat,new_m-1);
            end
        end
    else
        for k=1:m
            if(k~=i && k~=j)
                tsum=tsum+cmat(j,k)*cmat(i,j);
            end
        end
    end
end
p_ij=p_ij+1/(tm-1)*tsum;
