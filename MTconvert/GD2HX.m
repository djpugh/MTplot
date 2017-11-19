function [h,f]=GD2HF(g,d,b)
if nargin<3
    b=5.75;
end
h=0.5*sin(3*g)+0.5;
f=betacdf((d+pi/2)/pi,b,b);
end