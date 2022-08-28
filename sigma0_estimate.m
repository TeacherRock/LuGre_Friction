clc; clear; close all;

%% Read Data
MeasuredData = load('data//LuGre_sigma0_10.txt');
nAxis = 1;
Axis = 1;

Pos     = MeasuredData(:, 1 + Axis*0 : Axis + Axis*0); % b = A（:,c:d）表示把矩陣A的第c到第d列存入b中
Vel     = MeasuredData(:, 1 + Axis*1 : Axis + Axis*1);
PosCmd  = MeasuredData(:, 1 + Axis*2 : Axis + Axis*2);
VelCmd  = MeasuredData(:, 1 + Axis*3 : Axis + Axis*3);
TorCtrl = MeasuredData(:, 1 + Axis*4 : Axis + Axis*4);

f = fit(Pos(1:length(Pos)),TorCtrl(1:length(TorCtrl)),'poly1');

