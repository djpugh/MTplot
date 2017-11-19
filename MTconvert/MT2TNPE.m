function [T,N,P,E]=MT2TNPE(MT)
% Converts a moment tensor to the T, N, P axes and the eigenvalues
%
% Input is the full Moment Tensor (3x3 matrix)
%
% Returns the T, N, P eigen vectors and the eigenvalues in E as (v1,v2,v3)
%
if isstruct(MT)
    if any(strcmpi('T',fieldnames(MT)))&&any(strcmpi('N',fieldnames(MT)))&&any(strcmpi('P',fieldnames(MT)))&&any(strcmpi('E',fieldnames(MT)))
        T=MT.T;
        N=MT.N;
        P=MT.P;
        E=MT.E;
        return
    elseif any(strcmpi('MTSpace',fieldnames(MT)))
        MT=MTcheck(MT.MTSpace);
    else
        error('MTplot:struct','structure does not have correct fieldnames, either MTSpace or T,N,P,E required')
    end
end 
MT=MTcheck(MT);

if size(MT)==[3,3]
    % Order diagonalised matrix algebraically from largest to smallest, 
    % i.e.
    %   v1>=v2>=v3
    if MT==diag(diag(MT))
        E=diag(MT);
        [E,ind]=sort(E,'descend');
        TNP=[1,0,0;0,1,0;0,0,1];
        T=TNP(:,ind(1));
        N=TNP(:,ind(2));
        P=TNP(:,ind(3));
        E=E';
    else 
        try
            [TNP,vals]=eigs(MT,3,'la');
        catch
            [TNP,vals]=eigs(MT,3,'la');
        end
        T=TNP(:,1);
        N=TNP(:,2);
        P=TNP(:,3);
        E=[vals(1,1),vals(2,2),vals(3,3)];
    end
    % Correct P to be pointing downwards so that the normals are oriented
    % correctly
    if P(3)<0
        P=-P;
    end
elseif iscell(MT)
    T=mat2cell(zeros(3,length(MT)),3,ones(1,length(MT)));
    N=mat2cell(zeros(3,length(MT)),3,ones(1,length(MT)));
    P=mat2cell(zeros(3,length(MT)),3,ones(1,length(MT)));
    E=mat2cell(zeros(length(MT),3),ones(1,length(MT)),3);
    for i=1:length(MT)
        [Ti,Ni,Pi,Ei]=MT2TNPE(MT{i});
        if iscell(Ti)
            T(:,i)=Ti;
            N(:,i)=Ni;
            P(:,i)=Pi;
            E(i,:)=Ei;
        else
            T{:,i}=Ti;
            N{:,i}=Ni;
            P{:,i}=Pi;
            E{i,:}=Ei;
        end
            
    end
    if ~all(cellfun(@iscell,MT))
        T=cell2mat(T);
        N=cell2mat(N);
        P=cell2mat(P);
        E=cell2mat(E);
    end
else
    error('visualisations:Inputcheckfail','Incorrect inputs');
end