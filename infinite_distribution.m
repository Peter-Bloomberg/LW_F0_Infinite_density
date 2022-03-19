clear


alpha = 1.5;
F0 = 1;
v0 = 1;

t = 5d4;
x0 = 0;


n = 2d5;
X = zeros(1, n);

parfor i = 1: n
    i
    %clearvars -except X i n t alpha x0 v0 r F0 
    [k, MM] = levy_walk_F0(x0, v0, F0, t, alpha);
    if k == 0
        x = x0;
    else
        x = MM(2, k+1);
    end
    X(1,i) = x;    
end

x_min = 1d5;
x_max = 1.5d9;
d = 1d6;

n2 = floor((x_max - x_min)/d);%n2相当于是划分区间的个数
P = zeros(1, n2);
for i2 = 1: n
    i2
    for i3 = 0: n2 - 1
        a = x_min + i3 * d;
        b = x_min + (i3 + 1) * d;
        if X(1, i2)>=a && X(1, i2)<b
            P(1, i3 + 1) = P(1, i3 + 1) + 1 / n; 
            continue
        end
    end
end

for i4 = 1: n2
    P(1, i4) = P(1, i4) / d;
end
Xi = zeros(1, n2);
for i5 = 1: n2
    Xi(1, i5) = x_min + (i5 - 1) * d;
end
hold on;
loglog(Xi, P, '*')