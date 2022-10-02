clc, clear, close all;

Axis = 1;
%% Jm estimation
disp("========================== J Fc sigma2 estimation ==========================");
J_Fc_sigma2_num = 10;
J_Fc_sigma2 = zeros(3, J_Fc_sigma2_num);
for i = 1 : J_Fc_sigma2_num
    Data_J_Fc_sigma2 = load("Data\LuGre_J_" + int2str(i) + ".txt");
    
    Vel     = Data_J_Fc_sigma2(:, 1 + Axis*1 : Axis + Axis*1);
    TorCtrl = Data_J_Fc_sigma2(:, 1 + Axis*4 : Axis + Axis*4);

    Vel = lowp(Vel(:, 1), 1, 100, 0.1, 20, 1000);
    TorCtrl = lowp(TorCtrl(:, 1), 1, 100, 0.1, 20, 1000);
    
    dVel = ([Vel; 0] - [0; Vel])/0.001;
    sgnVel = sign(Vel);
    
    % 避開死區(速度跨越0處，受靜摩擦力影響)
    Vel_a = Vel(find(Vel > 10 | Vel < -10));
    dVel_a = dVel(find(Vel > 10 | Vel < -10)-1);
    sgnVel_a = sgnVel(find(Vel > 10 | Vel < -10));
    TorCtrl_a = TorCtrl(find(Vel > 10 | Vel < -10));
    
%     J_Fc_sigma2(:, i) = pinv(cat(2, dVel_a, sgnVel_a, Vel_a))*TorCtrl_a;
    J_Fc_sigma2(:, i) = cat(2, dVel_a, sgnVel_a, Vel_a)\TorCtrl_a;
end
avgJm = mean(J_Fc_sigma2(1, :));
avgFc = mean(J_Fc_sigma2(2, :));
avgsigma2 = mean(J_Fc_sigma2(3, :));
disp("Jm = "); disp(avgJm);
disp("Fc = "); disp(avgFc);
disp("sigma2 = "); disp(avgsigma2);

%% Fs estimation
disp("========================== Fs estimation ==========================");
Fs_num = 10;
Fs = zeros(1, Fs_num);
for i = 1 : Fs_num
    Data_Fs = load("Data\LuGre_Fs_" + int2str(i) + ".txt");

    Vel     = Data_Fs(:, 1 + Axis*2 : Axis + Axis*2);
    TorCtrl = Data_Fs(:, 1 + Axis*4 : Axis + Axis*4);

    Vel = lowp(Vel(:,1),1,100,0.1,20,1000);
    TorCtrl = lowp(TorCtrl(:,1),1,100,0.1,20,1000);
    
    for j = 1 : length(Vel)
        if(Vel(j) > 0.02)
            Fs(i) = TorCtrl(j);
            break;
        end
    end
end
avgFs = mean(Fs);
disp("Fs = "); disp(avgFs);

%% Fc estimation
disp("========================== sigma0 sigma1 estimation ==========================");
sigma0_num = 10;
sigma0 = zeros(1, sigma0_num);
sigma1 = zeros(1, sigma0_num);
Zeta = 1;

for i = 1 : sigma0_num
    Data_Fc = load("Data\LuGre_sigma0_" + int2str(i) + ".txt");
    Pos     = Data_Fc(:, 1 + Axis*0 : Axis + Axis*0);
    TorCtrl = Data_Fc(:, 1 + Axis*4 : Axis + Axis*4);
    
    f = fit(Pos(1 : length(Pos)), TorCtrl(1 : length(TorCtrl)), 'poly1');
    sigma0(i) = f.p1;
    sigma1(i) = 2*Zeta*sqrt(sigma0(i)*avgJm) - avgsigma2;
end
avgsigma0 = mean(sigma0);
avgsigma1 = mean(sigma1);
disp("sigma0 = "); disp(avgsigma0);
disp("sigma1 = "); disp(avgsigma1);

