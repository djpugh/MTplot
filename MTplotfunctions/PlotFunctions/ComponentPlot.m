function [n1,n2,n3]=ComponentPlot(MT,h,options,~)
if ~strcmp(char(class(MT)),'cell')
    MT={MT};
end
MT=MTcheck(MT);
N=size(MT,2);
[XX,YY,ZZ,XY,XZ,YZ]=getComponents(MT);
n=min(max(size(MT,2)/2,100),options.Resolution);
range=linspace(-1,1,n);
xx=probhistc(XX,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
yy=probhistc(YY,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
zz=probhistc(ZZ,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
xy=probhistc(sqrt(2)*XY,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
xz=probhistc(sqrt(2)*XZ,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise);
yz=probhistc(sqrt(2)*YZ,range,options.Probability,options.Marginalised,options.Logarithm,options.Normalise); 
if ~options.Normalise
xx=xx./max(xx);
yy=yy./max(yy);
zz=zz./max(zz);
xy=xy./max(xy);
xz=xz./max(xz);
yz=yz./max(yz);
end
set(0, 'currentfigure', h);
title('Component Probability Plot');
hold on;
axis off;
p=panel();
p.pack(6,1);
p(1,1).select();
bar(range,xx);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'M_x_x','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
set(gca,'XTickLabel',{})
box off;
p(2,1).select();
bar(range,yy);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'M_y_y','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
set(gca,'XTickLabel',{})
box off;
p(3,1).select();
bar(range,zz);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'M_z_z','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
set(gca,'XTickLabel',{})
box off;
p(4,1).select();
bar(range,xy);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'$$\sqrt(2)M_{xy}$$','Interpreter','latex','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
set(gca,'XTickLabel',{})
box off;
p(5,1).select();
bar(range,xz);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'$$\sqrt(2)M_{xz}$$','Interpreter','latex','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
set(gca,'XTickLabel',{})
box off;
p(6,1).select();
bar(range,yz);
xlim([-1.05,1.05])
ylim([0,1.2]);
text(-1,0.97,'$$\sqrt(2)M_{yz}$$','Interpreter','latex','Color','k','FontSize',options.FontSize);
ylabel({'Scaled';'Probability'})
set(gca,'YTick',[0])
box off;
p.de.margin=5;
p.margintop=20;
p.marginleft=20;
hold off
n1=0;
n2=0;
n3=0;
end


function [XX,YY,ZZ,XY,XZ,YZ]=getComponents(MT);
MT=MTcheck(MT);
N=size(MT,2);
XX=zeros(1,N);
YY=zeros(1,N);
ZZ=zeros(1,N);
XY=zeros(1,N);
XZ=zeros(1,N);
YZ=zeros(1,N);
for i=1:N
    XX(i)=MT{i}(1,1);
    YY(i)=MT{i}(2,2);
    ZZ(i)=MT{i}(3,3);
    XY(i)=MT{i}(1,2);
    XZ(i)=MT{i}(1,3);
    YZ(i)=MT{i}(2,3);
end
end