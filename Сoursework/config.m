%% Variant 1
% P regulator
T = 0.005;
t_per = 0.15;
t_per_ideal = 6;
sigma = 0.1;

K_1 = 70; 
Tau_1 = 0.1;
K_2 = 60;
Tau_2 = 0.1;
K_3 = 0.02;
Tau_3 = 0;

s = tf('s');
W_1 = K_1/(Tau_1*s + 1);
W_2 = K_2/(Tau_2*s + 1);
W_3 = K_3/s;

W_n = W_1*W_2*W_3;
% [A, B, C, D] = tf2ss(cell2mat(W_n.Numerator), cell2mat(W_n.Denominator))
A_n = [0   K_3    0;
     0 -1/Tau_2 K_2/Tau_2;
     0     0    -1/Tau_1];
B_n = [0; 0; K_1/Tau_1];
C_n = [1 0 0];
D_n = 0;
sys_n = ss(A_n,B_n,C_n,D_n);
sys = c2d(sys_n, T);
A = sys.A; B = sys.B; C = sys.C; D = sys.D;
[b, a] = ss2tf(A, B, C, D);
z = tf('z', T);
W = tf(b, a, T);


