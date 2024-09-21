% 对自动控制系统的描述采用三种模型：状态空间模型ss，传递函数模型tf，零极点增益模型zpk
% matlab建立了专用的数据结构：LTI对象，封装了LTI系统的各种模型，包含上面三种对应的子对象
%% 传递函数模型
num = [1, 2, 3, 4];
den = [1, 12, 32, 30, 0, 0, 0];
G1 = tf(num, den, 0.1);

s = tf('s');
G2 = (s^3 + 2*s^2 + 3*s + 4) / (s^3 * (s + 2) * ((s + 5)^2) + 5);

s = tf('s');
G3 = G2;
set(G3, 'ioDelay', 3);
G3.ioDelay = 3;
%% 零极点增益模型
z = [-5, -2+2i, -2-2i];
p = [-1, -2, -3, -4];
k = 6;
G4 = zpk(z, p ,k);

s = zpk('s');
G5 = 6 * ((s + 5) * (s + 2 + 2i) * (s + 2 - 2i)) / ((s + 1) * (s + 2) * (s + 3) * (s + 4));
%% 状态空间模型
% A:n*n
A = [-12, -17.2, -16.8, -11.9;
       6,   8.6,   8.4,  6;
       6,   8.7,   8.4,  6;
     -5.9, -8.6,  -8.3, -6];
% B:n*p
B = [1.5, 0.2;
       1, 0.3;
       2,   1;
       0, 0.5];
% C:q*n
C = [  2, 0.5,   0, 0.8;
     0.3, 0.3, 0.2, 1];
% D:q*p
D = zeros(2, 2);
G6 = ss(A, B, C, D);
%% 相关转换
G7 = c2d(G6, 0.1);
G8 = tf(G6);
G9 = ss(G8);
G10 = minreal(G9);
%% 系统框图
num_G = [12, 24, 12, 20];
den_G = [2, 4, 6, 2, 2];
G = tf(num_G, den_G);
num_Gc = [5, 3];
den_Gc = [1];
Gc = tf(num_Gc, den_Gc);
num_H = [1000];
den_H = [1, 1000];
H = tf(num_H, den_H);
sys1 = series(Gc, G);
sys = feedback(sys1, H, -1);
%% 阶跃响应以及指标计算
clear;
clc;
G1 = tf([10, 20], [10, 23, 26, 23, 10]);
[y, t] = step(G1, '-.', 100);
[Y, k] = max(y);
C = dcgain(G1);         % 终值
Mp = 100 * (Y - C) / C; % 超调量
ess = C - y;
ep = ess(length(ess));
i = length(t);
n = 1;
while (y(i) > 0.98*C) && (y(i) < 1.02*C)
    i = i - 1;
end
while (y(n) <= C)
    n = n + 1;
end
ts = t(i);          % 稳态时间
tr = t(n);          % 上升时间
tk = t(k);          % 峰值时间
step(G1, '-.', 100);
%% 任意输入下的响应
%非零初始初始状态响应(只适用与状态空间模型)
clear;
clc;
G2 = tf([10, 20], [10, 23, 26, 23, 10]);
t = 0 : 0.1 : 30;
u = 1 - exp(-t) .* sin(3*t + 1);
lsim(G2, u, t);
%% 不同采样时间下的响应
clear;
clc;
G=tf(1, [1, 0.2, 1], 'ioDelay', 1);
G1=c2d(G, 0.01, 'zoh');
G2=c2d(G, 0.1);
G3=c2d(G, 0.5);
G4=c2d(G, 1.2);
step(G1,'r-', G2,'y--',G3,'g:', G4,'b-.', 10);
%% MIMO系统响应
clear;
clc;
g11 = tf(0.1134, [1.78, 4.48, 1], 'ioDelay', 0.72);
g12 = tf(0.924, [2.07, 1]);
g21 = tf(0.3378, [0.361, 1.09, 1], 'ioDelay', 0.3);
g22 = tf(-0.318, [2.93, 1], 'ioDelay', 1.29);
G=[g11, g12; g21, g22];
step(G);
%% 稳定性分析
clear;
clc;
G2 = tf([4, 2], [1, 2, 1]);
key = isstable(G2);
poles = pole(G2);
pzmap(G2);
rlocus(G2);
[k ,poles] = rlocfind(G2);
%% 可控性和可观性分析
clear;
clc;
A = [0, 1;
     0, 4];
B = [0; 4];
C = [0, 1];
Tc = ctrb(A, B);
To = obsv(A, C);
Rc = rank(Tc)
Ro = rank(To)
%% 根轨迹设计
G = zpk([-6.93+6.93i, -6.93-6.93i], [0, 0, -13.86], 1);
z = 0.5;
figure(1); sgrid(z); rlocus(G);axis([-10, 5, -10, 10]);
figure(2); sgrid(z); K = 25.5; rlocus(G, K)