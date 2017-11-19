function n=probhistc3d(x,y,z,xbins,ybins,zbins,probability,marginalised,logarithm,normalise)
if nargin<9
    logarithm=false;
end
if nargin<10
    normalise=false;
end
if numel(probability)<2
    n=marginalisedprobhist3d(x,y,z,xbins,ybins,zbins,ones(size(s)));  
elseif marginalised
    n=marginalisedprobhist3d(x,y,z,xbins,ybins,zbins,probability);   
else
    n=maxprobhist3d(x,y,z,xbins,ybins,zbins,probability);
end

if normalise && (marginalised||numel(probability)<2)
    n=n/sum(reshape(n,1,numel(n))*mean(diff(xbins))*mean(diff(ybins))*mean(diff(zbins)));
end
if logarithm
    n=log(n);
end
end
function n=marginalisedprobhist3d(x,y,z,xbins,ybins,zbins,p)
if length(x)~=length(y) && length(y)~=length(z)
    error('Size of x, y and z should be the same')
end
[~,xindices]=histc(x,xbins);
[~,yindices]=histc(y,ybins);
[~,zindices]=histc(z,zbins);
Indices=[xindices',yindices',zindices'];
n=accumarray(Indices,p,[length(xbins),length(ybins),length(zbins)]);%first index corresponds to x, second to y and third to z
end
function n=maxprobhist3d(x,y,z,xbins,ybins,zbins,p)
if length(x)~=length(y)&& length(y)~=length(z)
    error('Size of x,y and z should be the same')
end
[~,xindices]=histc(x,xbins);
[~,yindices]=histc(y,ybins);
[~,zindices]=histc(z,zbins);
Indices=[xindices',yindices',zindices'];
A=unique(Indices,'rows')';
p2=zeros(1,size(A,2));
for i=1:size(A,2)
    p2(i)=max(p(((xindices==A(1,i)).*(yindices==A(2,i)).*(zindices==A(3,i)))>0));
end
%p2=p2/max(p2);
n=accumarray(A',p2,[length(xbins),length(ybins),length(zbins)]);
end