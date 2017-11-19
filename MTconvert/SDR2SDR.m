function [Strike,Dip,Rake]=SDR2SDR(Strike0,Dip0,Rake0)
% Convert Strike, Dip and Rake of one plane to Strike, Dip and Rake of the other
%
% Inputs are strike, dip and rake of one plane in degrees
%
[N1,N2]=SDR2FP(Strike0,Dip0,Rake0);
[Strike1,Dip1,Rake1]=FP2SDR(N1,N2);
[Strike2,Dip2,Rake2]=FP2SDR(N2,N1);
if abs(Strike1-Strike0)<10
    Strike=Strike2;
    Dip=Dip2;
    Rake=Rake2;
else
    Strike=Strike1;
    Dip=Dip1;
    Rake=Rake1;
end
