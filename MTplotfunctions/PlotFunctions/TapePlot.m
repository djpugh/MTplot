function TapePlot(MT,h,options)
set(0, 'currentfigure', h);
if ~strcmp(char(class(MT)),'cell')
    MT={MT};
end
MT=MTcheck(MT);
N=size(MT,2);  
[gamma,delta,kappa,sigma,cosdip]=MT2Tape(MT);

n=100;
if options.PanelMode
    p=panel.recover();
    p=p(options.PanelIndex(1),options.PanelIndex(2));
    p.pack(2,1);
else
    p=panel('no-manage-font');
    p.pack(2,1);
end
%Gamma
    p(1,1).pack(1,2)
    p(2,1).pack(1,3)
    p(1,1,1,1).select()
    x=[-pi/6:pi/(3*n):pi/6];
    [gn,N]=probhistc(gamma,x,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
    bar(x+pi/(6*n),gn,1);
    flatGamma=N/n;
    X=-pi/6:0.01:pi/6;
    Y=X./X;
    hold on;
    if options.AxisLines
%         plot(X,flatGamma*Y,'g','linewidth',options.LineWidth)
        plot(X,pi/2*flatGamma*cos(3*X),'r','linewidth',options.LineWidth)
    end
    %Calculated scale factor: Total Area=(pi/3)*Nsamples/nhist,
    %normalisation constant for cos(3x) between +/-pi/6 is  3/2 therefore
    %the scale term is pi/2*Nsamples/nhist
    xlim([-pi/6,pi/6])
    yl=ylim();
    ylim(yl);
    ymax=yl(2);
    text(-0.95*pi/6,0.95*ymax,'\gamma','fontsize',options.FontSize,'linewidth',options.LineWidth)
    set(gca,'XTick',[-pi/6,-pi/12,0,pi/12,pi/6])
    set(gca,'XTickLabel',{'-p/6','-p/12','0','p/12','p/6'}','fontname','symbol')
    set(gca,'YTickLabel','')
    set(gca,'YTick',[])
    box on
    hold off
%Delta
    p(1,1,1,2).select()
    x=[-pi/2:pi/n:pi/2];
    
    [dn,N]=probhistc(delta,x,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
    bar(x+pi/(2*n),dn,1);
    flatDelta=N/n;
    X=-pi/2:0.01:pi/2;
    Y=X./X;
    hold on;
    if options.AxisLines
%         plot(X,flatDelta*Y,'g')
        %plot(X,2.8*flatDelta*normpdf(X,0,0.443)/(normcdf(pi/2,0,0.443)-normcdf(-pi/2,0,0.443)),'c')
        b=5.7479; %Calculated empirically from 20000000 random MTs
        plot(X,1*flatDelta*betapdf((X+pi/2)/pi,b,b),'r','linewidth',options.LineWidth)
        %Calculated scale factor: Total Area=(pi)*Nsamples/nhist,
        %normalisation constant for beta((x+pi/2)/pi) between +/-pi/2 is  1/pi therefore
        %the scale term is Nsamples/nhist
    end
    yl=ylim();
    ylim(yl);
    ymax=yl(2);
    text(-0.95*pi/2,0.95*ymax,'\delta','fontsize',options.FontSize,'linewidth',options.LineWidth)
    xlim([-pi/2,pi/2])
    set(gca,'XTick',[-pi/2,-pi/4,0,pi/4,pi/2])
    set(gca,'XTickLabel',{'-p/2','-p/4','0','p/4','p/2'}','fontname','symbol')
    set(gca,'YTickLabel','')
    set(gca,'YTick',[])
    box on
    hold off
w=1;
%Kappa
    p(2,1,1,1).select()
    x=[0:(2*pi)/n:2*pi];
    [kn,N]=probhistc(kappa,x,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
    bar(x+pi/(n),kn,w);
    uniformKappa=N/n;
    X=0:0.01:2*pi;
    Y=X./X;
    hold on;
    if options.AxisLines
        plot(X,uniformKappa*Y,'r','linewidth',options.LineWidth)
    end
    yl=ylim();
    xlim([0,2*pi]);
    ylim(yl);
    ymax=yl(2);
    text(0.05*pi,0.95*ymax,'\kappa','fontsize',options.FontSize,'linewidth',options.LineWidth)
    set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi])
    set(gca,'XTickLabel',{'0','p/2','p','3p/2','2p'}','fontname','symbol')
    set(gca,'YTickLabel','')
    set(gca,'YTick',[])
    box on
    hold off
%Cosdip (h)
    p(2,1,1,2).select()
    x=[0:1/n:1];
    [hn,N]=probhistc(cosdip,x,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
    bar(x+1/(2*n),hn,w);
    uniformh=N/n;
    X=0:0.01:1;
    Y=X./X;
    hold on;    
    if options.AxisLines
        plot(X,uniformh*Y,'r','linewidth',options.LineWidth)
    end
    xlim([0,1])
    yl=ylim();
    ylim(yl);
    ymax=yl(2);
    text(0.05,0.95*ymax,'h','fontsize',options.FontSize,'linewidth',options.LineWidth)
    set(gca,'YTickLabel','')
    set(gca,'YTick',[])
    box on
    hold off
%Sigma
    p(2,1,1,3).select()
    x=[-pi/2:(pi)/n:pi/2];
    [sn,N]=probhistc(sigma,x,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
    bar(x+pi/(2*n),sn,w);
    uniformSigma=N/n;
    X=-pi/2:0.01:pi/2;
    Y=X./X;
    hold on;    
    if options.AxisLines
        plot(X,uniformSigma*Y,'r','linewidth',options.LineWidth)
    end
    yl=ylim();
    yl=[0,1.2*max(yl)];
    ylim(yl);
    ymax=yl(2);
    text(-0.95*pi/2,0.95*ymax,'\sigma','fontsize',options.FontSize,'linewidth',options.LineWidth)
    xlim([-pi/2,pi/2])
    set(gca,'XTick',[-pi/2,-pi/4,0,pi/4,pi/2])
    set(gca,'XTickLabel',{'-p/2','-p/4','0','p/4','p/2'}','fontname','symbol')
     set(gca,'YTickLabel','')
    set(gca,'YTick',[])
    box on
    hold off
p.marginright = 15;
p.de.margin=10;
end
