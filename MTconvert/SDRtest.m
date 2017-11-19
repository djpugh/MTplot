function SDRtest(strike,dip,rake)
% Test the functions for calculating the strike, dip and rake from a full MT
%
% Inputs are the strike, dip and rake in degrees. These are converted into a full MT
% using SDR2MT
%
mt=SDR2MT(strike,dip,rake);
% Calculate the strike, dip and rake for the two planes of the mt
[strike1,dip1,rake1,strike2,dip2,rake2]=MT2SDR(mt);
% Calculate the deviations from the provided values
dstrike1=strike-strike1;
ddip1=dip-dip1;
drake1=rake-rake1;
dstrike2=strike-strike2;
ddip2=dip-dip2;
drake2=rake-rake2;
% Output the values for the test
out=sprintf('Values:\nGiven:\t%f\t%f\t%f\nCalc:\t%f\t%f\t%f\n\t\t%f\t%f\t%f\n\nDelta:\tStrike\t\tDip \t\tRake\nSet1:\t%f\t%f\t%f\nSet2:\t%f\t%f\t%f',strike,dip,rake,strike1,dip1,rake1,strike2,dip2,rake2,dstrike1,ddip1,drake1,dstrike2,ddip2,drake2);
disp(out)
