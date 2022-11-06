path = "out/";
config;
%%
time = 0.2;

sim_out = sim("model1.slx", time);
t_sim = sim_out.tout;

y = sim_out.logsout.get("y").Values.Data;
y_dis = sim_out.logsout.get("y_dis").Values.Data;
plot_xy_con_and_dis_lable(t_sim, y, 0:T:time, y_dis, "$Time, s$", "$y(t)$", true);
saveas(gcf, path+'y_vs_ydis.png');
close all;

print('-smodel1', '-dpdf', 'out/model1')

%%
syms x
omega_0 = t_per_ideal/t_per;
Gamma_n = diag(flip(double(solve(x^3 + 2*omega_0*x^2 + 2*omega_0^2*x + omega_0^3==0))));
[V,Diag] = jordan(Gamma_n);
[Vnew,Gamma_n] = cdf2rdf(V,Diag)
% Gamma_n = [-40 0 0;
%              0 -20 20*sqrt(3);
%              0 20*sqrt(3) -20];

Gamma = expm(Gamma_n*T);
% [V,D] = jordan(Gamma);
% Gamma = cdf2rdf(V,D)
H = [1 1 1];
%%
M = lyap(-A, Gamma, B*H);
% cvx_begin sdp
% variable M(3,3)
% M*Gamma - A*M == -B*H;
% cvx_end
K = H/M;

%%
sim_out = sim("model2.slx", 0.3);

time = sim_out.tout;
y = sim_out.logsout.get("y").Values.Data;

plot_step(time, y, "$Time, s$","$y(t)$", true)
saveas(gcf, path+'y_step.png');
close all;

print('-smodel2', '-dpdf', 'out/model2')
%%
(max(y)-1)*100

%%
Yup = 1.05*ones(size(time'));
Ydown = 0.95*ones(size(time'));
Pup = InterX([time'; Yup],[time';y']);
Pdown = InterX([time'; Ydown],[time';y']);
P = sortrows([Pup Pdown]');
Plast = P(end,:);
plot(time,Yup,time,Ydown,time,y, Pup(1,:), Pup(2,:),'ro', Pdown(1,:), Pdown(2,:),'ro')
%%

