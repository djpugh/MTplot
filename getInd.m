function Ev=getInd(Events,ind)
    fns=fieldnames(Events);
    for i=1:numel(fns)
        if ~any(strcmpi(fns{i},{'dV','MTSpace','NSamples','UID','bayesian_evidence','ln_bayesian_evidence','acc_rate','accepted','pDC'}))
            Ev.(fns{i})=Events.(fns{i})(ind);
        elseif any(strcmpi(fns{i},{'MTSpace'}))
            Ev.(fns{i})=Events.(fns{i})(:,ind);
        else
            Ev.(fns{i})=Events.(fns{i});
        end
            
    
    end
end