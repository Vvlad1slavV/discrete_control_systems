%% Init configs
% model params
config;


K_1 = -1;
K_2 = -1;


%% Create a discrete model
A = [0 1;
     0 0];
B = [0;
     1];
C = [1 0];

A_d = expm(A*T);
B_d = 0;
for i= 1:10
    B_d = B_d + (A^(i-1)*T^(i))/(prod(1:i))*B;
end
%% K
syms k1 k2 z
F_dsym = A_d - [k1 k2]*B_d;
D_zsym = collect(det(eye(2)*z - F_dsym));


%% Sim and save img
% for k = K_oc_arr
%     [time, y] = start_sim(k, 2);
%     plot_xy_discrete_lable(time, y,"$Time, s$","$Signal?$")
%     saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'_'+'koc'+string(k)+'.png')
%     set_number = set_number + 1;
%     close all;
% end

[time, y, dy] = start_sim(K_1, K_2, 10);
plot(y, dy)
%% Save model as pdf
print('-smodel', '-dpdf', 'out/model')