function v=MT2poissonRatio(MT)
if iscell(MT)
    n=numel(MT);
    x=size(MT,1);
    y=size(MT,2);
else
    n=size(MT,2);
    x=1;
    y=n;
end
v=zeros(1,n);
[~,~,~,E]=MT2TNPE(MT);
for i=1:numel(MT)
    v(i)=E(i,2)/(E(i,1)+E(i,3));
end
v=reshape(v,x,y);
end