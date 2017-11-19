function [EvArr,Probability]=split_joint_pdf(Events,mcmc)
if nargin<2
    mcmc=false;
end
fns=fieldnames(Events);
EvArr={};
Probability={};
All={};
for i=1:numel(fns);
    fns{i};
    num_ind=strfind(fns{i},'_');
    MTSpace_num_ind=strfind(fns{i},'MTSpace');
    if numel(num_ind)          
        num_ind=num_ind(end)+1;
        try
            ind=str2num(fns{i}(num_ind:end));
            EvArr{ind}.(fns{i}(1:num_ind-2))=Events.(fns{i});
        catch
        end
    elseif numel(MTSpace_num_ind)          
        MTSpace_num_ind=MTSpace_num_ind(end)+7;
        try
            ind=str2num(fns{i}(MTSpace_num_ind:end));
            EvArr{ind}.MTSpace=Events.(fns{i});
        catch
        end
    else
        All{end+1}=fns{i};        
    end
end
for j=1:numel(EvArr);
    for i=1:numel(All)
        EvArr{j}.(All{i})=Events.(All{i});
    end
    if mcmc
    Probability{j}=ones(size(EvArr{j}.Probability));
    else
    Probability{j}=EvArr{j}.Probability;
    end
end
end