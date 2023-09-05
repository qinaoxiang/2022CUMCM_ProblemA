%问题二第一问
clc
clear
m1 = 4866; 
r1 = 1;
f = 4890; 
g = 9.8;
m2 = 2433;
h1 = 3;
h2 = 0.8;
Cw = 167.8395; 
ma = 1165.992;
ro = 1025;
l0 = 0.5;
k1 = 80000;
w=2.2143;
dt = 0.01; %dt为变量，万分之一
t=0;
T= 2*pi/w;
%设置x1n行1列来存放每次迭代后的瞬时功率P的数值
x1=[];
for R1=37500:0.01:37550 %R1为阻尼系数
    P1 = 0;
    DD = 0;
    ZZ = 0;
    DDD = 0;
    ZZZ = 0;
    Z = -((m1+m2)/ro-(1/3)*pi*r1^2*h2)/(pi*r1^2);
    D = (l0-m2*g/k1)+Z; %D为Dt
    for t=0:0.01:128.36 %双层循环，在100-128.36是10个周期
        DDD =( k1*(l0-(D-Z)) -R1*(DD-ZZ)- m2*g)/m2;
        ZZZ = ((1/3*pi*r1^2*h2 + pi*r1^2*(-Z))*ro*g-m1*g+f*cos(w*(t+dt))-ZZ*Cw - k1*(l0-(D-Z))+R1*((DD-ZZ)))/(m1 + ma);
        ZZ = ZZ + ZZZ*dt;
        DD = DD + DDD*dt;
        Z = Z + ZZ*dt;
        D = D + DD*dt;
        P = R1*((DD-ZZ)^2);%P是瞬时功率
        if t>100 %100s后装置趋于稳定
            P1 = P1 + P*dt;%P1为平均功率
        end
    end
    P1 = P1/(10*T);%求出一个周期内的平均功率
    x1 = [x1,P1];
end
%矩阵转置
x1=x1';
R1=37500:0.01:37550;
xlswrite  ('F:\MATLABtest2\test2_1.xlsx',x1,'sheet1')
xlswrite  ('F:\MATLABtest2\test2_1.xlsx',R1','sheet2')
plot(R1,x1,'r')
hold on