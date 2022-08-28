clc, clear, close all;

sampT=0.001;  
%% J,Fc,sigma2
% tf = 20;
% position_cmd = zeros(1,tf/sampT);    
% velocity_cmd = zeros(1,tf/sampT);     
% acceleration_cmd = zeros(1,tf/sampT);
% 
% i=1;
% for t=0:sampT:tf-sampT
%     if(t>=0 && t<2)
%        acceleration_cmd(i) = 0;
%     elseif(t>=2 && t<4)
%         acceleration_cmd(i) = acceleration_cmd(i-1) + 0.05*sampT;
%     elseif(t>=4 && t<8)
%         acceleration_cmd(i) = acceleration_cmd(i-1) - 0.05*sampT;
%     elseif(t>=8 && t<12)
%         acceleration_cmd(i) = acceleration_cmd(i-1) + 0.05*sampT;
%     elseif(t>=12 && t<16)
%         acceleration_cmd(i) = acceleration_cmd(i-1) - 0.05*sampT;
%     elseif(t>=16 && t<18)
%         acceleration_cmd(i) = acceleration_cmd(i-1) + 0.05*sampT;
%     elseif(t>=18 && t<=20)
%         acceleration_cmd(i) = 0;
%     end
%     
%     velocity_cmd(i+1) = velocity_cmd(i) + acceleration_cmd(i)*sampT;
%     position_cmd(i+1) = position_cmd(i) + velocity_cmd(i)*sampT + 0.5*acceleration_cmd(i)*sampT*sampT;
% 
%     i = i+1;
%     if(i==tf/sampT)
%         break;
%     end
% end

% fid = fopen('command_forJ.txt','wt');
% i=1;
% for t = 0:sampT:tf-sampT
%     fprintf(fid,'%f\t',position_cmd(i));
%     fprintf(fid,'%f\t',velocity_cmd(i));
%     fprintf(fid,'%f\n',acceleration_cmd(i));
%     i = i+1;
%     if(i==tf/sampT)
%         break;
%     end
% end
% fclose(fid);
%% Fs
% tf = 6;
% position_cmd = zeros(1,tf/sampT);    
% velocity_cmd = zeros(1,tf/sampT);     
% acceleration_cmd = zeros(1,tf/sampT);
% 
% i=1;
% for t=0:sampT:tf
%     if(i==1)
%        acceleration_cmd(i) = 0;
%     else
%         acceleration_cmd(i) = acceleration_cmd(i-1) + 0.025*sampT/3;
%     end
%     if(i==tf/sampT)
%         break;
%     end
%     velocity_cmd(i+1) = velocity_cmd(i) + acceleration_cmd(i)*sampT;
%     position_cmd(i+1) = position_cmd(i) + velocity_cmd(i)*sampT + 0.5*acceleration_cmd(i)*sampT*sampT;
%     i = i + 1;
% end
% 
% fid = fopen('command_forFs.txt','wt');
% i=1;
% for t = 0:sampT:tf-sampT
%     fprintf(fid,'%f\t',position_cmd(i));
%     fprintf(fid,'%f\t',velocity_cmd(i));
%     fprintf(fid,'%f\n',acceleration_cmd(i));
%     i = i+1;
%     if(i==tf/sampT)
%         break;
%     end
% end
% fclose(fid);

%% sigma0, sigma1
tf = 8;
position_cmd = zeros(1,tf/sampT);    
velocity_cmd = zeros(1,tf/sampT);     
acceleration_cmd = zeros(1,tf/sampT);

i=1;
for t=0:sampT:tf-sampT
    if(t>=0 && t<2)
       acceleration_cmd(i) = 0;
    elseif(t>=2 && t<3)
        acceleration_cmd(i) = acceleration_cmd(i-1) + 0.025*sampT;
    elseif(t>=3 && t<5)
        acceleration_cmd(i) = acceleration_cmd(i-1) - 0.025*sampT;
    elseif(t>=5 && t<7)
        acceleration_cmd(i) = acceleration_cmd(i-1) + 0.025*sampT;
    elseif(t>=7 && t<9)
        acceleration_cmd(i) = acceleration_cmd(i-1) - 0.025*sampT;
    elseif(t>=9 && t<10)
        acceleration_cmd(i) = acceleration_cmd(i-1) + 0.025*sampT;
    elseif(t>=10 && t<=12)
        acceleration_cmd(i) = 0;
    end
    
    velocity_cmd(i+1) = velocity_cmd(i) + acceleration_cmd(i)*sampT;
    position_cmd(i+1) = position_cmd(i) + velocity_cmd(i)*sampT + 0.5*acceleration_cmd(i)*sampT*sampT;

    i = i+1;
    if(i==tf/sampT)
        break;
    end
end
% fid = fopen('command_forFs.txt','wt');
% i=1;
% for t = 0:sampT:tf-sampT
%     fprintf(fid,'%f\t',position_cmd(i));
%     fprintf(fid,'%f\t',velocity_cmd(i));
%     fprintf(fid,'%f\n',acceleration_cmd(i));
%     i = i+1;
%     if(i==tf/sampT)
%         break;
%     end
% end
% fclose(fid);
%% 畫圖
time = 0:sampT:tf-sampT;

figure(1)
subplot(3,1,1)
plot(time,acceleration_cmd);
title('加速度命令規劃','FontSize',12);
xlabel('time');
ylabel('acceleration');

subplot(3,1,2)
plot(time,velocity_cmd);
title('速度命令規劃','FontSize',12);
legend('速度命令規劃');
xlabel('time');
ylabel('velocity'); 

subplot(3,1,3)
plot(time,position_cmd);
title('位置命令規劃','FontSize',12);
legend('位置命令規劃');
xlabel('time');
ylabel('position'); 





    