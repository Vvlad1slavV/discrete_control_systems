function [tout,y] = start_sim(K_oc_new, time)
    assignin('base', 'K_oc', K_oc_new)
    sim_out = sim("model.slx", time);

    tout = sim_out.tout;
    y = sim_out.y;
end

