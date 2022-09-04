%% Init configs
% model params
config;
K_oc = 1.2;

K_oc_arr = [1.0204, 0.515, 0.3, -0.2, 1.0204, 0.8, 1.2, 0.535];
% Tau = 

% save img params
task_number = 1;
set_number = 1;
path = "out/";

%% Sim and save img
for k = K_oc_arr
    [time, y] = start_sim(k, 2);
    plot_xy_discrete_lable(time, y,"$Time, s$","$Signal?$")
    saveas(gcf, path+'task'+string(task_number)+'_'+string(set_number)+'_'+'koc'+string(k)+'.png')
    set_number = set_number + 1;
    close all;
end

%% Save model as pdf
print('-smodel', '-dpdf', 'out/model')


%%
[time, y] = start_sim(0.535, 2);
stairs(time, y)
100*(max(y) - y(50))