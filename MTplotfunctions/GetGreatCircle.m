function [x,y,z]=GetGreatCircle(v1,v2,range,n)
if nargin<3
    range=4;
end
delta1=v2-v1;
delta2=-v2-v1;
delta3=-v2+v1;
delta4=v2+v1;
if nargin<4
n=100;
end
X1=ones(1,n);
X2=ones(1,n);
X3=ones(1,n);
X4=ones(1,n);
Y1=ones(1,n);
Y2=ones(1,n);
Y3=ones(1,n);
Y4=ones(1,n);
Z1=ones(1,n);
Z2=ones(1,n);
Z3=ones(1,n);
Z4=ones(1,n);
for i=1:n
    x1=v1+(i*delta1/(n));
    x2=v2+(i*delta2/(n));
    x3=-v1+(i*delta3/(n));
    x4=-v2+(i*delta4/(n));
    pointvec1=x1/norm(x1);
    pointvec2=x2/norm(x2);
    pointvec3=x3/norm(x3);
    pointvec4=x4/norm(x4);
    X1(i)=pointvec1(1);
    Y1(i)=pointvec1(2);
    Z1(i)=pointvec1(3); 
    X2(i)=pointvec2(1);
    Y2(i)=pointvec2(2);
    Z2(i)=pointvec2(3); 
    X3(i)=pointvec3(1);
    Y3(i)=pointvec3(2);
    Z3(i)=pointvec3(3); 
    X4(i)=pointvec4(1);
    Y4(i)=pointvec4(2);
    Z4(i)=pointvec4(3); 
end
if range<2
    x=[X1];
    y=[Y1];
    z=[Z1];
elseif range<3
    x=[X1,X2];
    y=[Y1,Y2];
    z=[Z1,Z2];
elseif range<4
    x=[X1,X2,X3];
    y=[Y1,Y2,Y3];
    z=[Z1,Z2,Z3];
else
    x=[X1,X2,X3,X4];
    y=[Y1,Y2,Y3,Y4];
    z=[Z1,Z2,Z3,Z4];
end
end