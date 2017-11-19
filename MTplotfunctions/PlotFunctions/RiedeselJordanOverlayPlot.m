function [Xmax,Ymax,Zmax]=RiedeselJordanOverlayPlot(MT,h,options,wave)
set(0, 'currentfigure', h)
MT=MTcheck(MT);
hold on;
[x,y,z,c,~]=xyzc(MT,options,wave);
[X,Y,~]=options.ProjFn(x,y,z,options);
contour(50*X,50*Y,c);
colormap(options.Colormap);
maxc=max([abs(max(max(c))),abs(min(min(c)))]);
caxis([-maxc maxc]);
hold off;
% Plot RJ info
[Xmax,Ymax,Zmax]=RiedeselJordanPlot(MT,h,options);
if options.FaultPlane
    FocalPlanePlot(MT,h,options);
end
end
