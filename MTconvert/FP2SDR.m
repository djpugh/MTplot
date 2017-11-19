function [Strike,Dip,Rake]=FP2SDR(Normal,Slip)
%
% Calculate strike, dip and rake in degrees for a normal and slip vector
%
% Inputs are the normal and slip vector for a fault plane
%
%   Coordinates are x=North, y=East, z=Down
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
if iscell(Normal)
    Strike= num2cell(zeros(1,length(Normal)));
    Dip=num2cell(zeros(1,length(Normal)));
    Rake=num2cell(zeros(1,length(Normal)));
    for i=1:length(Normal)
        [Strikei,Dipi,Rakei]=FP2SDR(Normal{i},Slip{i});
        Strike{:,i}=Strikei;
        Dip{:,i}=Dipi;
        Rake{:,i}=Rakei;
    end
    if ~all(cellfun(@iscell,Normal))
        Strike=cell2mat(Strike);
        Dip=cell2mat(Dip);
        Rake=cell2mat(Rake);
    end
    
else
    
% Normalise the vectors
Slip=Slip./kron(sqrt(sum(Slip.^2)),ones(3,1));
Normal=Normal./kron(sqrt(sum(Normal.^2)),ones(3,1));
%Check normal direction, if it is pointing downwards (ie the Down
%component is >0 then reverse direction to get the upwards normal
%Convert downward pointing normal to upwards normal
Slip(:,Normal(3,:)>0)=-1* Slip(:,Normal(3,:)>0);
Normal(:,Normal(3,:)>0)=-1* Normal(:,Normal(3,:)>0);
%
%Strike Calculation:
%   Projection of normal into N(x), E(y) plane:
%       Angle between normal and E(y) axis is the strike
%       Therefore Normal(E)=cos(Strike) and Normal(N)=-sin(Strike)
%       So Strike=atan(-Normal(N)/Normal(E))
%   With an upwards normal this angle is the true strike:
%       i.e. Dip 90 degrees clockwise of strike
%
Strike=atan2(-Normal(1,:),Normal(2,:));
%
%Dip Calculation:
%   Projection of normal into Down(z), Normal plane:
%       DipVector=StrikeVector x Normal (always down dip even if downwards normal)
%   Therefore:
%       DipVector=(Normal(E);-Normal(N);0)x(Normal(N),Normal(E),Normal(Down))
%       DipVector=(-Normal(N)*Normal(Down);-Normal(E)*Normal(Down);Normal(E)^2+Normal(N)^2)
%   And:
%       Dip=atan((Normal(E)^2+Normal(N)^2)/sqrt((Normal(N)*Normal(Down))^2+(Normal(E)*Normal(Down))^2))


Dip=atan2((Normal(2,:).^2+Normal(1,:).^2),sqrt((Normal(1,:).*Normal(3,:)).^2+(Normal(2,:).*Normal(3,:)).^2));

%
%Rake Calculation:
%   Rake is angle of slip vector with the strike:
%       Can calculate Sine component:
%           Component of slip perpendicular to the strike is sin(Rake)
%           Angle of plane to Z component is the Dip
%           Therefore Slip(Z)=-sin(Rake)*sin(Dip)
%       And Cosine Component:
%           Strike vector=[Normal(E),-Normal(N),0]
%           Angle between slip and strike is Rake
%           therefore StrikeVector . Slip =cos(Rake)
%           if |Slip| = 1 (i.e.normalised)
%           cos(Rake)=(Slip(N)*Normal(E)-Slip(E)*Normal(N))/|StrikeVector|
%   	And the rake is consequently:
%           Rake=atan(sin(Rake)/cos(Rake)
%           Rake=atan((-Slip(Down)/sin(Dip))/(Slip(N)*Normal(E)-Slip(E)*Normal(N))/|StrikeVector|))
%       But:
%           sin(Dip)=(Normal(E)^2+Normal(N)^2)/|DipVector|
%           |StrikeVector|=sqrt(Normal(E)^2+Normal(N)^2)
%           |DipVector|=|StrikeVector|*|Normal|
%           if |Normal|=1 (i.e.normalised) then |DipVector|=|StrikeVector|
%           so sin(Dip)=|StrikeVector|^2/|StrikeVector|=|StrikeVector|
%       So:
%           Rake=atan(-Slip(Z)/(Slip(N)*Normal(E)-Slip(E)*Normal(N)))
%
%       N=x, E=y, Down=Z

Rake=atan2(-Slip(3,:),Slip(1,:).*Normal(2,:)-Slip(2,:).*Normal(1,:));

% Convert to degrees:
Dip=Dip*180/pi;
Strike=Strike*180/pi;
Rake=Rake*180/pi;

% Limits of the different parameters (strike 0 -> 360, dip 0 -> 90 and rake
% -180 -> 180 )
Dip(Dip>90)=180-Dip(Dip>90);
Strike(Dip>90)=Strike(Dip>90)+180;
Rake(Dip>90)=2*180-Rake(Dip>90);
Strike(Strike>2*180)=Strike(Strike>2*180)-2*180;
Strike(Strike<0)=Strike(Strike<0)+2*180;
Rake(Rake>180)=Rake(Rake>180)-2*180;
Rake(Rake<-180)=Rake(Rake<-180)+2*180;
end
end