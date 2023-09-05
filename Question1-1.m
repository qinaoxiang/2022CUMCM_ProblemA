%问题一第一问
%生成dt=0.2s时浮子、振子的速度时间关系图
%将数据导出到excel表格中
clc
clear
m1 = 4866; 
r1 = 1;
f = 6250; 
g = 9.8;
m2 = 2433;
h1 = 3;
h2 = 0.8;
Cw = 656.3616; 
ma = 1335.535;
ro = 1025;
R1 = 10000;
l0 = 0.5;
k1 = 80000;
DD = 0;
ZZ = 0;
DDD = 0;
ZZZ = 0;
w=1.4005;
dt = 0.01; %dt为变量，万分之一
t=0;
Z = -((m1+m2)/ro-(1/3)*pi*r1^2*h2)/(pi*r1^2);
D = (l0-m2*g/k1)+Z; %D为Dt
T=2*pi/w;
tt=40*T;
%设置x1，x2，x3，x4四个n行1列来存放每次迭代后的数值
x1=[];%x1存放D
x2=[];%x2存放Z
x3=[];%x3存放DD
x4=[];%x4存放ZZ
for t=0:0.01:tt %迭代
    if (mod(t,0.2)==0)
        x1=[x1,D];
        x2=[x2,Z];
        x3=[x3,DD];
        x4=[x4,ZZ];
    end
    DDD =( k1*(l0-(D-Z)) -R1*(DD-ZZ)- m2*g)/m2;
    ZZZ = ((1/3*pi*r1^2*h2 + pi*r1^2*(-Z))*ro*g-m1*g+f*cos(w*(t+dt))-ZZ*Cw - k1*(l0-(D-Z))+R1*((DD-ZZ)*(abs(DD-ZZ))^0.5))/(m1 + ma);
    ZZ = ZZ + ZZZ*dt;
    DD = DD + DDD*dt;
    Z = Z + ZZ*dt;
    D = D + DD*dt;
end
%对矩阵进行转置，变成列向量
x1=x1';
x2=x2';
x3=x3';
x4=x4';
%将数据导出到excel表格中
xlswrite  ('F:\2022MATLAB\result1-1.xlsx',x1,'sheet1')
xlswrite  ('F:\2022MATLAB\result1-1.xlsx',x2,'sheet2')
xlswrite  ('F:\2022MATLAB\result1-1.xlsx',x3,'sheet3')
xlswrite  ('F:\2022MATLAB\result1-1.xlsx',x4,'sheet4')
%以0.01s为步长，画浮子、振子的位移、速度时间关系图
t=0:0.2:tt;
subplot(2,2,[1,2])
plot(t,x2,'b')
hold on
plot(t,x1,'r')
hold on
subplot(2,2,[3,4])
plot(t,x3,'b')
hold on
plot(t,x4,'r')
hold on