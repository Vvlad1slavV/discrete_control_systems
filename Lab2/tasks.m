%% Init configs
% model params
config;


K_1 = 1;
K_2 = 1;

zz = [[0.6 0.1];
      [0.3 -1];
      [0.3 -0.1];
      [0.6i -0.6i];
      [-0.1+0.7i -0.1-0.7i];
      [0.7+0.1i 0.7-0.1i]];

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
%% find K
syms k1 k2 z
F_dsym = A_d - B_d*[k1 k2];
D_zsym = collect(det(eye(2)*z - F_dsym));
DD = sym(zeros(size(zz,1),1));
KK = zeros(size(zz));
index = 1;
for Z = zz'
    DD(index) = collect((z - Z(1))*(z - Z(2)));
    eq = coeffs(DD(index), 'All') == coeffs(D_zsym, z, 'All');
    [K1, K2] = solve(eq);
    KK(index, :) = [K1, K2];
    index = index + 1;
end


%% Sim and save img
% save img params
task_number = 1;
set_number = 1;
path = "out/";

for k = KK'
    [time, y, dy] = start_sim(k(1), k(2), 4);
    plot_xy_continuous_lable(time, y, "$Time, s$", "$y(t)$", false)
    saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'y'+'_k1_'+string(k(1))+'k2_'+string(k(2))+'.png')
    plot_xy_continuous_lable(time, dy, "$Time, s$", "$\dot{y}(t)$", false)
    saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'dy'+'_k1_'+string(k(1))+'k2_'+string(k(2))+'.png')
    set_number = set_number + 1;
    close all;
end
%%
task_number = 2;
set_number = 1;
y_0 = [-3 -2 -1 1 2 3];
dy_0 = [0 0 0 0 0 0];
for k = KK'
    [time, y, dy] = start_sim(k(1), k(2), 4);
    plot_xy_continuous_lable(y, dy, "$y(t)$", "$\dot{y}(t)$", true)
    saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'_k1_'+string(k(1))+'k2_'+string(k(2))+'.png')
    set_number = set_number + 1;
    close all;
end


%% Save model as pdf
print('-smodel', '-dpdf', 'out/model')