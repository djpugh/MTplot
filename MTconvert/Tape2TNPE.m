function [T,N,P,E]=Tape2TNPE(gamma,delta,kappa,h,sigma)
% Convert Tape and Tape Parameters gamma, delta, kappa, h and sigma to Tension, Neutral, Pressure and Eigenvalues 
%
% Inputs are gamma, delta, kappa, h and sigma in radians where applicable
% For more information see Tape and Tape GJI 2012
%
%   Coordinates are x=North, y=East, z=Down
%
E=GD2E(gamma,delta);
[N1,N2]=SDR2FP(kappa*180/pi,acosd(h),sigma*180/pi);
[T,N,P]=FP2TNP(N1,N2);