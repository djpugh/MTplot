function [r,theta,phi]=invertEqualAngleProj(X,Y,X0,Y0,R0)
%Normalise and center coords
X=(X-X0)/R0;
Y=(Y-Y0)/R0;
%Funky changes for foulger code..
r=[-2*Y/(X^2+Y^2+1);2*X/(X^2+Y^2+1);-(1-X^2-Y^2)/(X^2+Y^2+1);];
theta=acos(r(3));
phi=mod(atan2(r(2),r(1)),2*pi);
end