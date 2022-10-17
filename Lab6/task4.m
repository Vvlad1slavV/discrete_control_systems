config4;
path = "out/";
%%

Gamma_z = [0 1;
           0 0];
H_z = [1 1];

cvx_begin sdp
variable M_z(2,2)
M_z*Gamma_z - A_d'*M_z == -C'*H_z;
cvx_end
L = (H_z/M_z)';

%%

time = 2;

sim_out = sim("model4.slx", time);
t_sim = sim_out.tout;

x = sim_out.logsout.get("x").Values.Data;
y = (C*x')';
hatx = sim_out.logsout.get("hat_x").Values.Data;
tildex = sim_out.logsout.get("tilde_x").Values.Data;
u = sim_out.logsout.get("u").Values.Data;
epsilon = squeeze(sim_out.logsout.get("epsilon").Values.Data);

%%
task_number = 4;
set_number = 1;
plot_xy_continuous_lable(t_sim, tildex, "$Time, s$", "$\tilde{x}(t)$", true);
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, y,"$Time, s$", "$y(t)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:time, epsilon,"$Time, s$", "$\epsilon (kT + \theta)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_continuous_lable(t_sim, x,"$Time, s$", "$x(t)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(0:T:time, hatx,"$Time, s$", "$\hat{x}(kT)$", true)
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;

%% Save model as pdf
print('-smodel4', '-dpdf', 'out/model4')