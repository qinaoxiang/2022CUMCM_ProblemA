%问题三
clc
clear
m1 = 4866; 
r1 = 1;
f = 3640; 
L=1690;
g = 9.8;
m2 = 2433;
h1 = 3;
h2 = 0.8;
Cw = 683.4558; %垂荡兴波阻尼系数
Cp=654.3383;  %纵摇行波阻尼系数
R1=8890.7;  %静水恢复力矩
ma = 1028.876;  
Ia=7001.914;
I=12601.37;   %装置转动惯量
ro = 1025;
R2 = 10000;   %阻尼器阻尼系数
R3=1000;       %旋转阻尼阻尼系数
l0 = 0.5;   
k1 = 80000;
k2=250000;
DD = 0;     %D:振子沿杆位移
ZZ = 0;     %Z:底部距离水面
DDD = 0;
ZZZ = 0;
w=1.7152;
a=0;
aa=0;
aaa=0;
b=0;
bb=0;
bbb=0;
Z =-((m1+m2)/ro-(1/3)*pi*r1^2*h2)/(pi*r1^2);    %初始位置
D =(l0-m2*g/k1); %D为Dt
%设立xD，xDD，xZ，xZZ四个n行1列的矩阵来存放D、DD、Z、ZZ的数值
xD=[];
xDD=[];
xZ=[];
xZZ=[];
%设立xa，xaa，xb，xbb四个n行1列的矩阵来存放a、aa、b、bb的数值
xa = [];
xaa = [];
xb = [];
xbb = [];
dt=0.01;
T=2*pi/w;
tt = 40*T;
for t=0:0.01:tt
    MG=-R1*b;      %静水恢复力矩
    MZ=-Cp*bb;     %兴波阻尼力矩
    MJ=L*cos(w*t); %纵摇激励力矩
    MM=k2*(b-a);   %弹簧弹力
    MMM=R2*(bb-aa);%扭转弹簧扭矩
    bbb=(MJ+MZ+MG-MM-MMM)/(I+Ia);  
    ZZZ = ((1/3*pi*r1^2*h2 -Z*cos(b)*pi*r1^2+pi*r1^3*tan(b))*ro*g-m1*g+f*cos(w*t)-ZZ*Cw-k1*(l0-D)*cos(a)+R2*DD*cos(a))/(m1 + ma);
    aaa=(m2*g*sin(a)*D+m2*ZZZ*sin(a)*D+MM+MMM)/(m2*(D)^2);
    DDD=(k1*(l0-D)-R2*DD-m2*g*cos(a)-m2*ZZZ*cos(a)+m2*D*aa^2)/m2;
    ZZ=ZZ+ZZZ*dt;
    DD=DD+DDD*dt;
    Z=Z+ZZ*dt;
    D=D+DD*dt;
    bb=bb+bbb*dt;
    aa=aa+aaa*dt;
    a=a+aa*dt;
    b=b+bb*dt;
    D=D*cos(a);
    DD=DD*cos(a);
    if t==10||t==20||t==40||t==60||t==100
        xa=[xa,a];
        xaa=[xaa,aa];
        xb=[xb,b];
        xbb=[xbb,bb];
        xD=[xD,D];
        xDD=[xDD,DD];
        xZ=[xZ,Z];
        xZZ=[xZZ,ZZ];
    end
end
%垂荡的位移和速度Dcos(a) DDcos(a) Z ZZ
%纵摇的角位移和角速度 a aa b bb
%矩阵转置
xa=xa';
xaa=xaa';
xb=xb';
xbb=xbb';
xD=xD';
xDD=xDD';
xZ=xZ';
xZZ=xZZ';
xlswrite('F:\MATLABtest3\result3.xlsx',xa,'sheet1')
xlswrite('F:\MATLABtest3\result3.xlsx',xaa,'sheet2')
xlswrite('F:\MATLABtest3\result3.xlsx',xb,'sheet3')
xlswrite('F:\MATLABtest3\result3.xlsx',xbb,'sheet4')
xlswrite('F:\MATLABtest3\result3.xlsx',xD,'sheet5')
xlswrite('F:\MATLABtest3\result3.xlsx',xDD,'sheet6')
xlswrite('F:\MATLABtest3\result3.xlsx',xZ,'sheet7')
xlswrite('F:\MATLABtest3\result3.xlsx',xZZ,'sheet8')
