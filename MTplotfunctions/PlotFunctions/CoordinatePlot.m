function CoordinatePlot(MT,h,options)
%Get coordinate

if any(strcmpi(options.Coordinate,{'u','U'}))
    options.Coordinate='u';
    convert_fn=@uvProj;
    convert_ind=1;
    xl=[-4/3,4/3];
elseif any(strcmpi(options.Coordinate,{'v','V'}))
    options.Coordinate='v';
    convert_fn=@uvProj;
    convert_ind=2;
    xl=[-1,1];
elseif any(strcmpi(options.Coordinate,{'g','G','gamma','Gamma'}))
    options.Coordinate='g';
    convert_fn=@MT2Tape;
    convert_ind=1;
    xl=[-pi/6,pi/6];
elseif any(strcmpi(options.Coordinate,{'d','delta','Delta'}))
    options.Coordinate='d';
    convert_fn=@MT2Tape;
    convert_ind=2;
    xl=[-pi/2,pi/2];
elseif any(strcmpi(options.Coordinate,{'k','kappa','K','Kappa'}))
    options.Coordinate='k';
    convert_fn=@MT2Tape;
    convert_ind=3;
    xl=[0,2*pi];
elseif any(strcmpi(options.Coordinate,{'h','H','cosdip','CosDip','Cosdip','cos(dip)','Cos(dip)','Cos(Dip)'}))
    options.Coordinate='h';
    convert_fn=@MT2Tape;
    convert_ind=3;
    xl=[0,1];
elseif any(strcmpi(options.Coordinate,{'s','sigma','Sigma'}))
    options.Coordinate='s';
    convert_fn=@MT2Tape;
    convert_ind=4;
    xl=[-pi/2,pi/2];
elseif any(strcmpi(options.Coordinate,{'strike','Strike','S','S1'}))
    options.Coordinate='S1';
    convert_fn=@MT2SDR;
    convert_ind=1;
    xl=[0,360];
elseif any(strcmpi(options.Coordinate,{'dip','Dip','D','D1'}))
    options.Coordinate='D1';
    convert_fn=@MT2SDR;
    convert_ind=2;
    xl=[0,90];
elseif any(strcmpi(options.Coordinate,{'rake','Rake','r','r1','R','R1'}))
    options.Coordinate='R1';
    convert_fn=@MT2SDR;
    convert_ind=3;
    xl=[0,360];
elseif any(strcmpi(options.Coordinate,{'coszeta','CosZeta','Coszeta','cosZeta','Z','z','C','c'}))
    options.Coordinate='coszeta';
    convert_fn=@MT2cosxi;
    convert_ind=1;
    xl=[0,1];
elseif any(strcmpi(options.Coordinate,{'perc_dc','percdc','%dc','PercDC','Percdc','Perc_DC','perc_DC','Perc_dc'}))
    options.Coordinate='perc_DC';
    convert_fn=@MT2perc_dc;
    convert_ind=1;
    xl=[0,100];
else
    error(['Coordinate ',options.Coordinate,' not recognised'])
end
% Get coordinate values
MT=MTcheck(MT);
if isstruct(MT)&&any(strcmpi(options.Coordinate,fieldnames(MT)));
    x=MT.(options.Coordinate);
elseif isstruct(MT)
    nOut=nargout(convert_fn);
    try
        [x{1:nOut}]=convert_fn(MT);
    catch
         [x{1:nOut}]=convert_fn(MT.MTSpace);
    end
    x=x{convert_ind};
else
    nOut=nargout(convert_fn);
    [x{1:nOut}]=convert_fn(MT);
    x=x{convert_ind};
end
xb=linspace(xl(1),xl(2),options.Resolution);
n=probhistc(x,xb,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
sum(xb*n*mean(diff(xb)))./sum(n*mean(diff(xb)))
bar(xb,n);
xlabel(options.Coordinate)
if strcmpi(options.Coordinate,'perc_DC')
    xlabel('%dc');
end
if strcmpi(options.Coordinate,'coszeta')
    xlabel('cos\zeta');
end
if strcmpi(options.Coordinate,'g')
    xlabel('\gamma');
end
if strcmpi(options.Coordinate,'d')
    xlabel('\delta');
end
if strcmpi(options.Coordinate,'k')
    xlabel('\kappa');
end
if strcmpi(options.Coordinate,'s')
    xlabel('\sigma');
end
xlim(xl)
ylim([0,1.2*max(n)]);
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.02,0.25])
end

    
