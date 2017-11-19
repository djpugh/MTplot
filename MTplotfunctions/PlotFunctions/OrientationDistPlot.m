function OrientationDistPlot(MT,h,options)
set(0, 'currentfigure', h)
options.FigureHandle=h;
p=panel();
p.pack(1,3);
MT=MTcheck(MT);
[s1,d1,r1]=MT2SDR(MT);
n=5;
sBins=[0:n:361];
rBins=[-180:n:180];
dBins=[0:0.02:1.01];
[S]=probhistc(s1,sBins,options.Probability,options.Marginalised,options.Logarithm,options.Normalise); 
[D]=probhistc(cosd(d1),dBins,options.Probability,options.Marginalised,options.Logarithm,options.Normalise); 
[R]=probhistc(r1,rBins,options.Probability,options.Marginalised,options.Logarithm,options.Normalise); 
p(1,1).select()
plot(sBins,S);
xlim([0,360])
xlabel('Strike (Degrees)')
axis square
p(1,2).select();
plot(dBins,D);
xlim([0,1])
xlabel('cos(Dip)')
axis square
p(1,3).select();
plot(rBins,R);
xlim([-180,180])
xlabel('Rake (Degrees)')
axis square