clc;
clear;
% A为初始矩阵，改为对应输入即可
A=[
1	2	2	2	2
1/2	1	1	1	1
1/2	1	1	1	1
1/2	1	1	1	1
1/2	1	1	1	1

];

B=A;
col=sum(A,1);
% 共有几个变量则将3改为对应数字即可
d = 5;
for i=1:d
    for j=1:d
        A(i,j)=A(i,j)/col(1,j);
    end
end

row=sum(A,2);
row=row./sum(row)

Cout=B*row;
M=0;
for i=1:d
    M=M+(Cout(i,1)/row(i,1))/d;              %此处除3可根据i更改，若i改为5，则对应变更
end

MA=M