function [u,v]=uvProj(MT)
%Carry out transformation from tau,k to U,V according to hudson et al. 1989
%JGR (v. 94 p765-774)
if isstruct(MT)
    if any(strcmpi('u',fieldnames(MT)))&&any(strcmpi('v',fieldnames(MT)))
        u=MT.u;
        v=MT.v;
        return
    elseif any(strcmpi('MTSpace',fieldnames(MT)))
        MT=MT.MTSpace;
    else
        error('MTplot:struct','structure does not have correct fieldnames, either MTSpace or u,v required')
    end
end 
MT=MTcheck(MT);
if ~iscell(MT)
    [tau,k]=taukProj(MT);
    if tau>0 && k>0
        if tau<4*k
            u=tau/(1-(tau/2));
            v=k/(1-(tau/2));
        else
            u=tau/(1-2*k);
            v=k/(1-2*k);
        end
    elseif tau<0 && k<0
        if tau>4*k
            u=tau/(1+(tau/2));
            v=k/(1+(tau/2));
        else
            u=tau/(1+2*k);
            v=k/(1+2*k);
        end
    else
        u=tau;
        v=k;
    end    
else
    u=num2cell(zeros(size(MT)));
    v=num2cell(zeros(size(MT)));
    for i=1:numel(MT)
        [ui,vi]=uvProj(MT{i});
        u{:,i}=ui;
        v{:,i}=vi;
    end
    if ~all(cellfun(@iscell,MT))
        u=cell2mat(u);
        v=cell2mat(v);
    end
end
end