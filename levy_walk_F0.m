% LW for constant external force field F0

function [k,MM] = levy_walk_F0(x0, v0, F0, t, alpha)

clearvars -except t alpha x0 v0 F0 

N = 0;
waiting_time2 = zeros;
x = x0;
x2 = zeros;
dt = 0;
MM = zeros;

while 1 == 1

    tau = PowerDensity(1,alpha,1);
    % tau = exprnd(1 / alpha);

    dt = dt + tau;
    N = N + 1;
    
    if dt <= t
        waiting_time2(1,N) = tau;
        r2 = rand;
        if r2 <= 0.5
            xx = 1/2 * F0 * tau^2 + x + v0 * tau;
        else
            xx = 1/2 * F0 * tau^2 + x - v0 * tau;
        end
        l = xx - x;
        x2(1,N) = l;
        x = xx;
    else
        tau2 = t - dt + tau;
        N = N + 1;
        waiting_time2(1,N)=tau2;
        r2 = rand;
        if r2 <= 0.5
            xx = 1/2 * F0 * tau2^2 + x + v0 * tau2;
        else
            xx = 1/2 * F0 * tau2^2 + x - v0 * tau2;
        end
        l = xx - x;
        x2(1, N) = l; 
        break;
    end
end
 

for i = 1:N + 1
    if i == 1
        MM(1,i) = 0;
        MM(2,i) = x0;
    else
        MM(1,i) = MM(1,i - 1) + waiting_time2(1,i - 1);
        MM(2,i) = MM(2,i-1) + x2(1,i - 1);
    end
end

k = N;


% 
% 
% for i=1:N
%     m1=zeros(1,2);
%     m2=zeros(1,2);
%     m1(1,1)=MM(1,i);m1(1,2)=MM(1,i+1);
%     m2(1,1)=MM(2,i);m2(1,2)=MM(2,i+1);
%     plot(m1,m2,'r');
%     hold on
% end
