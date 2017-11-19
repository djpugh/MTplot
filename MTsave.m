function MTsave(filename,type)
files={};
fprintf('\nRunning MTsave for type: %s\n\n',type)
path='';
if ~iscell(filename)    
    [path,name,~]=fileparts(filename);
    filename='';
    if numel(path)
        filename=[path,filesep];
    end
    filename=[filename,name,'.mat'];
    if numel(strfind(filename,'*'))
    files=struct2cell(dir(filename));
    files=files(1,:)';  
    end
else
    files=filename;
end
if numel(files)
    for i=1:numel(files)
        if numel(path)
            fname=[path,filesep,files{i}];
        else
            fname=files{i};
        end
        MTsave(fname,type);
    end
    fprintf('\n')
else
    fprintf('\n%s',filename)
% valid_types={'uv','tk','lune','source','tnp','sdr','tape'};
type=strrep(type,'-','');
type=strrep(type,' ','');
type=lower(type);
load(filename)
MT=Events.MTSpace;
do_save=true;
if strcmpi(type,'uv')&&( ~any(strcmpi('u',fieldnames(Events)))||~any(strcmpi('v',fieldnames(Events))))
    MT=MTcheck(MT);
    [u,v]=uvProj(MT);
    Events.u=u;
    Events.v=v;    
    clear u v;
elseif strcmpi(type,'tk')&&( ~any(strcmpi('t',fieldnames(Events)))||~any(strcmpi('k',fieldnames(Events))))
    MT=MTcheck(MT);
    [t,k]=taukProj(MT);
    Events.tau=t;
    Events.k=k;
    clear t k
elseif strcmpi(type,'lune')&&( ~any(strcmpi('g',fieldnames(Events)))||~any(strcmpi('d',fieldnames(Events))))
    MT=MTcheck(MT);
    [~,~,~,E]=MT2TNPE(MT);
    [g,d]=E2GD(E);
    Events.g=g;
    Events.d=d;
    clear g d
elseif strcmpi(type,'sdr')&&( ~any(strcmpi('S1',fieldnames(Events)))||~any(strcmpi('D1',fieldnames(Events)))||~any(strcmpi('R1',fieldnames(Events)))||~any(strcmpi('S2',fieldnames(Events)))||~any(strcmpi('D2',fieldnames(Events)))||~any(strcmpi('R2',fieldnames(Events))))
    MT=MTcheck(MT);
    [S1,D1,R1,S2,D2,R2]=MT2SDR(MT);
    Events.S1=S1;
    Events.D1=D1;
    Events.R1=R1;
    Events.S2=S2;
    Events.D2=D2;
    Events.R2=R2;
    clear S1 D1 R1 S2 D2 R2
elseif  strcmpi(type,'tnp')&&( ~any(strcmpi('T',fieldnames(Events)))||~any(strcmpi('N',fieldnames(Events)))||~any(strcmpi('P',fieldnames(Events)))||~any(strcmpi('E',fieldnames(Events))))
    MT=MTcheck(MT);
    [T,N,P,E]=MT2TNPE(MT);
    Events.T=T;
    Events.N=N;
    Events.P=P;
    Events.E=E;    
    clear T N P E
elseif  strcmpi(type,'tape')&&( ~any(strcmpi('g',fieldnames(Events)))||~any(strcmpi('d',fieldnames(Events)))||~any(strcmpi('k',fieldnames(Events)))||~any(strcmpi('s',fieldnames(Events)))||~any(strcmpi('h',fieldnames(Events))))
    MT=MTcheck(MT);
    [gamma,delta,kappa,sigma,h]=MT2Tape(MT);
    Events.g=gamma;
    Events.d=delta;
    Events.k=kappa;
    Events.s=sigma;
    Events.h=h;
    clear gamma delta kappa sigma h
elseif strcmpi(type,'hx')&&( ~any(strcmpi('H',fieldnames(Events)))||~any(strcmpi('x',fieldnames(Events))))
    MT=MTcheck(MT);
    [H,x]=MT2HX(MT);
    Events.H=H;
    Events.x=x;    
    clear H x;
else
    do_save=false;
end
if do_save
    try
    save(filename,'Events','Other','Stations','-v7.3')
    catch
    vars=who('-file',filename);
    save(filename,vars{:},'-v7.3')
    end
end
    fprintf('\n\nDone\n')
end
 