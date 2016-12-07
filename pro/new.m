clear
close all
%tic;
res = zeros(62,8);
for N = 1 : 62
    if N == 40
        continue;
    end
    data = xlsread(['data/heat2/', num2str(N), '.xlsx']);
%% 加载数据
%% 10:30 - 17:00时间段 yi
t1 =6; t2 = 3; t3 = 4; t4 = 2; 
dd1 = 72; dd2 = 77;
d1 = t1 / 390;
p1 = t1 /390;
for i=0:390
      data(690 + i, 3) = data(690 + i, 3) + p1;
      p1 = p1 + d1; 
end
data(1081:1261, 3) = data(1081 : 1261, 3)+t1;
%% 17:00 - 18:00时间段 yi
d2 = t2 / 60;
p2 = t2 / 60;
for i=0:60
   data(1081 + i,3)=data(1081 + i, 3) - p2;
   p2 = p2 + d2;
end
data(1081:1261, 3) = data(1081 : 1261, 3)-t2;
%% 10:30 - 17:00时间段 jia
% d3 = t3 / 390;
% p3 = t3 /390;
% for i=0:390
%       data(330 + i, 19) = data(330 + i, 19) + p3;
%       p3 = p3 + d3; 
% end
% data(721:901, 19) = data(721 : 901, 19)+t3;
%% 17:00 - 18:00时间段 jia
d4 = t4 / 60;
p4 = t4 / 60;
for i=0:60
   data(1081 + i,3)=data(1081 + i, 3) - p4;
   p4 = p4 + d4;
end
data(1082:1261, 3) = data(1082 : 1261, 3)-t4;
%% 5change
t5=2;
d5 = t5 / 273;
p5 = t5 / 273;
for i=0:273
   data(763 + i,2)=data(763 + i, 2) - p5;
   p5 = p5 + d5;
end
data(1037:1261, 2) = data(1037 : 1261, 2)-t5;
%%
jiachu = data(421:1261,2);
jiamu = -data(421:1261,3)+dd1;
% yichu = data(61:901,17);
% yimu = -data(61:901,18)+dd2;

jiaF = DiscreteFrechetDist(jiachu, jiamu);
% yiF = DiscreteFrechetDist(yichu, yimu);
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
      
 %jiaRes = [jiaRes;[jiaF, jiaDx, jiaDy, jiaEx, jiaEy]];
 
 if N<63 
     res(N,1) = 2;
 end
 res(N,2) = data(8,1);
res(N,3) = jiaF;
res(N,4)= jiaDx;
res(N,5) = jiaDy;
res(N,6) = jiaEx;
res(N,7) = jiaEy;
 
end
res(28,:)=[];
 [idxbest, Cbest, sumDbest, Dbest]=kmeans(res,5);
 res(:,8) = idxbest;
toc;
 %% 计算乙
%  [yimuMaxVal, yimuMaxSeq] = max(yimu);
%  [yimuMinVal, yimuMinSeq] = min(yimu);
%  [yichuMaxVal, yichuMaxSeq] = max(yichu);
%  [yichuMinVal, yichuMinSeq] = min(yichu);
% 
%  yiEx = 1-abs((yimuMaxSeq-yimuMinSeq)/(yichuMaxSeq-yichuMinSeq));
%  yiEy = 1-(yimuMaxVal-yimuMinVal)/(yichuMaxVal-yichuMinVal);
%  yiDy = yimuMinVal - yichuMinVal + yimuMaxVal - yichuMaxVal;
%  
%   
%  yichuTemp = yichu(620:700);
%  yimuTemp = yimu(620:700);
%  yiDis = 0;
%  for i = 1 : 17
%     [~, yichuDisMin] = min(yichuTemp);
%     [~, yimuDisMin] = min(yimuTemp);
%     yiDis = yiDis + yimuDisMin - yichuDisMin;
%     yichuTemp(yichuDisMin) = 100;
%     yimuTemp(yimuDisMin) = 100;
%  end
%  yiDx = yiDis / 17;
%  
%  yiRes = [yiF, yiDx, yiDy, yiEx, yiEy];
 
%  final = [jiaRes;yiRes];
 
 %% 画图
% plot(data(61:901,13),jiamu,'linewidth',2)
% hold on
% plot(data(61:901,13),jiachu)
% plot(data(61:901,13),yimu,'linewidth',2)
% plot(data(61:901,13),yichu)
% 
% datetick('x','HH')
% xlabel('日期/天')
% ylabel('温度/^oC')
% legend('甲锅炉房目标温度','甲锅炉房出水温度','乙锅炉房目标温度','乙锅炉房出水温度')