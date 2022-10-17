config;
control;
path = "out/";

%%
task_number = 1;
set_number = 1;
time = 15;

[g,tg,xi] = lsim(action_generator, 0:T:time, 0:T:15, xi_g0);
plot_xy_discrete_lable(tg, g,"$Time, s$", "$g(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;

set_number = set_number + 1;
time = 15;
xi_f0 = 0;
sim_out = sim("model1.slx", time);
t_sim = sim_out.tout;
x = sim_out.logsout.get("x").Values.Data;
y = C*x';
e = squeeze(sim_out.logsout.get("e").Values.Data);
xi_g = sim_out.logsout.get("xi_g").Values.Data;
g = xi_g(:,1);
% xi_f = sim_out.logsout.get("xi_f").Values.Data;

plot_xy_discrete_lable(t_sim, y, "$Time, s$", "$y(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(t_sim, g,"$Time, s$", "$g(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(t_sim, e',"$Time, s$", "$e(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;


%%
task_number = 2;
set_number = 1;
time = 15;
xi_f0 = f_0;

[f,tf,xi_f] = lsim(noise_generator, 0:T:time, 0:T:15, xi_f0);
plot_xy_discrete_lable(tf, f,"$Time, s$", "$f(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;

set_number = set_number + 1;
time = 15;

sim_out = sim("model1.slx", time);
t_sim = sim_out.tout;
x = sim_out.logsout.get("x").Values.Data;
y = C*x';
e = squeeze(sim_out.logsout.get("e").Values.Data);
xi_g = sim_out.logsout.get("xi_g").Values.Data;
g = xi_g(:,1);
xi_f = sim_out.logsout.get("xi_f").Values.Data;

plot_xy_discrete_lable(t_sim, y, "$Time, s$", "$y(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(t_sim, g,"$Time, s$", "$g(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(t_sim, xi_f,"$Time, s$", "$f(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(t_sim, e',"$Time, s$", "$e(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;
%%
task_number = 3;
set_number = 1;
time = 15;

time = 15;

xi_f0 = 0;
sim_out = sim("model2.slx", time);
t_sim = sim_out.tout;
x = sim_out.logsout.get("x").Values.Data;
y = C*x';
e = squeeze(sim_out.logsout.get("e").Values.Data);
xi_g = sim_out.logsout.get("xi_g").Values.Data;
g = xi_g(:,1);
% xi_f = sim_out.logsout.get("xi_f").Values.Data;

plot_xy_continuous_lable(t_sim, x, "$Time, s$", "$x(t)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, y, "$Time, s$", "$y(t)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:time, g,"$Time, s$", "$g(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, e',"$Time, s$", "$e(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;


%%
task_number = 4;
set_number = 1;
time = 15;
xi_f0 = f_0;

time = 15;

sim_out = sim("model2.slx", time);
t_sim = sim_out.tout;
x = sim_out.logsout.get("x").Values.Data;
y = C*x';
e = squeeze(sim_out.logsout.get("e").Values.Data);
xi_g = sim_out.logsout.get("xi_g").Values.Data;
g = xi_g(:,1);
xi_f = sim_out.logsout.get("xi_f").Values.Data;

plot_xy_continuous_lable(t_sim, x, "$Time, s$", "$x(t)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, y, "$Time, s$", "$y(t)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:time, g,"$Time, s$", "$g(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:time, xi_f,"$Time, s$", "$f(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, e',"$Time, s$", "$e(kT)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;
%% Save model as pdf
print('-smodel1', '-dpdf', 'out/model')
