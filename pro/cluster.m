clear
close all
%% 加载数据
data = xlsread('YongXing/atom/5.xlsx');
%% 10:30 - 17:00时间段 yi
t1 =6; t2 = 3; t3 = 4; t4 = 2; 
dd1 = 72; dd2 = 77;
d1 = t1 / 390;
p1 = t1 /390;
for i=0:390
      data(330 + i, 18) = data(330 + i, 18) + p1;
      p1 = p1 + d1; 
end
data(721:901, 18) = data(721 : 901, 18)+t1;
%% 17:00 - 18:00时间段 yi
d2 = t2 / 60;
p2 = t2 / 60;
for i=0:60
   data(721 + i,18)=data(721 + i, 18) - p2;
   p2 = p2 + d2;
end
data(782:901, 18) = data(782 : 901, 18)-t2;
%% 10:30 - 17:00时间段 jia
d3 = t3 / 390;
p3 = t3 /390;
for i=0:390
      data(330 + i, 19) = data(330 + i, 19) + p3;
      p3 = p3 + d3; 
end
data(721:901, 19) = data(721 : 901, 19)+t3;
%% 17:00 - 18:00时间段 jia
d4 = t4 / 60;
p4 = t4 / 60;
for i=0:60
   data(721 + i,19)=data(721 + i, 19) - p4;
   p4 = p4 + d4;
end
data(782:901, 19) = data(782 : 901, 19)-t4;
%% 5change
t5=2;
d5 = t5 / 273;
p5 = t5 / 273;
for i=0:273
   data(403 + i,16)=data(403 + i, 16) - p5;
   p5 = p5 + d5;
end
data(677:901, 16) = data(677 : 901, 16)-t5;
%%
jiachu = data(61:901,16);
jiamu = -data(61:901,19)+dd1;
yichu = data(61:901,17);
yimu = -data(61:901,18)+dd2;

jiaF = DiscreteFrechetDist(jiachu, jiamu);
yiF = DiscreteFrechetDist(yichu, yimu);
%% 计算甲
 [jiamuMaxVal, jiamuMaxSeq] = max(jiamu(1:120));
 [jiamuMinVal, jiamuMinSeq] = min(jiamu(600:720));
 [jiachuMaxVal, jiachuMaxSeq] = max(jiachu(1:120));
 [jiachuMinVal, jiachuMinSeq] = min(jiachu(600:720));
 
 jiaEx = 1-abs((jiamuMaxSeq-jiamuMinSeq)/(jiachuMaxSeq-jiachuMinSeq));
 jiaEy = 1-(jiamuMaxVal-jiamuMinVal)/(jiachuMaxVal-jiachuMinVal);
 jiaDy = jiamuMinVal - jiachuMinVal + jiamuMaxVal - jiachuMaxVal;
 
 jiachuTemp = jiachu(600:720);
 jiamuTemp = jiamu(600:720);
 jiaDis = 0;
 for i = 1 : 15
    [~, jiachuDisMin] = min(jiachuTemp);
    [~, jiamuDisMin] = min(jiamuTemp);
    jiaDis = jiaDis + jiamuDisMin - jiachuDisMin;
    jiachuTemp(jiachuDisMin) = 100;
    jiamuTemp(jiamuDisMin) = 100;
 end
 jiaDx = jiaDis / 15;
      
 jiaRes = [jiaF, jiaDx, jiaDy, jiaEx, jiaEy];
 %% 计算乙
 [yimuMaxVal, yimuMaxSeq] = max(yimu);
 [yimuMinVal, yimuMinSeq] = min(yimu);
 [yichuMaxVal, yichuMaxSeq] = max(yichu);
 [yichuMinVal, yichuMinSeq] = min(yichu);

 yiEx = 1-abs((yimuMaxSeq-yimuMinSeq)/(yichuMaxSeq-yichuMinSeq));
 yiEy = 1-(yimuMaxVal-yimuMinVal)/(yichuMaxVal-yichuMinVal);
 yiDy = yimuMinVal - yichuMinVal + yimuMaxVal - yichuMaxVal;
 
  
 yichuTemp = yichu(620:700);
 yimuTemp = yimu(620:700);
 yiDis = 0;
 for i = 1 : 17
    [~, yichuDisMin] = min(yichuTemp);
    [~, yimuDisMin] = min(yimuTemp);
    yiDis = yiDis + yimuDisMin - yichuDisMin;
    yichuTemp(yichuDisMin) = 100;
    yimuTemp(yimuDisMin) = 100;
 end
 yiDx = yiDis / 17;
 
 yiRes = [yiF, yiDx, yiDy, yiEx, yiEy];
 
 final = [jiaRes;yiRes];
 
 %% 画图
plot(data(61:901,13),jiamu,'linewidth',2)
hold on
plot(data(61:901,13),jiachu)
plot(data(61:901,13),yimu,'linewidth',2)
plot(data(61:901,13),yichu)

datetick('x','HH')
xlabel('日期/天')
ylabel('温度/^oC')
legend('甲锅炉房目标温度','甲锅炉房出水温度','乙锅炉房目标温度','乙锅炉房出水温度')