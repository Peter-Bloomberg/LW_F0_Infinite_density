function Y=PowerDensity(tau0,lambda,N)

% generate power distribution randon variable
%  t0     : a small number (go to zeros)
%  lamda  : the number of power
%  N      : the number of variable
% p(t)=t0^lambda*lambda*t^(-lambda-1)
if nargin==2;
    N=1;
end
xi=unifrnd(0,1,1,N);
Y=tau0.*((1-xi).^(-1/lambda)-1);

%Y=t0./((xi).^(1/lambda));
end

%  f(t)=lambda*(1+t)^(-1-lambda)
%  f(t)=t0^lambda*lambda*t^(-lambda-1),F(t)=1-t0^lambda*t^(-lambda)
%  F(y)^(-1)=t0/(1-y).^1/lambda
%  y---U(0,1)