function MT=SDR2MT(strike,dip,rake)
% Converts strike dip and rake to the full moment tensor
%
% Inputs are the strike dip and rake in degrees.
% 
% Calculates the moment tensor following Aki and Richards p 112:
%   Coordinates are x=North, y=East, z=Down
%
% Returns the full 3x3 moment tensor
%
Mxx=-(sind(dip)*cosd(rake)*sind(2*strike)+sind(2*dip)*sind(rake)*sind(strike)*sind(strike));
Mxy=(sind(dip)*cosd(rake)*cosd(2*strike)+0.5*sind(2*dip)*sind(rake)*sind(2*strike));
Mxz=-(cosd(dip)*cosd(rake)*cosd(strike)+cosd(2*dip)*sind(rake)*sind(strike));
Myy=(sind(dip)*cosd(rake)*sind(2*strike)-sind(2*dip)*sind(rake)*cosd(strike)*cosd(strike));
Myz=-(cosd(dip)*cosd(rake)*sind(strike)-cosd(2*dip)*sind(rake)*cosd(strike));
Mzz=(sind(2*dip)*sind(rake));
MT=[Mxx,Mxy,Mxz;Mxy,Myy,Myz;Mxz,Myz,Mzz];