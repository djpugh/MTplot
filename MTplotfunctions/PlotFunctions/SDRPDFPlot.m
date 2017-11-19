function [Xmax,Ymax,Zmax]=SDRPDFPlot(MT,h,options,~)

MT=MTcheck(MT);
if ~strcmp(char(class(MT)),'cell')
    MT={MT};
end
try
    N=options.Resolution;
catch
    N=100;
end
%set up theta values
dh=1/(N-1);
%set up phi values
dp=2*pi/(N-1);
dr=pi/(N-1);
[~,~,s,r,H]=MT2Tape(MT);
%tic,[X,Y]=cellfun(@options.ProjFn,MT);toc
srange=0:dp:2*pi;
hrange=0:dh:1;
rrange=-pi/2:dr:pi/2;
s=mod(s,2*pi);
n=probhistc3d(s,H,r,srange,hrange,rrange,options.Probability,options.Marginalised,options.Normalise);
%S is the first index, h the second and r the third
Xmax=1;
Ymax=1;
Zmax=1;
Marginalised=true;
if strcmpi(options.Mode,'sdrsilhouette')
    Marginalised=false;
end
set(0, 'currentfigure', h);
if options.PanelMode
    p=panel.recover();
    p=p(options.PanelIndex(1),options.PanelIndex(2));
    p.pack(1,3);
else
    p=panel('no-manage-font');
    p.pack(1,3);
end
p(1,1).select()
if Marginalised
Z=sum(n,3);
else
Z=max(n,[],3);
end
if options.Normalise &&Marginalised
    Z=Z/sum(Z*mean(diff(srange))*mean(diff(hrange)));
end
if options.Logarithm
    Z=log(Z);
end
if options.Interp
surf(srange,hrange,0*Z,Z,'EdgeColor','none','FaceColor','interp');
else
surf(srange,hrange,0*Z,Z,'EdgeColor','none');%,'FaceColor','interp');
end
xlim([0,2*pi])
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi])
set(gca,'XTickLabel',{'0','p/2','p','3p/2','2p'}','fontname','symbol','FontSize',options.FontSize)
set(gca,'YTick',[0,0.5,1])
view(0,90)
colormap(jet);
xlabel('Strike (radians)','fontname','helvetica','FontSize',options.FontSize)
ylabel('cos(dip)','fontname','helvetica','FontSize',options.FontSize)
freezeColors;

p(1,2).select()
if Marginalised
Z=squeeze(sum(n,2));
else
Z=squeeze(max(n,[],2));
end

if options.Normalise &&Marginalised
    Z=Z/sum(Z*mean(diff(srange))*mean(diff(rrange)));
end
if options.Logarithm
    Z=log(Z);
end
if options.Interp
surf(srange,rrange,0*Z,Z,'EdgeColor','none','FaceColor','interp');
else
surf(srange,rrange,0*Z,Z,'EdgeColor','none');%,'FaceColor','interp');
end
xlim([0,2*pi])
ylim([-pi/2,pi/2])
view(0,90)
colormap(jet);
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],...
        'XTickLabel',{'0','p/2','p','3p/2','2p'}',...
        'YTick',[-pi/2,-pi/4,0,pi/4,pi/2],...
        'YTickLabel',{'-p/2','-p/4','0','p/4','p/2'},...
        'fontname','symbol',...
        'FontSize',options.FontSize)
xlabel('Strike (radians)','fontname','helvetica','FontSize',options.FontSize)
ylabel('Slip (radians)','fontname','helvetica','FontSize',options.FontSize)
freezeColors;
p(1,3).select()
if Marginalised
Z=squeeze(sum(n,1));
else
Z=squeeze(max(n,[],1));
end
if options.Normalise &&Marginalised
    Z=Z/sum(Z*mean(diff(hrange))*mean(diff(rrange)));
end
if options.Logarithm
    Z=log(Z);
end
if options.Interp
surf(hrange,rrange,0*Z,Z,'EdgeColor','none','FaceColor','interp');
else
surf(hrange,rrange,0*Z,Z,'EdgeColor','none');%,'FaceColor','interp');
end
view(0,90)
colormap(jet);
xlabel('cos(dip)','fontname','helvetica','FontSize',options.FontSize)
ylabel('Slip (radians)','fontname','helvetica','FontSize',options.FontSize)
set(gca,'XTick',[0,0.5,1])
set(gca,'YTick',[-pi/2,-pi/4,0,pi/4,pi/2])
set(gca,'YTickLabel',{'-p/2','-p/4','0','p/4','p/2'}','fontname','symbol','FontSize',options.FontSize)
ylim([-pi/2,pi/2])
freezeColors;
hold off
p.marginright = 30;
p.de.margin =20;
end