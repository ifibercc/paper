clc;
clear;
% AΪ��ʼ���󣬸�Ϊ��Ӧ���뼴��
A=[
1	2	2	2	2
1/2	1	1	1	1
1/2	1	1	1	1
1/2	1	1	1	1
1/2	1	1	1	1

];

B=A;
col=sum(A,1);
% ���м���������3��Ϊ��Ӧ���ּ���
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
    M=M+(Cout(i,1)/row(i,1))/d;              %�˴���3�ɸ���i���ģ���i��Ϊ5�����Ӧ���
end

MA=M