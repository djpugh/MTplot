function [Slip,Normal]=SDSD2FP(Strike1,Dip1,Strike2,Dip2)
% Convert Fault and auxiliary plane Strike and Dip pairs to slip and normal vectors
%
% Inputs are strike and dip of the fault plane and strike and dip of the
% auxiliary plane in degrees
%
%   Coordinates are x=North, y=East, z=Down
%
%Values from SDR2FP
Slip=[-sind(Strike2)*sind(Dip2);cosd(Strike2)*sind(Dip2);-cosd(Dip2)];
Normal=[-sind(Strike1)*sind(Dip1);cosd(Strike1)*sind(Dip1);-cosd(Dip1)];