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
