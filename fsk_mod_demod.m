%% FSK���ƽ��
%% ��ʼ��
clc;
clear;
close all;

%% ��������
fd =  2000;     %�����ź�����2k
f1 =  8000;     %�ز�Ƶ��f1-8k
f2 =  24000;    %�ز�Ƶ��f2-16k
fc =  16000;    %�ز�16k
fs =  fc*32;    %������

%% ����ԭʼ�ź�
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

%% �����ز�
coswct = cos(t*fc*2*pi);

%% ����
askd = coswct'.*jdnr;

subplot(6,1,2)
plot(t,askd)
xlim([0,max(t)])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FSK���
% ȫ������
whole_wave = zeros(length(askd),1);
for i=1:length(askd)
    whole_wave(i) = abs(askd(i));
end
subplot(6,1,3)
plot(t,whole_wave)
ylim([-1,1])
xlim([0,max(t)])

%% �����˲�
fird = filter(ans,whole_wave);
subplot(6,1,5)

fild = fird(128:1024+128-1);

plot((1:1:1024),fild);
xlim([1,1024])

%% �о�
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