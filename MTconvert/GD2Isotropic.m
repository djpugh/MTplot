function Isotropic=GD2Isotropic(g,d)
old=size(g);
g=reshape(g,numel(g),1);
d=reshape(d,numel(d),1);
E=GD2E(g,d);
Isotropic=reshape(sum(E,2)/3,old(1),old(2));
end