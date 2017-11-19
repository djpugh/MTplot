function[T,N,P]=FP2TNP(N1,N2)
% Converts fault plane normals to the T, N, P axes
%
% Inputs are the two fault plane normals
%
% Returns the T, N, P axes
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
T=((N1+N2)/norm(N1+N2));
P=((N1-N2)/norm(N1-N2));
N=(-cross(T,P));