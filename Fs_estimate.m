clc;close all; clear;
MeasuredData = load('data\\LuGre_Fs_11.txt');
nAxis = 1;
Axis = 1;

Pos     = MeasuredData(:, 1 + Axis*0 : Axis + Axis*0);
Vel     = MeasuredData(:, 1 + Axis*2 : Axis + Axis*2);
PosCmd  = MeasuredData(:, 1 + Axis*1 : Axis + Axis*1);
VelCmd  = MeasuredData(:, 1 + Axis*3 : Axis + Axis*3);
TorCtrl = MeasuredData(:, 1 + Axis*7 : Axis + Axis*7);
Vel = lowp(Vel(:,1),1,100,0.1,20,1000);
TorCtrl = lowp(TorCtrl(:,1),1,100,0.1,20,1000);

for i = 1:1:length(Vel)
    if(Vel(i) > )
        Fs = TorCtrl(i);
        break;
    end
end



