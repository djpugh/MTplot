function cosxi=MT2cosxi(MT)
if iscell(MT)
    for i=1:numel(MT)
        cosxi{i}=MT2cosxi( MT{i});
    end
    cosxi=reshape(cosxi,size(MT,1),size(MT,2));
    return

elseif isstruct(MT)
    if any(strcmpi(fieldnames(MT),'cos_xi'))
        cosxi=MT.cos_xi;
        return
    elseif any(strcmpi(fieldnames(MT),'E'))
        cosxi=E2cosxi(MT.E);
        return
    elseif any(strcmpi(fieldnames(MT),'g'))&&any(strcmpi(fieldnames(MT),'d'))
        cosxi=E2cosxi(GD2E(MT.g,MT.d));
        return
    else
        MT=MT.MTSpace;
    end
end
    [~,~,~,E]=MT2TNPE(MT);
    cosxi=E2cosxi(E);
end