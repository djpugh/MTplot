function C=VTIC(C11,C12,C13,C33,C44,C66)
if nargin<1
    mu=1;
    lambda=1;
    C11=lambda+2*mu;
    C12=lambda;
    C13=lambda;
    C33=lambda+2*mu;
    C44=mu;
    C66=mu;
end
if nargin==1
    C=C11;
    C11=C(1);
    C12=C(2);
    C13=C(3);
    C33=C(4);
    C44=C(5);
    C66=C(6);
end
C=[C11,C12,C13,0,0,0,C11,C13,0,0,0,C33,0,0,0,C44,0,0,C44,0,C66];
end