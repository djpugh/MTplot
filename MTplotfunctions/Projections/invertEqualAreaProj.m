function [r,theta,phi]=invertEqualAreaProj(X,Y,X0,Y0,R0)
%Normalise and center coords
X=sqrt(2)*(X-X0)/R0;
Y=sqrt(2)*(Y-Y0)/R0;
%Funky changes for foulger code..
r=[Y*sqrt(1-(X^2+Y^2)/4);-X*sqrt(1-(X^2+Y^2)/4);(1-(X^2+Y^2)/2);];
theta=acos(r(3));
phi=mod(atan2(r(2),r(1)),2*pi);
end