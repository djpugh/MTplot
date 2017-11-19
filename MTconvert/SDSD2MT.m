function MT=SDSD2MT(Strike1,Dip1,Strike2,Dip2)
% Convert Fault and auxiliary plane Strike and Dip pairs to full moment tensor
%
% Inputs are strike and dip of the fault plane and strike and dip of the
% auxiliary plane in degrees
%
%   Coordinates are x=North, y=East, z=Down
%
[N,S]=SDSD2FP(Strike1,Dip1,Strike2,Dip2);
[s,d,r]=FP2SDR(N,S);
MT=SDR2MT(s,d,r);