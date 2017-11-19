function Explosion=GD2Explosion(g,d,lambda,mu)
if nargin<3
    lambda=1;
end
if nargin<4
    mu=1;
end
old=size(g);
g=reshape(g,numel(g),1);
d=reshape(d,numel(d),1);
E=GD2E(g,d);
Explosion=(lambda+mu)*E(:,2)/mu-lambda*(E(:,1)+E(:,3))/(2*mu);
Explosion=reshape(Explosion,old(1),old(2));
end