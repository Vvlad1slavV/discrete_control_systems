function [tout,y] = start_sim(K_oc, K_oy, time)
    K_oc = K_oc;
    K_oy = K_oy;
    sim_out = sim("model.slx", time);

    tout = sim_out.tout;
    y = sim_out.y;
    k = sim_out.K;
end

