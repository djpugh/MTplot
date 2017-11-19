function perc_dc=MT2perc_dc(MT)
if iscell(MT)
    for i=1:numel(MT)
        perc_dc{i}=MT2perc_dc( MT{i});
    end
    perc_dc=reshape(perc_dc,size(MT,1),size(MT,2));
    return
elseif isstruct(MT)
    if any(strcmpi(fieldnames(MT),'perc_dc'))
        perc_dc=MT.perc_dc;
        return
    elseif any(strcmpi(fieldnames(MT),'E'))
        perc_dc=E2perc_dc(MT.E);
        return
    elseif any(strcmpi(fieldnames(MT),'g'))&&any(strcmpi(fieldnames(MT),'d'))
        perc_dc=E2perc_dc(GD2E(MT.g,MT.d));
        return
    else
        MT=MT.MTSpace;
    end
end
    [~,~,~,E]=MT2TNPE(MT);
    perc_dc=E2perc_dc(E);

end