function [az,toa]=xyz2toa(x,y,z,options,mode)
if nargin<5 
    mode='rad';
end
if nargin<4
    options.Radians=~strcmpi(mode,'deg');
end
if strcmpi(class(options),class(true))
    clear options;
    options.Radians=~strcmpi(mode,'deg');
    
end
if options.Radians
    mode='rad';
else
    mode='deg';
end
    
%assuming toa is 0 down and NED systems
theta=acos(z);
az=atan2(y,x);
if strcmpi(mode,'deg')
    az=az*180/pi;
    theta=theta*180/pi;
end
toa=theta;
end