function [s,d,r]=mean_orientation(azimuth,dip,rake,mode)
if nargin<4
    mode='rad';
end
[x,y,z]=toa2xyz(azimuth,dip,false,mode,false);
N=[x;y;z];
%Check normals align#
N(:,N(:,1)'*N<0)=-N(:,N(:,1)'*N<0);
n=mean(N')';
if n~=[0;0;1];
    n2=cross(n,[0;0;1]);
else
    n2=cross(n,[0;1;0]);
end
r=mean(rake);
%Convert back
[s,d,~]=FP2SDR(n,n2);

end