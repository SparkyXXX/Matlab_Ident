%% 清空环境变量及命令
%clear all;  % 清除工作区中的变量
%clc;        % 清除命令行窗口中的命令
%% 矩阵
clear;
clc;
A = [1, 2, 3; 4, 5, 2; 3, 2, 7];
B = A';
C = A(:);
D = inv(A);
A * D;

E = zeros(10, 5, 3);
E(:, :, 1) = rand(10, 5);
E(:, :, 2) = randn(10, 5);
E(:, :, 3) = randi(10, 10, 5);

F = 1:2:9;
G = repmat(F, 2, 3);

H = A * B;
I = A .* B;
J = A / B; % A * inv(B)
J2 = A \ B;
K = A ./ B;

L = A(2, :);
[m , ~] = find(A > 4);

M = inv(A);
N = pinv(A);
%% 元胞数组，结构体
clear;
clc;
A = cell(1, 6);
A{2} = eye(3);
A{5} = magic(5);
B = A{5};

books = struct('name', {{'Machine Learning', 'Data Mining'}}, 'price', [30, 40]);
books.name
%books.name(1)
%books.name{1};
%% 控制结构
clear;
clc;
sum = 0;
for n = 1 : 2 :5
    sum = sum + n^2;
end

while sum > 0
    sum = sum - 10;
end

if sum > 0
    '大于0';
else
    '小于或等于0';
end

switch sum
    case -1
        '-1';
    case -3
        '-3';
    otherwise
        '-2';
end
%% 二维绘图
clear;
clc;
x = 0 : 0.01 : 50;
y1 = 200 * exp(-0.05*x) .* sin(x);
y2 = 0.8 * exp(-0.5*x) .* sin(10*x);
figure;
[AX, H1, H2] = plotyy(x, y1, x, y2, 'plot');
set(get(AX(1), 'Ylabel'), 'String', 'Slow Decay');
set(get(AX(2), 'Ylabel'), 'String', 'Fast Decay');
xlabel('Time(\musec)');
title('Multiple Decay Rates');
set(H1, 'LineStyle', '--');
set(H2, 'LineStyle', ':');
%% 三维绘图
t = 0 : pi/50 : 10*pi;
plot3(sin(t), cos(t), sin(t) .* cos(t));
xlabel('sin(t)');
ylabel('cos(t)');
zlabel('sin(t) .* cos(t)');
grid on;
axis square;
%% 多项式函数
s1 = [1, 2, 1];
p2 = [2, 3, 3];
p3 = conv(s1, p2);
s1 = poly2sym(s1);
p5 = polyder(s1);
num = [1];
den = [1, 0, 1];
[q, d] = polyder(num, den);
p6 = polyint(s1, 2);
s2 = poly2sym(p6);
p7 = [1, 0, 2, -1];
P = [-1, 0; 5, 2];
Q = polyvalm(p7, P);
r = roots(s1);
p = poly(r);
%% 解线性方程组
A = [1, 2; 2, 3; 3, 4];
B = [1; 2; 3];
X = pinv(A) * B;
C = [1, 2, 3; 2, 3, 4];
D = [1; 2];
Y = pinv(C) * D;
%% 符号运算
syms y t;
y = [cos(t), -sin(t); sin(t), cos(t)];
transpose(y);
inv(y);
det(y);
syms x;
s1 = x^3 + 2*x;
p2 = sym2poly(s1);
s3 = factor(s1);
%% 微积分
syms x h a b;
f = (sin(x+h) - sin(x)) / h;
limit(f, h, 0);
f1 = diff(f, x, 2);
f2 = int(f, x, a, b);
%% 函数
clc
clear
[b, c] = func(1, 2);
x = input('input x please');
disp('10 times x is ');
disp(10*x);
rt