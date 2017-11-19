function [gamma,delta]=E2GD(E)
%Convert Eigenvalues to Gamma and Delta from Tape and Tape GJI 2012
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
if ~iscell(E)
gamma=atan2(-E(:,1)+2*E(:,2)-E(:,3),sqrt(3)*(E(:,1)-E(:,3)));
beta=acos(sum(E,2)./(sqrt(3)*sqrt(sum(E.^2,2))));
delta=real(pi/2-beta);
else
    gamma=num2cell(zeros(size(E)));%,1,ones(1,numel(E)));
    delta=num2cell(zeros(size(E)));%,1,ones(1,numel(E)));
    for i=1:numel(E)
        [gi,di]=E2GD(E{i});
        if iscell(gi)
            gamma(i)=gi;
            delta(i)=di;
        else
            gamma{i}=gi;
            delta{i}=di;
        end
    end
    if ~all(cellfun(@iscell,MT))
        G=cell2mat(G);
        D=cell2mat(D);
    end
end