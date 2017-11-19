function [n,N]=probhistc(x,xbins,p,Marginalised,Logarithm,Normalise)
if nargin<5
    Logarithm=false;
end
if nargin<6
    Normalise=false;
end
[~,xindices]=histc(x,xbins);
if size(xindices,1)>size(xindices,2)
    xindices=xindices';
end
if numel(p)<2
    n=accumarray(xindices',ones(size(xindices')),[length(xbins),1]);
elseif Marginalised
    n=accumarray(xindices',p,[length(xbins),1]);
else
    A=unique(xindices);
    for i=1:size(A,2)
        p2(i)=max(p((xindices==A(1,i))>0));
    end
    %p2=p2/max(p2);
    xindices=A(1,:)';
    n=accumarray(xindices,p2,[length(xbins),1]);
end
N=sum(n);
if Normalise &&(Marginalised||numel(p)<2)
    n=n/(N*mean(diff(xbins)));
end
if Logarithm
    n=log(n);
end
end
