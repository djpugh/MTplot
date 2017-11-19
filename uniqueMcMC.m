function Ev=uniqueMcMC(Ev)
[~,ia,ic]=unique(Ev.MTSpace','rows','stable');
Ev=getInd(Ev,ia);
Ev.Probability=accumarray(ic(:),1);
end