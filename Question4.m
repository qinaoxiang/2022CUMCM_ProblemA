%问题四
clc
clear
hold on
%设置x1、x2、x3三个矩阵来存放P1、R3、R2的数值
x1=[];
x2=[];
x3=[];
for R2=59000:10:59500  %R2步长为10
    for R3=85000:1000:90000  %R3步长为1000
        P=0;
        P1=0;
        m1 = 4866; 
        r1 = 1;
        f = 1760; 
        L=2140;
        g = 9.8;
        m2 = 2433;
        h1 = 3;
        h2 = 0.8;
        Cw = 528.5018;
        Cp=1655.909;
        R1=8890.7;
        ma = 1091.099;
        Ia=7142.493;
        I=12601.37;
        ro = 1025;
        l0 = 0.5;
        k1 = 80000;
        k2=250000;
        DD = 0;
        ZZ = 0;
        DDD = 0;
        ZZZ = 0;
        w=1.9806;
        a=0;
        aa=0;
        aaa=0;
        b=0;
        bb=0;
        bbb=0;
        Z =-((m1+m2)/ro-(1/3)*pi*r1^2*h2)/(pi*r1^2);
        D =(l0-m2*g/k1); %D为Dt
        dt=0.001;
        for t=0:0.001:100+10*2*pi/w
            MG=-R1*b;
            MZ=-Cp*bb;
            MJ=L*cos(w*t);
            MM=k2*(b-a);
            MMM=R3*(bb-aa);
            bbb=(MJ+MZ+MG-MM-MMM)/(I+Ia);
            ZZZ = ((1/3*pi*r1^2*h2 -Z*cos(b)*pi*r1^2+pi*r1^3*tan(b))*ro*g-m1*g+f*cos(w*t)-ZZ*Cw-k1*(l0-D)*cos(a)+R2*DD*cos(a))/(m1 + ma);
            aaa=(m2*g*sin(a)*D+m2*ZZZ*sin(a)*D+MM+MMM)/(1/4*m2*r1^2+2/3*((D+1/2)^3-D^3));
            DDD=(k1*(l0-D)-R2*DD-m2*g*cos(a)-m2*ZZZ*cos(a)+m2*D*aa^2)/m2;
            ZZ = ZZ + ZZZ*dt;
            DD = DD + DDD*dt;
            Z = Z + ZZ*dt;
            D = D + DD*dt;
            bb=bb+bbb*dt;
            aa=aa+aaa*dt;
            a=a+aa*dt;
            b=b+bb*dt;
            if t>100
                P=R2*DD^2+R3*(bb-aa)^2;
                P1=P1+P*dt;
            end
        end
        P1=P1/(10*2*pi/w);%求一个周期内的平均功率
        x1=[x1,P1];
        plot3(R2,R3,P1,'.r')
        hold on
        x2=[x2,R3];
        x3=[x3,R2];
    end
end
%矩阵转置
x1=x1';
x2=x2';
x3=x3';
%导出数据
xlswrite('F:\MATLABtest4\test4_1.xlsx',x1,'sheet1')
xlswrite('F:\MATLABtest4\test4_1.xlsx',x2,'sheet2')
xlswrite('F:\MATLABtest4\test4_1.xlsx',x3,'sheet3')

