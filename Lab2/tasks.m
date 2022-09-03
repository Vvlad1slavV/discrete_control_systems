config;

K_1 = -1;
K_2 = -1;

sim_out = sim("model.slx", 15);
time = sim_out.tout;
y = sim_out.y;
dy = sim_out.y;

stairs(time, y)
