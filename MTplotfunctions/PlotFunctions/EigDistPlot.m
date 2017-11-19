function EigDistPlot(MT,h,options)
set(0, 'currentfigure', h);
MT=MTcheck(MT);
[~,~,~,E]=MT2TNPE(MT);
n=min(max(size(MT,2)/2,100),options.Resolution);
range=linspace(-1,1,n);
d=diff(range(1:2));
E1=probhistc(E(:,1),range,options.Probability,options.Marginalised);
E2=probhistc(E(:,2),range,options.Probability,options.Marginalised);
E3=probhistc(E(:,3),range,options.Probability,options.Marginalised);
maxValue=max(max([E1,E2,E3]));
E1=E1./maxValue;
E2=E2./maxValue;
E3=E3./maxValue;
p=panel();
p.pack(1,3);
p(1,1).select()
bar(range+d/2,E1);
xlim([-1,1])
ylim([0,1.1]);
ymax=1.1;
text(-0.95,0.95*ymax,'\lambda_1','fontsize',options.FontSize,'linewidth',options.LineWidth)
set(gca,'YTick',[0])
ylabel({'Scaled';'Probability'});
box off;
p(1,2).select()
bar(range+d/2,E2);
xlim([-1,1])
ylim([0,1.1]);
ymax=1.1;
text(-0.95,0.95*ymax,'\lambda_2','fontsize',options.FontSize,'linewidth',options.LineWidth)
set(gca,'YTickLabel','')
box off;
p(1,3).select()
bar(range+d/2,E3);
xlim([-1,1])
ylim([0,1.1]);
ymax=1.1;
text(-0.95,0.95*ymax,'\lambda_3','fontsize',options.FontSize,'linewidth',options.LineWidth)
set(gca,'YTickLabel','')
box off;

end