%% a读取
for i=1:37
    load(strcat('D:\NUIST.2021\赛事与活动\数学建模\美赛\data\分解率\a\a',num2str(i),'.mat'))
end

%%
i = 1;
dr = [a1(i,:);a2(i,:);a3(i,:);a4(i,:);a5(i,:);a6(i,:);a7(i,:);a8(i,:);a9(i,:);a10(i,:);a11(i,:);a12(i,:);a13(i,:);a14(i,:);a15(i,:);a16(i,:);a17(i,:);a18(i,:);a19(i,:);a20(i,:);a21(i,:);a22(i,:);a23(i,:);a24(i,:);a25(i,:);a26(i,:);a27(i,:);a28(i,:);a29(i,:);a30(i,:);a31(i,:);a32(i,:);a33(i,:);a34(i,:);a35(i,:);a36(i,:);a37(i,:)];
%% b读取
for i=1:37
    load(strcat('D:\NUIST.2021\赛事与活动\数学建模\美赛\data\生长速率\b\b',num2str(i),'.mat'))
end

%%
i = 5;
gr5 = [b1(i,:);b2(i,:);b3(i,:);b4(i,:);b5(i,:);b6(i,:);b7(i,:);b8(i,:);b9(i,:);b10(i,:);b11(i,:);b12(i,:);b13(i,:);b14(i,:);b15(i,:);b16(i,:);b17(i,:);b18(i,:);b19(i,:);b20(i,:);b21(i,:);b22(i,:);b23(i,:);b24(i,:);b25(i,:);b26(i,:);b27(i,:);b28(i,:);b29(i,:);b30(i,:);b31(i,:);b32(i,:);b33(i,:);b34(i,:);b35(i,:);b36(i,:);b37(i,:)];
unique(gr5,'rows');

growth_rate = [2*gr2(:,1)-gr2(:,2) gr2];

%% 字符串工具
string = '';
for i=1:37
    string = strcat(string,'a',num2str(i),'(i,:);');
end
disp(string);

%%
for i=1:37
    plot(growth_rate(i,:)),hold on;
end

%% 
load('c1_2.mat');subplot(231),plot(temp),title('海南');
load('c1_3.mat');subplot(234),plot(temp);
load('c4_1.mat'),temp(53)=[];subplot(232),plot(temp),title('山西');
load('c4_2.mat');subplot(235),plot(temp);
load('c5_1.mat');subplot(233),plot(temp),title('江西');
load('c5_2.mat'),temp(90)=[];subplot(236),plot(temp);