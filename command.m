clc, clear, close all;

sampT=0.001;  
%% J, Fc, sigma2 只需要扭矩命令
tf = 20;
pos_cmd_J = zeros(1, tf/sampT);    
vel_cmd_J = zeros(1, tf/sampT);     
acc_cmd_J = zeros(1, tf/sampT);

i=1;
for t = 0 : sampT : tf - sampT
    if(t >= 0 && t < 2)
       acc_cmd_J(i) = 0;
    elseif(t >= 2 && t < 4)
        acc_cmd_J(i) = acc_cmd_J(i-1) + 0.05*sampT;
    elseif(t >= 4 && t < 8)
        acc_cmd_J(i) = acc_cmd_J(i-1) - 0.05*sampT;
    elseif(t >= 8 && t < 12)
        acc_cmd_J(i) = acc_cmd_J(i-1) + 0.05*sampT;
    elseif(t >= 12 && t < 16)
        acc_cmd_J(i) = acc_cmd_J(i-1) - 0.05*sampT;
    elseif(t >= 16 && t < 18)
        acc_cmd_J(i) = acc_cmd_J(i-1) + 0.05*sampT;
    elseif(t >= 18 && t <= 20)
        acc_cmd_J(i) = 0;
    end
    
    vel_cmd_J(i+1) = vel_cmd_J(i) + acc_cmd_J(i)*sampT;
    pos_cmd_J(i+1) = pos_cmd_J(i) + vel_cmd_J(i)*sampT;

    i = i + 1;
    if(i == tf/sampT)
        break;
    end
end

cmd_plot(pos_cmd_J, vel_cmd_J, acc_cmd_J, tf, sampT);
cmd_save(pos_cmd_J, vel_cmd_J, acc_cmd_J, tf, sampT, 'Command\command_forJ.txt');


%% Fs 只需要扭矩命令
tf = 6;
pos_cmd_Fs = zeros(1, tf/sampT);    
vel_cmd_Fs = zeros(1, tf/sampT);     
acc_cmd_Fs = zeros(1, tf/sampT);

i=1;
for t = 0 : sampT : tf
    if(i == 1)
       acc_cmd_Fs(i) = 0;
    else
        acc_cmd_Fs(i) = acc_cmd_Fs(i-1) + 0.025*sampT/3;
    end
    if(i == tf/sampT)
        break;
    end
    vel_cmd_Fs(i+1) = vel_cmd_Fs(i) + acc_cmd_Fs(i)*sampT;
    pos_cmd_Fs(i+1) = pos_cmd_Fs(i) + vel_cmd_Fs(i)*sampT;
    i = i + 1;
end
cmd_plot(pos_cmd_Fs, vel_cmd_Fs, acc_cmd_Fs, tf, sampT);
cmd_save(pos_cmd_Fs, vel_cmd_Fs, acc_cmd_Fs, tf, sampT, 'Command\command_forFs');

%% sigma0, sigma1 只需要扭矩命令
tf = 8;
pos_cmd_sigma0 = zeros(1, tf/sampT);    
vel_cmd_sigma0 = zeros(1, tf/sampT);     
acc_cmd_sigma0 = zeros(1, tf/sampT);

i=1;
for t = 0 : sampT : tf - sampT
    if(t >= 0 && t < 2)
       acc_cmd_sigma0(i) = 0;
    elseif(t >= 2 && t < 3)
        acc_cmd_sigma0(i) = acc_cmd_sigma0(i-1) + 0.025*sampT;
    elseif(t >= 3 && t < 5)
        acc_cmd_sigma0(i) = acc_cmd_sigma0(i-1) - 0.025*sampT;
    elseif(t >= 5 && t < 7)
        acc_cmd_sigma0(i) = acc_cmd_sigma0(i-1) + 0.025*sampT;
    elseif(t >= 7 && t < 9)
        acc_cmd_sigma0(i) = acc_cmd_sigma0(i-1) - 0.025*sampT;
    elseif(t >= 9 && t < 10)
        acc_cmd_sigma0(i) = acc_cmd_sigma0(i-1) + 0.025*sampT;
    elseif(t >= 10 && t <= 12)
        acc_cmd_sigma0(i) = 0;
    end
    
    vel_cmd_sigma0(i+1) = vel_cmd_sigma0(i) + acc_cmd_sigma0(i)*sampT;
    pos_cmd_sigma0(i+1) = pos_cmd_sigma0(i) + vel_cmd_sigma0(i)*sampT;

    i = i + 1;
    if(i == tf/sampT)
        break;
    end
end

cmd_plot(pos_cmd_sigma0, vel_cmd_sigma0, acc_cmd_sigma0, tf, sampT);
cmd_save(pos_cmd_sigma0, vel_cmd_sigma0, acc_cmd_sigma0, tf, sampT, 'Command\command_forsigma0');

%% Function
function cmd_plot(pos, vel, acc, tf, sampT)
    t = 0 : sampT : tf - sampT;
    figure()
    subplot(3,1,1)
    plot(t, acc);
    title('加速度命令規劃', 'FontSize', 12);
    legend('加速度命令規劃');
    xlabel('time (s)'); ylabel('acceleration (rad/s^2)');
    
    subplot(3,1,2)
    plot(t, vel);
    title('速度命令規劃', 'FontSize', 12);
    legend('速度命令規劃');
    xlabel('time (s)'); ylabel('velocity (rad/s)'); 
    
    subplot(3,1,3)
    plot(t, pos);
    title('位置命令規劃', 'FontSize', 12);
    legend('位置命令規劃');
    xlabel('time (s)'); ylabel('position (rad)'); 
    
    subplot(3,1,3)
    plot(t, pos);
    title('位置命令規劃','FontSize',12);
    legend('位置命令規劃');
    xlabel('time');
    ylabel('position'); 
end

function cmd_save(pos, vel, acc, tf, sampT, name)
    fid = fopen(name, 'wt');
    i=1;
    for t = 0 : sampT : tf - sampT
        fprintf(fid,'%f\t', pos(i));
        fprintf(fid,'%f\t', vel(i));
        fprintf(fid,'%f\n', acc(i));
        i = i + 1;
        if(i == 10/sampT)
            break;
        end
    end
    fclose(fid);
end





    