function [q,Run_off] = UH_flow(Data)
%地表&壤中汇流——时段单位线
Q=Data(:,1); %地表流量
r=Data(:,2); %净雨 
m=length(r(r>=0)); %净雨时段数
t=length(Q); %直接径流时段数
n=t-m+1; %时段单位线时段数
% if t < n
%     k1=1;
% else
%     k1=t-n+1;
% end

if t < m
    k2=t;
else
    k2=m;
end
q=zeros(n,1);

for i=1:t
    if i==1
        q(i)=Q(1)/r(1)*10;
        continue
    end
    add=0;
    for j=2:k2
        if (i-j+1)<=0
            k=0;
        else
            k=r(j)*q(i-j+1)/10;
        end
        add=add+k;
    end
    q(i)=(Q(i)-add)*10/r(1);
    if q(i)<0
        q(i)=0;
        break
    end
end
n1=length(q);

Run_off=zeros(m-1+n1,m);
for i=1:m
    Run_off(i:n1+i-1,i) = r(i)/10.*q;
end
x=1:length(q);
figure
yyaxis right
plot(x,q,'g')
min_max=get(gca,'Ylim');
set(gca,'ytick',min_max(1):(min_max(2)-min_max(1))/10:min_max(2)) 
yyaxis left
bar(1:length(r),r,"b")
ylim([0 max(q)])
% min_max=get(gca,'Ylim');
% set(gca,'ytick',min_max(1):(min_max(2)-min_max(1))/10:min_max(2)) 
set(gca,'ydir','reverse');
title('时段单位线')
end