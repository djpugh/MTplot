function Ev=combineEvents(Event1,Event2)
    fns1=fieldnames(Event1);
    fns2=fieldnames(Event2);
    if ~any(strcmpi('ln_pdf',fns1))||~any(strcmpi('ln_pdf',fns2))
        error('Requires ln_pdf in both Events')
    end
    Ev=Event1;
    for i=1:numel(fns2)
        if any(strcmpi(fns2{i},fns1))        
            if ~any(strcmpi(fns2{i},{'dV','NSamples','UID','bayesian_evidence','acc_rate','accepted'}))
                Ev.(fns2{i})=[Ev.(fns2{i}),Event2.(fns2{i})];
            elseif any(strcmpi(fns2{i},{'NSamples','accepted'}))
                Ev.(fns2{i})=Ev.(fns2{i})+Event2.(fns2{i});
            end
        else
            Ev.(fns2{i})=Event2.(fns2{i});
        end
    end
    Ev.Probability=exp(Ev.ln_pdf-max(Ev.ln_pdf));
end