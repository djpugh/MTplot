function [N1,N2]=TP2FP(T,P)
% Calculate the normals to the fault and auxiliary planes from the T and P axes.
%
% Inputs are the T and P axes
%
if iscell(T)
    N1=mat2cell(zeros(3,length(T)),3,ones(1,length(T)));
    N2=mat2cell(zeros(3,length(T)),3,ones(1,length(T)));
    for i=1:length(T)
        [N1i,N2i]=TP2FP(T{i},P{i});
        N1{:,i}=N1i;
        N2{:,i}=N2i;
    end
    if ~all(cellfun(@iscell,T))
        N1=cell2mat(N1);
        N2=cell2mat(N2);
    end
else    
    N1=(T+P)./kron(sqrt(sum((T+P).^2)),ones(3,1));
    N2=(T-P)./kron(sqrt(sum((T-P).^2)),ones(3,1));
end
end