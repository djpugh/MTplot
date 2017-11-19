function [x,y,z]=toa2xyz(az,toa,options,mode,convert)
if nargin<3
    options.Lower=1;
    options.StationProjection=1;
    options.Radians=true;
    mode='rad';
end
if nargin<4
    mode='rad';
end
if nargin<5
    convert=true;
end
if strcmpi(class(options),class(true))
    clear options;
    options.Lower=1;
    options.StationProjection=1;
    options.Radians=true;
    if strcmpi(mode,'deg')
        options.Radians=false;
    end
end
if options.Radians
    mode='rad';
else
    mode='deg';
end
    
%assuming toa is 0 down
theta=toa;
if strcmpi(mode,'deg')
    az=az*pi/180;
elseif max(az)>2*pi 
    az=az*pi/180;
end

if strcmpi(mode,'deg')
    theta=theta*pi/180;
elseif max(theta)>2*pi
    theta=theta*pi/180;
end
if convert&&options.StationProjection
    if options.Lower
        az(theta>pi/2)=az(theta>pi/2)+pi;
        az=mod(az,2*pi);
        theta(theta>pi/2)=pi-theta(theta>pi/2);
    else
        az(theta<pi/2)=az(theta<pi/2)+pi;
        az=mod(az,2*pi);
        theta(theta<pi/2)=pi-theta(theta<pi/2);
    end
        
end
x=sin(theta).*cos(az);
y=sin(theta).*sin(az);
z=cos(theta);
end