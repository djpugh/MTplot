function [x,y,z]=GetSmallCircle(pole,rad,az)
if nargin<3
    az=[0,2*pi];
end

%Calculate about z axis and rotate

n=360;
X=ones(3,n);
az=linspace(az(1),az(2),n);
X(1,:)=sin(rad)*cos(az);
X(2,:)=sin(rad)*sin(az);
X(3,:)=X(3,:)*cos(rad);
%Calculate rotation matrix - simple rotation about a rotation axis
rAxis=cross(pole,[0;0;1]);
if any(rAxis)
    theta=-asin(sqrt(sum(rAxis.^2))/(sqrt(sum(pole.^2))));
    rAxis=rAxis/sqrt(sum(rAxis.^2));
    rX=rAxis(1);
    rY=rAxis(2);
    rZ=rAxis(3);
    R=[1,0,0;0,1,0;0,0,1]*cos(theta)+sin(theta)*[0,-rZ,rY;rZ,0,-rX;-rY,rX,0]+(1-cos(theta))*(rAxis'*rAxis);       
else
    R=[1,0,0;0,1,0;0,0,1];
end
v=R*X;
x=v(1,:);
y=v(2,:);
z=v(3,:);
end