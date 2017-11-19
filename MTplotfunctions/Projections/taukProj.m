function [tau,k]=taukProj(MT)
if isstruct(MT)
    if any(strcmpi('tau',fieldnames(MT)))&&any(strcmpi('k',fieldnames(MT)))
        tau=MT.tau;
        k=MT.k;
        return
    elseif any(strcmpi('MTSpace',fieldnames(MT)))
        MT=MTcheck(MT.MTSpace);
    else
        error('MTplot:struct','structure does not have correct fieldnames, either MTSpace or u,v required')
    end
end 
if ~iscell(MT)
    M=eigs(MT,3,'la');
    %Silly ordering from hudson paper
    M=[M(1),M(3),M(2)];
    M_Iso=sum(M)/3;
    M_Dev=(M-M_Iso);
    if M_Dev(3)>0
        k=M_Iso/(abs(M_Iso)-M_Dev(2));
        T=-2*M_Dev(3)/M_Dev(2);
    elseif M_Dev(3)<0
        k=M_Iso/(abs(M_Iso)+M_Dev(1));
        T=2*M_Dev(3)/M_Dev(1);
    else
        k=M_Iso/(abs(M_Iso)+M_Dev(1));
        T=0;
    end
    tau=T*(1-abs(k));
else
    tau=num2cell(zeros(size(MT)));
    k=num2cell(zeros(size(MT)));
    for i=1:numel(MT)
        [ti,ki]=taukProj(MT{i});
        tau{:,i}=ti;
        k{:,i}=ki;
    end
    if ~all(cellfun(@iscell,MT))
        tau=cell2mat(tau);
        k=cell2mat(k);
    end

end
end