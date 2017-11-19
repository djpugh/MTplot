function [Xmax,Ymax,Zmax]=DCPDFPlot(MT,h,options,~)
set(0, 'currentfigure', h)
options.FigureHandle=h;
p=panel();
p.pack(1,3);
[s1,d1,r1]=MT2SDR(MT);
n=5;
sBins=[0:n:361];
rBins=[-180:n:180];
dBins=[0:0.02:1.01];
[~,sIndices]=histc(s1,sBins);
[~,dIndices]=histc(cosd(d1),dBins);
[~,rIndices]=histc(r1,rBins);
S=accumarray(sIndices',options.Probability,[length(sBins),1]);
p(1,1).select()
plot(sBins,S);
xlim([0,360])
xlabel('Strike (Degrees)')
axis square
D=accumarray(dIndices',options.Probability,[length(dBins),1]);
p(1,2).select();
plot(dBins,D);
xlim([0,1])
xlabel('cos(Dip)')
axis square
R=accumarray(rIndices',options.Probability,[length(rBins),1]);
p(1,3).select();
plot(rBins,R);
xlim([-180,180])
xlabel('Rake (Degrees)')
axis square
Xmax=1;
Ymax=1;
Zmax=1;