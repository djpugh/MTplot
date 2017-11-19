function [Slip,Normal]=SDR2FP(Strike,Dip,Rake)
% Convert strike, dip and rake to the slip and normal for a plane (i.e. the normals to the fault and auxiliary planes)
%
%   Coordinates are x=North, y=East, z=Down
%
% Inputs are the strike dip and rake in degrees.
%
    Slip=[cosd(Strike).*cosd(Rake)+sind(Strike).*cosd(Dip).*sind(Rake);sind(Strike).*cosd(Rake)-cosd(Strike).*cosd(Dip).*sind(Rake);-sind(Dip).*sind(Rake)];
    Normal=[-sind(Strike).*sind(Dip);cosd(Strike).*sind(Dip);-cosd(Dip)];