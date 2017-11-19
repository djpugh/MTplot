function TNPPDFPlot(MT,h,options,~)
if ~strcmp(char(class(MT)),'cell')
    MT={MT};
end
MT=MTcheck(MT);
try
    N=options.Resolution;
catch
    N=100;
end
x=ones(N,N);
y=ones(N,N);
z=ones(N,N);
c=ones(N,N);
dA=ones(N,N);
%set up theta values
dt=pi/(N-1);
%set up phi values
dp=2*pi/(N-1);
phi=reshape(kron(0:dp:2*pi,ones([N,1])),[1 N*N]);
theta=reshape(kron(0:dt:pi,ones([N,1]))',[1 N*N]);
%Histogram orientation - phi corresponds to first index
%
rvec=[sin(theta).*cos(phi);sin(theta).*sin(phi);cos(theta)];
x=reshape(rvec(1,:),[N N]);
y=reshape(rvec(2,:),[N N]);
z=reshape(rvec(3,:),[N N]);
[T,N,P,~]=MT2TNPE(MT);
[TAz,TToa]=xyz2toa([T(1,:),-T(1,:)],[T(2,:),-T(2,:)],[T(3,:),-T(3,:)],options,'rad');%Doubled for both ends of plot
[NAz,NToa]=xyz2toa([N(1,:),-N(1,:)],[N(2,:),-N(2,:)],[N(3,:),-N(3,:)],options,'rad');
[PAz,PToa]=xyz2toa([P(1,:),-P(1,:)],[P(2,:),-P(2,:)],[P(3,:),-P(3,:)],options,'rad');
%tic,[X,Y]=cellfun(@options.ProjFn,MT);toc
prange=0:dp:2*pi;
trange=0:dt:pi;
Tz=probhistc2d(TAz,TToa,prange,trange,[options.Probability,options.Probability],options.Marginalised,options.Logarithm,options.Normalise);  
Nz=probhistc2d(NAz,NToa,prange,trange,[options.Probability,options.Probability],options.Marginalised,options.Logarithm,options.Normalise);  
Pz=probhistc2d(PAz,PToa,prange,trange,[options.Probability,options.Probability],options.Marginalised,options.Logarithm,options.Normalise);  
%Tz etc - phi is the 'x' coordinate and theta the 'y' for the flat hist
%
[X,Y,Z]=options.ProjFn(x,y,z,options);
X(isinf(X))=NaN;
Y(isinf(Y))=NaN;
Z(isinf(Z))=NaN;
%Rescale the axes if necessary
maxValues=(options.ProjFn([1;0;0;0],[0;1;0;0],[0;0;1;-1]));
maxValues(maxValues==Inf)=0;
maxValue=max(maxValues);
set(0, 'currentfigure', h);
axis off
hold on;
p=panel();
p.pack(1,3);
p(1,1).select();
if options.Interp
surf(X,Y,Z,Tz,'EdgeColor','none','FaceColor','interp');
else
surf(X,Y,Z,Tz,'EdgeColor','none');
end
    
ramp = (ones(1,64)-linspace(0,1,64)).^.5;
red  = 0.99*[ ones(1,64); ramp; ramp ]';
colormap(red);
freezeColors;
options.BackgroundFn(MT,h,options)
if options.AxisLines
    a=1.1;
else
    a=1.1;
end
text(a*maxValue,-a*maxValue,a*maxValue,'T','FontSize',options.FontSize,'VerticalAlignment','top','HorizontalAlignment','left')
p(1,2).select();
if options.Interp
surf(X,Y,Z,Nz,'EdgeColor','none','FaceColor','interp');
else
surf(X,Y,Z,Nz,'EdgeColor','none');
end
% cm=[1,1,1;cm];
green = 0.99*[ ramp; ones(1,64); ramp]';
colormap(green);
freezeColors;
options.BackgroundFn(MT,h,options)
text(a*maxValue,-a*maxValue,a*maxValue,'N','FontSize',options.FontSize,'VerticalAlignment','top','HorizontalAlignment','left')
p(1,3).select();
if options.Interp
surf(X,Y,Z,Pz,'EdgeColor','none','FaceColor','interp');
else
surf(X,Y,Z,Pz,'EdgeColor','none');
end
% cm=[1,1,1;cm];
blue = 0.99*[ ramp; ramp; ones(1,64) ]';
colormap(blue);
freezeColors;
options.BackgroundFn(MT,h,options)
text(a*maxValue,-a*maxValue,a*maxValue,'P','FontSize',options.FontSize,'VerticalAlignment','top','HorizontalAlignment','left')
hold off
axis square;
if ~options.AxisLines
p.de.margin=-10;
else
 p.marginright=5;
end
end
function [az,toa]=xyz2toa(x,y,z,options,mode)

if nargin<4
    options.Lower=1;
    options.StationProjection=1;
    options.Radians=true;
    mode='rad';
end
if nargin<5
    mode='rad';
else
    if strcmpi(mode,'rad')
        options.Radians=1;
    else
        options.Radians=0;
    end 
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
if strcmpi(mode,'deg')
    toa=acosd(z);
    az=atan2d(y,x);
else
    toa=acos(z);
    az=atan2(y,x);
end

% if options.StationProjection
az=mod(az,2*pi);
% if options.Lower
%         toa(toa>pi/2)=pi-toa(toa>pi/2);
%         az(toa>pi/2)=mod(az(toa>pi/2)+pi,2*pi);
% else
%         toa(toa<pi/2)=pi-toa(toa<pi/2);
%         az(toa<pi/2)=mod(az(toa<pi/2)+pi,2*pi);
% end
%         
% end
end
