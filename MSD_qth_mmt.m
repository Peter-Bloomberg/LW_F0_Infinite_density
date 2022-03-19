clear


alpha = 1.2;
q = 0.8;

ta = 1d4;
d = 1.2;
tb = 1d5;

ln_d = log(d);
ln_ta = log(ta);
ln_tb = log(tb);

x0 = 0;
v0 = 1;
F0 = 1;
w = 1;




counter = 0;
V = zeros;
W = zeros;
Mq = zeros;
counter2 = 0;


for ln_t = ln_ta:ln_d:ln_tb
    t = exp(ln_t);
    n = 5d4;%n是轨迹的个数。
    X = zeros(1,n);
    parfor i = 1:n
        t
        i        
        %F0 w 
        %[k,MM]=levy_walk_HP(x0, v0, w, t, alpha);        
        [k,MM] = levy_walk_HP_2(x0, v0, F0, t, alpha);
        x = MM(2, k + 1);
        X(1, i) = x;
    end
    varx = 0;
    avr = 0;
    mq = 0;
    for j = 1:n
        varx = varx + X(1,j)^2; % second moment
        avr = avr + X(1,j);
        mq = mq + abs(X(1,j))^q; % q-th moment
    end
    varx = varx / n;
    avr = avr / n;
    mq = mq / n;
    counter = counter + 1;

    V(1,counter) = t;
    W(1,counter) = varx;  
    Av(1,counter) = avr;
    Mq(1,counter) = mq;
    

%     hold on;
%     plot(t,varx,'*');
    
end

H = v0^2/w^2 - W;

sigma = W - Av.^2;

hold on;
loglog(V, Mq, '*');