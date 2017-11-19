% ExampleConvert.m
%
% Script
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
%
% Script to run MTconvert on multiple events.
% Need to add code to read in data and format it.
% Expecting to have info cell array - containing a string in the format:
%       id,y,m,d,h,mi,s,lat0,lon0,dep0,
% For each event and the associated moment tensor information as
% [s1,d1,r1;s2,d2,r2] 
% or
% [M1xx,M1yy,M1zz,M1xy,M1xz,M1yx;M2xx,M2yy,M2zz,M2xy,M2xz,M2yx]
%
% Outputs file to mtConvertOutput_YYYYmmdd_HHMM.csv
%


% Output String Initialisation
outputString='';

%Region to set mt values/read them in:

%
%
%
% Need to add code here 
%
%
%

% info cell array - contains strings of additional info, ie. id,y,m,d,h,mi,s,lat0,lon0,dep0,

% Example info cell array
info={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36'};

MTs=[0,0,0;90,0,0;0,20,0;90,20,0;0,40,0;90,40,0;0,60,0;90,60,0;0,80,0;90,80,0;0,90,0;90,90,0;0,0,90;90,0,90;0,20,90;90,20,90;0,40,90;90,40,90;0,60,90;90,60,90;0,80,90;90,80,90;0,90,90;90,90,90;0,0,-90;90,0,-90;0,20,-90;90,20,-90;0,40,-90;90,40,-90;0,60,-90;90,60,-90;0,80,-90;90,80,-90;0,90,-90;90,90,-90;];
nl=size(MTs);
format='extended';
%Loop over values 
for line=1:(nl(1))

    %If info vector as cell array
    outputSting=strcat(outputString,info{line});


    result=MTconvert(MTs(line,:));

    % Output format = 'simple'
    % Strike1,Dip1,Rake1,Strike2,Dip2,Rake2,N1strike,N1dip,N2strike,N2dip,Tstrike,Tdip,Nstrike,Ndip,Pstrike,Pdip
    %
    % No other formats defined at the moment (27/4/12)

    outputString=strcat(outputString,str(result,format));
    outputString=strcat(outputString,'\r\n');

    
end

%Output to file
fname = sprintf('mtConvertOutput_%s.csv',datestr(now,'yyyymmdd_HHMM'));

fid = fopen(fname,'w+');
head=MTresults.header(format);
% If providing other information uncomment the bottom line
header='';
%header='id,y,m,d,h,mi,s,lat0,lon0,dep0,';
header=strcat(header,head);
fprintf(fid,header);
fprintf(fid,outputString);
fclose(fid);
