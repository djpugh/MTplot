%PlotPlane(h,strike,dip,options,varargin)
%
% Plot a plane on figure h usig projection options etc from MTplot
%
% User can specify:
%   'Color' - defaults to 'r'
%   'Style' - defaults to '--'
%   'Weight' - defaults to 2

function PlotPlane(h,strike,dip,options,varargin)
try
    [plotOptions,~]=Parser(varargin{:});
catch ME
    error(ME.message)
end
if strcmpi(options.Projection,'EqualAngle')
    options.ProjFn=@EqualAngleProj;
else
    options.ProjFn=@EqualAreaProj;
end
figure(h);
hold on
[vx1,vy1,vz1]=toa2xyz((strike+90),(90-dip),false,'deg');
[vx2,vy2,vz2]=toa2xyz(strike,90,false,'deg');
[x1,y1,z1]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
[X1,Y1,Z1]=options.ProjFn(x1,y1,z1,options);
hold on;
plot3(1*X1,1*Y1,1*Z1,'Color',plotOptions.Color,'LineStyle',plotOptions.Style,'LineWidth',plotOptions.Weight,'Marker','None')
hold off;
end

function [options,unmatched]=Parser(varargin)
parser=inputParser();
parser.KeepUnmatched=true;
parser.addParamValue('Color','r',@(x) true)
parser.addParamValue('Style','--',@ischar)
parser.addParamValue('Weight',2,@isnumeric)
parser.parse(varargin{:});
options=parser.Results;
unmatched=parser.Unmatched;
end