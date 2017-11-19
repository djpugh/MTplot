function E=GD2E(gamma,delta)
%Convert Gamma and Delta (Tape and Tape GJI 2012) to Eigenvalues
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
U=(1/sqrt(6))*[sqrt(3),0,-sqrt(3);-1,2,-1;sqrt(2),sqrt(2),sqrt(2)];
old=size(gamma);
gamma=reshape(gamma,numel(gamma),1);
delta=reshape(delta,numel(delta),1);
X=[cos(gamma').*sin(((pi/2)-delta)');sin(gamma').*sin(((pi/2)-delta)');cos(((pi/2)-delta)')];
E=(U'*X)';