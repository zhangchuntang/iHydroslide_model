function [P] = routine_flow(K,x,t)
%   马斯京根法分段连续演算——汇流系数
%K——蓄量流量关系曲线的坡度  x——流量比重系数  t——计算时段
Kl=t;
n0=K/Kl;
xl=1/2-n0*(1-2*x)/2;
C(1)=(0.5*t-Kl*xl)/(0.5*t+Kl-Kl*xl);
C(2)=(0.5*t+Kl*xl)/(0.5*t+Kl-Kl*xl);
C(3)=(-0.5*t+Kl-Kl*xl)/(0.5*t+Kl-Kl*xl);
A=C(2)+C(1)*C(3);

for n=1:n0
    m=0;
    while true
        if m==0
            P(1,n)=C(1)^n;
            m=m+1;
            continue
        elseif m>0
            kk=0;
            if n>=m
                QQ=m;
            else
                QQ=n;
            end
            for i=1:QQ
                B=factorial(n)*factorial(m-1)/(factorial(i)*factorial(i-1)*factorial(n-i)*factorial(m-i));
                pp=B*C(1)^(n-i)*C(3)^(m-i)*A^i;
                kk=kk+pp;
            end
            P(m+1,n)=kk;
        end
        add=sum(P(:,n));
        if abs(add-1)<=0.0001
            break
        else
            m=m+1;
            continue
        end
    end
end
end