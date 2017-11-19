function Ev=premarginalise(Events,mode,resolution,marginalise,projection)
if nargin<5
        projection='u-v';
end
if strcmpi(projection,'tau-k')
    options.ProjFn=@taukProj;
else
    options.ProjFn=@uvProj;
end
if nargin<4 
    marginalise=true;
end
options.Marginalised=marginalise;
options.PreMarginalise=true;
options.Projection=projection;
options.Resolution=resolution;
options.Normalise=false;
options.Logarithm=false;
options.MaxSource=false;
options.Contour=false;
options.Probability=Events.Probability;
if max(Events.Probability)==0
    options.Probability=exp(Events.ln_pdf-max(Events.ln_pdf));
end
if strcmpi(mode,'lune')
lune_args=LunePlot(Events,0,options);
delta_range=pi/2-acos(lune_args{3}+mean(diff(lune_args{3}(1,:)))/2);
gamma_range=atan2(lune_args{2},lune_args{1});
gamma_range(:,end)=gamma_range(:,1);
gamma_range=gamma_range+mean(diff(gamma_range(:,1)))/2;
prob=lune_args{4};
Ev.g=reshape(gamma_range(prob>0),1,numel(gamma_range(prob>0)));
Ev.d=reshape(delta_range(prob>0),1,numel(delta_range(prob>0)));
Ev.Probability=reshape(prob(prob>0),1,numel(prob(prob>0)));
else
hudson_args=HudsonPlot(Events,0,options);
u_range=hudson_args{1};
v_range=hudson_args{2};
[v_range,u_range]=ndgrid(v_range,u_range);
prob=hudson_args{3};
Ev.u=reshape(u_range(prob>0),1,numel(u_range(prob>0)));
Ev.v=reshape(v_range(prob>0),1,numel(v_range(prob>0)));
Ev.Probability=reshape(prob(prob>0),1,numel(prob(prob>0)));
end
Ev.MTSpace='marginalised';
end