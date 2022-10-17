config;
path = "out/";

%% 
[A,B,C,D] = tf2ss(cell2mat(W.Numerator), cell2mat(W.Denominator));

% Create state space model
sys = ss(A,B,C,D);
% Convert to discrete, where dt is your discrete time-step (in seconds)
sys_d = c2d(sys,T);
A_d = sys_d.A;
B_d = sys_d.B;

A_k = [0 1;
       -0.766 1.669];
B_k = [0;
       1];



%%
x_0 = [0; 1];
time = 0:0.01:10;
u = min(0, time);
lsim(sys, u, time, x_0)
hold on
time = 0:T:10;
u = min(0, time);
lsim(sys_d, u, time, x_0)

%%
task_number = 1;
set_number = 1;

[y,t] = step(sys, 10);
[y_d,t_d] = step(sys_d, 10);
plot_xy_con_and_dis_lable(t, y, t_d, y_d, "$Time, s$", "$y(t)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;
%%
U_d = ctrb(sys_d);
U_k = ctrb(A_k, B_k);

M = U_d*inv(U_k);

det(U_d) ~= 0;
det(U_k) ~= 0;
abs(eig(sys_d.A)) < 1;
syms z
koef = double(coeffs(det(z*eye(2)-A_d)));

K = -koef(1:2);
K_d = K*inv(M);

F_d = A_d - B_d*K_d;
%%
system = sys_d;
system.A = F_d;
system.B = [0;0];
x_0 = [1; 0];
time = 0:T:2;
u = min(0, time);
[y, tOut, x] = lsim(system, u, time, x_0);

task_number = 2;
set_number = 1;
plot_xy_discrete_lable(tOut, y,"$Time, s$", "$y(kT)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(tOut, K_d*x',"$Time, s$", "$\epsilon (kT + \theta)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(tOut, x,"$Time, s$", "$x(kT)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;

%%
x_0 = [1; 0];
time = 2;
sim_out = sim("model.slx", time);
t_sim = sim_out.tout;
x = sim_out.logsout.get("x").Values.Data;
epsilon = sim_out.logsout.get("epsilon").Values.Data;
y = C*x';

%%
task_number = 3;
set_number = 1;
plot_xy_continuous_lable(t_sim, y,"$Time, s$", "$y(t)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:2, epsilon,"$Time, s$", "$\epsilon (kT + \theta)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, x,"$Time, s$", "$x(t)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;
