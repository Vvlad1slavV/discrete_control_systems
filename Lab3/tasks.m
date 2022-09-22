config;
path = "out/";
%% Task 1

Gamma_g = [0 1;
          -1 2*cos(omega*T)];
H_g = [1 0];

xi_g0 = [0;
         A*sin(omega*T)];

sim_out = sim('model.slx', 50);


task_number = 1;
set_number = 1;


time = sim_out.tout;
g = sim_out.logsout.get("g").Values.Data;
plot_xy_discrete_lable(time, g, "$Time, s$", "$g(t)$");
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
set_number = set_number + 1;
plot_xy_discrete_lable(time(time<=4), g(time<=4), "$Time, s$", "$g(t)$");
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');
close all;
%% Task 2
T = 0.25;
Gamma_g = [0 1 0 0;
          -1 2 0 0;
           0 0 0 1; 
           0 0 -exp(-2*T) 2*cos(2*T)*exp(-T)];
H_g = [1 0 1 0];

xi_g0 = [0;
         1.5*T;
         0;
         3*exp(-T)*sin(2*T)];

task_number = 2;
set_number = 1;

sim_out = sim('model.slx', 10);
time = sim_out.tout;
g = sim_out.logsout.get("g").Values.Data;
plot_xy_discrete_lable(time, g, "$Time, s$", "$g(t)$");
saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'.png');

%% Save model as pdf
print('-smodel', '-dpdf', 'out/model')