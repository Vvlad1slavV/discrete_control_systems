config;

K_oc = 1.2;
sim_out = sim("model.slx", 2);
time = sim_out.tout;
y = sim_out.y;

plot(time, y)
