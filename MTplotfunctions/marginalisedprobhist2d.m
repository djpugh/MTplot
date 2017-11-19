function n=marginalisedprobhist2d(x,y,xbins,ybins,p)
if length(x)~=length(y)
    error('Size of x and y should be the same')
end
N=length(x);
[~,xindices]=histc(x,xbins);
[~,yindices]=histc(y,ybins);
if size(yindices,1)>size(yindices,2)
    yindices=yindices';
end
if size(xindices,1)>size(xindices,2)
    xindices=xindices';
end
n=accumarray([yindices',xindices'],p,[length(ybins),length(xbins)]);%NB accumarray swap x and y as x,y orientation swapped for plot
end
% Simple accumarray plotting test
% xindices=[1,2,1,1];
% yindices=[1,1,1,1];
% n1=accumarray([xindices;yindices]',ones(1,4),[4,4])
% 
% n1 =
% 
%      3     0     0     0
%      1     0     0     0
%      0     0     0     0
%      0     0     0     0
% 
% n2=accumarray([yindices;xindices]',ones(1,4),[4,4])
% 
% n2 =
% 
%      3     1     0     0
%      0     0     0     0
%      0     0     0     0
%      0     0     0     0
% 
% x=[0:3];
% y=x';
% y=[y,y,y,y]
% 
% y =
% 
%      0     0     0     0
%      1     1     1     1
%      2     2     2     2
%      3     3     3     3
%      
% x=[x;x;x;x]
% 
% x =
% 
%      0     1     2     3
%      0     1     2     3
%      0     1     2     3
%      0     1     2     3
%      
% figure();
% surf(x,y,n);
% view([0,90]); 
%
% BUT
% 
% x=[0:3];
% y=x';
% [X,Y]=ndgrid(x,y)
% 
% X =
% 
%      0     0     0     0
%      1     1     1     1
%      2     2     2     2
%      3     3     3     3
% 
% 
% Y =
% 
%      0     1     2     3
%      0     1     2     3
%      0     1     2     3
%      0     1     2     3
%
% ndgrid swaps x,y cf. this code