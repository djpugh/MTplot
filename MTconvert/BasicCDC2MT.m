function MT=BasicCDC2MT(alpha,kappa,h,sigma,poisson)
%Convert opening angle, strike, dip, rake and poisson ratio (default =0.25) to full moment tensor
%
%   Coordinates are x=North, y=East, z=Down
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
if nargin<5
    poisson=0.25;
end
gamma=atan((-1/sqrt(3))*cos(alpha));
beta=acos(sqrt(2/3)*cos(alpha)*(1+poisson)/sqrt((1-2*poisson)^2+(1+2*poisson.^2)*cos(alpha).^2));
delta=pi/2-beta;
MT=Tape2MT(gamma,delta,kappa,h,sigma);

