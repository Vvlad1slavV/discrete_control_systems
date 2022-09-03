%% Init configs
% model params
config;
K_oc = 1.2;

% save img params
task_number = 1;
set_number = 1;
path = "out/";

%% Sim and save img
sim_out = sim("model.slx", 2);
time = sim_out.tout;
y = sim_out.y;

plot_xy_discrete_lable(time, y,"$Time, s$","$Signal?$")
saveas(gcf,path+'task'+string(task_number)+'_'+string(set_number)+'.png')
close all;