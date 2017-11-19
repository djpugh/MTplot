function MT=MTcheck(mt,check_cell)
% function MT=MTcheck(MT)   
%
% Code Written By David Pugh, Bullard Labs University of Cambridge and
%   Schlumberger Cambridge Research
%
% Inputs are either the full Moment Tensor (3x3 Matrix) or the symmetric
% moment tensor elements as [Mxx Myy Mzz sqrt(2)*Mxy sqrt(2)*Mxz sqrt(2)*Myz] or the strike dip and
% rake in degrees.
%
% Returns the full moment tensor (3x3 matrix)
%
%
%   Follows Aki and Richards p 112 Coordinate System X=N Y=E Z=Down
%
%
%If file
if nargin<2
    check_cell=true;
end
if ischar(mt)&&exist(mt,'file')==2
    mt=load(mt,'Events');
    mt=mt.Events;
end
if isstruct(mt)&&any(strcmpi('MTSpace',fieldnames(mt)))
    MT=mt;
    return
elseif isstruct(mt)&&any(strcmpi('MTSpace1',fieldnames(mt)))
    fns=fieldnames(mt);
    X=zeros(size(fns));
    Y={};
    for i=1:numel(fns)
        if strfind(fns{i},'MTSpace')
        	X(i)=str2double(strrep(fns{i},'MTSpace',''));
            Y{i}=strrep(fns{i},'MTSpace','');
        else
            X(i)=-1;
            Y{i}='';
        end
    end
    endings=sort(Y(X>=0));
    MT={};
    for i=1:numel(endings)
        MT{i}=struct();
    end
    for i=1:numel(fns)
        if any(strcmpi(fns{i}(end),endings))
            ind=strcmpi(fns{i}(end),endings);
            if fns{i}(end-1)=='_'
                fn=strrep(fns{i},['_',endings{ind}],'_');
            else
                fn=fns{i}(1:end-1);
            end
            MT{ind}.(fn)=mt.(fns{i});
        else
            for j=1:numel(endings)
            MT{j}.(fns{i})=mt.(fns{i});
            end
        end
    end
    return
end
if ~iscell(mt)
    try
        if all(size(mt)==[6,1] )|| all(size(mt)==[3,1])
            mt=mt';
        end
    catch ME
        if strcmpi(ME.message,'Not enough input arguments.')
            help MTcheck
        end
        ME.rethrow()
    end
    if size(mt,1)==6&&size(mt,2)>1
        mt=mat2cell(mt,6,ones(1,size(mt,2)));
    end
end
if check_cell&&iscell(mt)
    MT={};
    for i=1:size(mt,1)
        for j=1:size(mt,2)
            if numel(mt{i,j})
                MT{i,j}=MTcheck(mt{i,j});
            else
                MT{i,j}=[];
            end
        end
    end
    return
elseif iscell(mt)
    MT=mt;
    return
end
if size(mt)==[1,6]
    MT=[mt(1),(1/sqrt(2))*mt(4),(1/sqrt(2))*mt(5);(1/sqrt(2))*mt(4),mt(2),(1/sqrt(2))*mt(6);(1/sqrt(2))*mt(5),(1/sqrt(2))*mt(6),mt(3)];
%if it is: [strike,dip,rake] convert to double couple
elseif size(mt)==[1,3]
    strike=mt(1);
    dip=mt(2);
    rake=mt(3);
    MT=SDR2MT(strike,dip,rake);
elseif size(mt)==[3,3]
    err=10^-14;
    if prod(double(all((mt-mt')<err))) 
        MT=triu(mt)+triu(mt,1)';
    else
        error('visualisations:Inputcheckfail',['Moment tensor not symmetrical within error bounds of ',mat2str(err)]);
    end
elseif size(mt)==[1,4]
    MT=SDSD2MT(mt(1),mt(2),mt(3),mt(4));
else
    error('visualisations:Inputcheckfail','Moment tensor not recognised needs to be [Mxx,Myy,Mzz,Mxy,Mxz,Myz], [strike,dip,rake] or [Mxx,Mxy,Mxz;Myx,Myy,Myz;,Mzx,Mzy,Mzz]');
end
end