function v=poissonRatio(lambda,mu)
if nargin<1
    lambda=1;
end
if nargin<2
    mu=1;
end
if nargin==1&&numel(lambda)==21
    C=lambda;
end
C=isotropicC(lambda,mu);
v=C(2)/(C(1)+C(2));
end