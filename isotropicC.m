function C=isotropicC(lambda,mu)
if nargin<1
    lambda=1;
end
if nargin<2
    mu=1;
end
if nargin==1&&numel(lambda)==21
    C=lambda;
    %Eqns 81a and 81b from chapman and leaney 2011
    mu=((C(1)+C(7)+C(12))+3*(C(16)+C(19)+C(21))-(C(2)+C(3)+C(8))/15);
    lambda=((C(1)+C(7)+C(12))-2*(C(16)+C(19)+C(21))+4*(C(2)+C(3)+C(8))/15);
end
n=lambda+2*mu;
C=[n,lambda,lambda,0,0,0,n,lambda,0,0,0,n,0,0,0,mu,0,0,mu,0,mu];
end