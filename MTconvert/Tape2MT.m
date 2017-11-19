function MT=Tape2MT(gamma,delta,kappa,h,sigma)
% Convert Tape and Tape Parameters gamma, delta, kappa, h and sigma to Moment Tensor 
%
% Inputs are gamma, delta, kappa, h and sigma in radians where applicable
% For more information see Tape and Tape GJI 2012
%
%   Coordinates are x=North, y=East, z=Down
%
[T,N,P,E]=Tape2TNPE(gamma,delta,kappa,h,sigma);
MT=TNPE2MT(T,N,P,E);