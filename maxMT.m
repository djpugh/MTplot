function MT=maxMT(MTs,P)
if nargin==1
    Events=MTs;
    P=Events.Probability;
    if any(strcmpi('MTSpace',fieldnames(Events)))
        MTs=Events.MTSpace;
    else
        MT={};
        for i=1:numel(fieldnames(Events))
            MTInd=['MTSpace',mat2str(i)];
            if any(strcmpi(MTInd,fieldnames(Events)))
               MT{i}=maxMT(Events.(MTInd),P);
            end            
        end
        return;
    end
        
end
MT=MTs(:,P==max(P));
MT=unique(MT','rows')';
end