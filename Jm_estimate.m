clc;close all; clear;
MeasuredData = load('data\\LuGre_01.txt');
nAxis = 1;
Axis = 1;

Pos     = MeasuredData(:, 1 + Axis*0 : Axis + Axis*0);
Vel     = MeasuredData(:, 1 + Axis*1 : Axis + Axis*1);
PosCmd  = MeasuredData(:, 1 + Axis*2 : Axis + Axis*2);
VelCmd  = MeasuredData(:, 1 + Axis*3 : Axis + Axis*3);
TorCtrl = MeasuredData(:, 1 + Axis*4 : Axis + Axis*4);
Vel = lowp(Vel(:,1),1,100,0.1,20,1000);
TorCtrl = lowp(TorCtrl(:,1),1,100,0.1,20,1000);
dVel = ([Vel; 0] - [0; Vel])/0.001;
sgnVel = sign(Vel);

% 避開死區(速度跨越0處，受靜摩擦力影響)
Vel_a = Vel(find(Vel > 10 | Vel < -10));
dVel_a = dVel(find(Vel > 10 | Vel < -10)-1);
sgnVel_a = sgnVel(find(Vel > 10 | Vel < -10));
TorCtrl_a = TorCtrl(find(Vel > 10 | Vel < -10));

J_Fc_sigma2 = pinv(cat(2, dVel_a, sgnVel_a, Vel_a))*TorCtrl_a;
