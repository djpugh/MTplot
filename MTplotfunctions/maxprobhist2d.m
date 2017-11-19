function n=maxprobhist2d(x,y,xbins,ybins,p)
if length(x)~=length(y)
    error('Size of x and y should be the same')
end
[~,xindices]=histc(x,xbins);
[~,yindices]=histc(y,ybins);
if size(xindices,1)>size(xindices,2)
    xindices=xindices';
end
if size(yindices,1)>size(yindices,2)
    yindices=yindices';
end
A=unique([xindices;yindices]','rows')';
for i=1:size(A,2)
    p2(i)=max(p(((xindices==A(1,i)).*(yindices==A(2,i)))>0));
end
%p2=p2/max(p2);
xindices=A(1,:);
yindices=A(2,:);
n=accumarray([yindices',xindices'],p2,[length(xbins),length(ybins)]);
end