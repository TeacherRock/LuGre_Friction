clc; clear; close all;

%% Read Data
MeasuredData = load('LuGre_J_10.txt');
nAxis = 1;
Axis = 1;

Pos     = MeasuredData(:, 1 + Axis*0 : Axis + Axis*0); % b = A（:,c:d）表示把矩陣A的第c到第d列存入b中
Vel     = MeasuredData(:, 1 + Axis*1 : Axis + Axis*1);
PosCmd  = MeasuredData(:, 1 + Axis*2 : Axis + Axis*2);
VelCmd  = MeasuredData(:, 1 + Axis*3 : Axis + Axis*3);
TorCtrl = MeasuredData(:, 1 + Axis*4 : Axis + Axis*4);

%% filter
y = lowp(Vel(:,1),1,100,0.1,20,1000);
TorCtrl = lowp(TorCtrl(:,1),1,100,0.1,20,1000); % LP Filter 量測 Tfb

%% Time Settings
samp_T = 0.001;
tf = (size(MeasuredData, 1)-1) * samp_T;
T = 0:samp_T:tf;

%% calculate
Vel = lowp(Vel(:,1),1,100,0.1,20,1000);
dV = zeros(1, length(T));
sgn = zeros(1, length(T));
ansp = zeros(3, 1);
ansn = zeros(3, 1);

for i=1:length(T)-1
    dV(i) = (Vel(i+1) - Vel(i))/samp_T;
end
filt1 = find(Vel > 10);
A1 = cat(2, dV(filt1)', sign(Vel(filt1)), Vel(filt1));
ansp = A1\TorCtrl(filt1);
X1 = 1:length(filt1);

filt2 = find(Vel < -10);
A2 = cat(2, dV(filt2)', sign(Vel(filt2)), Vel(filt2));
ansn = A2\TorCtrl(filt2);
X2 = 1:length(filt2);

ans1 = (A1\TorCtrl(filt1))';
ans2 = (A2\TorCtrl(filt2))';
% fid = fopen('LuGre_Jp.txt','a');
% fprintf(fid,'%g\n',ansp);
% fclose(fid);
% fid = fopen('LuGre_Jn.txt','a');
% fprintf(fid,'%g\n',ansn);
% fclose(fid);

%% Plot
latexArg = {'Interpreter','latex'};
legendArg = [latexArg(:)',{'FontSize'},{12}];
titleArg = [latexArg(:)', {'FontSize'},{16},{'FontWeight'},{'bold'}];

%% Fig 1
figure(1)
subplot(2,1,1)
plot(T,VelCmd,'--',T,y,'-','LineWidth',2)
title('Vel',titleArg{:})
xlabel('Time (sec)',legendArg{:})
ylabel('Vel (rad/s)',legendArg{:})
legend('VelCmd','Vel',legendArg{:})
grid on

subplot(2,1,2)
plot(T,TorCtrl,'-','LineWidth',2)
title('TorCtrl',titleArg{:})
xlabel('Time (sec)',legendArg{:})
ylabel('Tor ($N \cdot m$)',legendArg{:})
grid on