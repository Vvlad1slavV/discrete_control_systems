function [tout, y, dy] = start_sim(K_1_new, K_2_new, time)
    assignin('base', 'K_1', K_1_new);
    assignin('base', 'K_2', K_2_new);
    sim_out = sim("model.slx", time);

    tout = sim_out.tout;
    y = sim_out.y;
    dy = sim_out.dy;
end

