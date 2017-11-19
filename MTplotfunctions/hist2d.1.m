function n=hist2d(x,y,xbins,ybins)
if length(x)~=length(y)
    error('Size of x and y should be the same')
end
N=length(x);
[~,xindices]=histc(x,xbins);
[~,yindices]=histc(y,ybins);
n=accumarray([yindices',xindices'],ones(1,N),[length(ybins),length(xbins)]);
end