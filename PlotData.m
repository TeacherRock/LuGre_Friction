clc;close all; clear;
%% Ū����encoder��X��txt�ɮסG�ثe��m�B�ثe�t�סB�W����m�B�W���t�סB��x
MeasuredData = load( 'data//LuGre_J_10.txt' ) ;  
%�ĴX�b���F(��Axis�����F)
Axis = 1;

Pos =     MeasuredData( : , 1 + Axis * 0 : Axis  + Axis * 0 ) ;
Vel =     MeasuredData( : , 1 + Axis * 1 : Axis  + Axis * 1 ) ;
PosCmd =  MeasuredData( : , 1 + Axis * 2 : Axis  + Axis * 2 ) ;
VelCmd =  MeasuredData( : , 1 + Axis * 3 : Axis  + Axis * 3 ) ;
TorCtrl = MeasuredData( : , 1 + Axis * 4 : Axis  + Axis * 4 ) ;
%% Read Data
PosError = PosCmd - Pos ;
y = lowp(Vel(:,1),10,100,0.1,20,1000);
VelError = VelCmd - y ;
TorCtrl = lowp(TorCtrl(:,1),1,100,0.1,20,1000); %LP Filter �q��Tfb

for i = 1 : Axis

norm_PosError( 1 , i ) = norm( PosError( : , i ) ) / norm( PosCmd( : , i ) ) ;
norm_VelError( 1 , i ) = norm( VelError( : , i ) ) / norm( VelCmd( : , i ) ) ;

end
norm_PosError , norm_VelError
%% Plot �B�ʩR�O�W���y��
Sampling_time = 0.001;
tf = size( MeasuredData , 1 ) * Sampling_time ;
Time = Sampling_time : Sampling_time : tf ;
%��m�R�O�W��
subplot( 2 , 1 , 1 ) ;
plot( Time , PosCmd( : , 1 ) , '-' , Time , Pos( : , 1 ) , '--' , Time , PosError( : , i ) , ':' ,'LineWidth',2) ;
title( [ 'Pos ' , num2str(1) ] , 'FontWeight' , 'bold' , 'FontSize' , 12 ) ;
xlabel( 'Time (sec)') ; ylabel( 'Pos (rad)', 'FontSize' , 10 ) ;
legend( 'PosCmd' , 'Pos' , 'Error' ) ;
grid on ;
%�t�שR�O�W��
subplot( 2 , 1 , 2 ) ;
plot( Time , VelCmd( : , 1 ) , '-' , Time , y , '--' ,  Time , VelError( : , i ) , ':'  ,'LineWidth',2) ;
title( [ 'Vel ' , num2str(1) ] , 'FontWeight' , 'bold' , 'FontSize' , 12 ) ;
xlabel( 'Time (sec)') ; ylabel( 'Vel (rad/s)', 'FontSize' , 10 ) ;
legend( 'VelCmd' , 'Vel' , 'Error' ) ;
grid on ;
%��J��xTorque
% subplot( 3 , 1 , 3 ) ;
% plot( Time , TorCtrl( : , 1 ) , '-' , 'LineWidth' , 2 ) ;
% title( [ 'TorCtrl ' , num2str(1) ]  ) ;
% xlabel( 'Time (sec)') ; ylabel( 'Tor (Nm)', 'FontSize' , 10 ) ;
% grid on ;
%%  Tfb-V�S�ʦ��u
figure(2)
plot(y,TorCtrl);

% xlim([0 13])
 ylim([-0.08 0.06])
grid on;
%% LowPass Filter
function y=lowp(x,f1,f3,rp,rs,Fs)
%�C�q?�i
%�ϥΪ`�N��?�G�q?�Ϊ�?���I��?�v��?���S?�O����W?��?�v���@�b
%�Y�Af1,f3���ȳ��n�p�_ Fs/2
%x:�ݭn?�q?�i���ǦC
% f 1�G�q?�I��?�v
% f 3�G��?�I��?�v
%rp�G???�I?DB??�m
%rs�G�I��?�I?DB??�m
%FS�G�ǦCx����??�v
% rp=0.1;rs=30;%�q??�I?DB�ȩM��??�I?DB��
% Fs %��?�v

%   [N, Wp] = CHEB1ORD(Wp, Ws, Rp, Rs, 's') does the computation for an
%   analog filter, in which case Wp and Ws are in radians/second.
%
%   % Example 1:
%   %   For data sampled at 1000 Hz, design a lowpass filter with less than
%   %   3 dB of ripple in the passband defined from 0 to 40 Hz and at least
%   %   60 dB of ripple in the stopband defined from 150 Hz to the Nyquist
%   %   frequency (500 Hz):
%
%   Wp = 40/500; Ws = 150/500;
%   Rp = 3; Rs = 60;
%   [n,Wp] = cheb1ord(Wp,Ws,Rp,Rs)  % Gives mimimum order of filter
%   [b,a] = cheby1(n,Rp,Wp);        % Chebyshev Type I filter

wp=2*pi*f1/Fs;
ws=2*pi*f3/Fs;
% ??���񳷤�?�i���F
[n,wn]=cheb1ord(wp/pi,ws/pi,rp,rs);
[bz1,az1]=cheby1(n,rp,wp/pi);

y=filter(bz1,az1,x);%?�ǦCx?�i�Z�o�쪺�ǦCy
end