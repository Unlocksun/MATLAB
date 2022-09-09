%% FSK调制解调
%% 初始化
clc;
clear;
close all;

%% 参数配置
fd =  2000;     %数字信号速率2k
f1 =  8000;     %载波频率f1-8k
f2 =  24000;    %载波频率f2-16k
fc =  16000;    %载波16k
fs =  fc*32;    %采样率

%% 产生原始信号
Nb = 8;
rd = rand(Nb,1);
jd = zeros(1,8);
t = 0:1/fs:1/fs*(fs/fd*Nb - 1);
for i = 1:length(rd)
    if(rd(i) > 0.5)
        jd(i) = 1;
    else
        jd(i) = 0; 
    end
end

jdn = repmat(jd,fs/fd,1);
jdnr = reshape(jdn,fs/fd*Nb,1);
subplot(6,1,1)
plot(t,jdnr)
ylim([0,1])
xlim([0,max(t)])

%% 产生载波
coswct = cos(t*fc*2*pi);

%% 调制
askd = coswct'.*jdnr;

subplot(6,1,2)
plot(t,askd)
xlim([0,max(t)])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FSK解调
% 全波整形
whole_wave = zeros(length(askd),1);
for i=1:length(askd)
    whole_wave(i) = abs(askd(i));
end
subplot(6,1,3)
plot(t,whole_wave)
ylim([-1,1])
xlim([0,max(t)])

%% 数字滤波
fird = filter(ans,whole_wave);
subplot(6,1,5)

fild = fird(128:1024+128-1);

plot((1:1:1024),fild);
xlim([1,1024])

%% 判决
demod = [];
Lel = 0.2;
for i = 1:Nb
   if(fild((i-1)*fs/fd+ fs/fd/2)>= Lel) 
       demod(i) = 1;
   else
       demod(i) = 0;
   end
end

subplot(6,1,6)
plot(demod);