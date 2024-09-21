%% 不定积分和定积分
syms x
y1 = 1 / (1 + x^4);
y2 = (x * exp(x)) / (1 + x)^2;
y3 = exp(1j * pi * x / 2);
fy1 = int(y1) %不定积分
fy2 = int(y2, 0, 1) %定积分
fy3 = int(y3, 0, 6)
%% 卷积积分
t=-1:0.01:5;
f1=((t>0)-(t>3));
f2=exp(-t).*(t>0);
f3=conv(f1,f2);

k=2*length(t)-1;
k3=linspace(2*t(1),2*t(end),k);

subplot(2,2,1)
plot(t,f1);
subplot(2,2,2)
plot(t,f2)
subplot(2,2,3)
plot(k3,f3);
%% 卷积和
nx = -3:3;
x = [3,11,7,0,-1,4,2];
nh = -1:4;
h = [2,3,0,-5,2,1];
nyb = nx(1) + nh(1);
nye = nx(length(x)) + nh(length(h));
ny = nyb:nye;
y = conv(x,h);

subplot(3,1,1);
stem(nx,x);
subplot(3,1,2);
stem(nh,h);
subplot(3,1,3);
stem(ny, y);
