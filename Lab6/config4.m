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
W = k_1*k_2/(T_1^2*s^2 + 2*T_1*xi*s + a_1*a_2);
W = W*25/25;

%% 
[A,B,C,D] = tf2ss(cell2mat(W.Numerator), cell2mat(W.Denominator));

% Create state space model
sys = ss(A,B,C,D);
% Convert to discrete, where dt is your discrete time-step (in seconds)
sys_d = c2d(sys,T);
A_d = sys_d.A;
B_d = sys_d.B;

A_k = [0 1;
       -0.766 1.669];
B_k = [0;
       1];

%%
U_d = ctrb(sys_d);
U_k = ctrb(A_k, B_k);

M = U_d*inv(U_k);

det(U_d) ~= 0;
det(U_k) ~= 0;
abs(eig(sys_d.A)) < 1;
syms z
koef = double(coeffs(det(z*eye(2)-A_d)));

K = -koef(1:2);
K_d = K*inv(M);

F_d = A_d - B_d*K_d;

x_0 = [1; 0];
hatx_0 = [0; 0];

