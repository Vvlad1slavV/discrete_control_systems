% Variant №7

k_1 = 9;
k_2 = 1;
a_1 = 1;
a_2 = 1;
T_1 = 0.6;
T_2 = 0;
xi = 0.4;

T = 0.2;

s = tf('s');
% syms s
W_uy = k_1*k_2/(T_1^2*s^2 + 2*T_1*xi*s + a_1*a_2);
W_fy = -k_1/(T_1^2*s^2 + 2*T_1*xi*s + a_1*a_2);

A_g = 1.4;
omega_g = 0.6;
f_0 = 5.3;

%%
[A,B,C,D] = tf2ss(cell2mat(W_uy.Numerator), cell2mat(W_uy.Denominator));
[Af,Bf,Cf,Df] = tf2ss(cell2mat(W_fy.Numerator), cell2mat(W_fy.Denominator));

Bf = -Bf;

% Create state space model
sys = ss(A,B,C,D);
% Convert to discrete, where dt is your discrete time-step (in seconds)
sys_d = c2d(sys,T);
A_d = sys_d.A;
B_d = sys_d.B;
B_fd = -B_d;
%%
Gamma_g = [0 1;
        -1 2*cos(omega_g*T)];
H_g = [1 0];
xi_g0 = [0;
         A_g*sin(omega_g*T)];

action_generator = ss(Gamma_g, [0;0], H_g, 0, T);

%%
Gamma_f = 1;
H_f = 1;
xi_f0 = f_0;

noise_generator = ss(Gamma_f, 0, H_f, 0, T);

%%
cvx_begin sdp
variable M_g(2,2)
variable L_g(1,2)
C*M_g == H_g;
M_g*Gamma_g - A_d*M_g == B_d*L_g;
cvx_end
cvx_begin sdp
variable L_f
B_d*L_f == B_fd*H_f;
cvx_end

%%
Gamma_d = [0 1;
           0 0];
H_d = [1 0];
cvx_begin sdp
variable M(2,2)
B_d*H_d == M*Gamma_d - A_d*M;
cvx_end
K_oc = -H_d/M;

%%
x_0 = [1; 0];
hatx_0 = [0; 0];
