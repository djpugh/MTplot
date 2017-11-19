function RiedeselJordanPlot(MT,h,options)
set(0, 'currentfigure', h)
MT=MTcheck(MT);

MT=MT./(sqrt(sum(sum(MT.^2))));
[V,M]=eigs(MT,3,'la');
lambda=M(1,1)*V(:,1)+M(2,2)*V(:,2)+M(3,3)*V(:,3);
dc=(V(:,1)-V(:,3))/sqrt(2);
clvd1=(V(:,1)-0.5*V(:,2)-0.5*V(:,3))/sqrt(3/2);
clvd2=(0.5*V(:,1)+0.5*V(:,2)-V(:,3))/sqrt(3/2);
iso=(V(:,1)+V(:,2)+V(:,3))/sqrt(3);
%[x,y,z]=(GetGreatCircle(clvd1,clvd2));
%[DevCircx,DevCircy,DevCircz]=options.ProjFn(x,y,z,options);
T=V(:,1);
N=V(:,2);
P=V(:,3);
%LHProj - want all vectors pointing down (different triangle
%orientation)
hold on
x=ones(1000);
y=ones(1000);
z=zeros(1000);
for i=1:10000
    x(i)=cos(i*2*pi/1000);
    y(i)=sin(i*2*pi/1000);
end
[X,Y,Z]=options.ProjFn(x,y,z,options);
plot3(X,Y,Z,'Color','k','LineWidth',0.1,'Marker','None')
%plot3(DevCircx,DevCircy,DevCircz,'Color','k','LineWidth',0.1,'LineStyle',':','Marker','None')
axis equal;
[Tmarker,Tx,Ty,Tz]=GetRiedeselProjection(T,options);
[Nmarker,Nx,Ny,Nz]=GetRiedeselProjection(N,options);
[Pmarker,Px,Py,Pz]=GetRiedeselProjection(P,options);
[Lmarker,Lx,Ly,Lz]=GetRiedeselProjection(lambda,options);
if Lmarker=='v'
    Lmarker='o';
else
    Lmarker='x';
end
[DCmarker,DCx,DCy,DCz]=GetRiedeselProjection(dc,options);
[CLVD1marker,CLVD1x,CLVD1y,CLVD1z]=GetRiedeselProjection(clvd1,options);
[CLVD2marker,CLVD2x,CLVD2y,CLVD2z]=GetRiedeselProjection(clvd2,options);
[ISOmarker,ISOx,ISOy,ISOz]=GetRiedeselProjection(iso,options);
text(Tx,Ty,Tz,'  T','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize);
plot3(Tx,Ty,Tz,'h','Color','black','Marker',Tmarker,'MarkerFaceColor','black','markersize',3);
text(Px,Py,Pz,' P','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize);
plot3(Px,Py,Pz,'h','Color','black','Marker',Pmarker,'MarkerFaceColor','black','markersize',3);
text(Nx,Ny,Nz,' N','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize);
plot3(Nx,Ny,Nz,'h','Color','black','Marker',Nmarker,'MarkerFaceColor','black','markersize',3);
% if options.Text
text(Lx,Ly,Lz,'  \Lambda','HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',options.FontSize,'FontWeight','bold');
% end
plot3(Lx,Ly,Lz,'h','Color','black','Marker',Lmarker,'MarkerFaceColor','black','markersize',3);
text(DCx,DCy,DCz,' dc','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'FontWeight','bold');
plot3(DCx,DCy,DCz,'h','Color','black','Marker',DCmarker,'MarkerFaceColor','black','markersize',3);
text(CLVD1x,CLVD1y,CLVD1z,' clvd_1','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'FontWeight','bold');
plot3(CLVD1x,CLVD1y,CLVD1z,'h','Color','black','Marker',CLVD2marker,'MarkerFaceColor','black','markersize',3);
text(CLVD2x,CLVD2y,CLVD2z,' clvd_2','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'FontWeight','bold');
plot3(CLVD2x,CLVD2y,CLVD2z,'h','Color','black','Marker',CLVD1marker,'MarkerFaceColor','black','markersize',3);
text(ISOx,ISOy,ISOz,' iso','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'FontWeight','bold');
plot3(ISOx,ISOy,ISOz,'h','Color','black','Marker',ISOmarker,'MarkerFaceColor','black','markersize',3);
axis off;
grid off;
hold off;
if options.AxisTitle
title({'Riedesel Jordan Source Plot for Moment Tensor:';[mat2str(MT(1)),'  ',...
        mat2str(MT(2)),'  ',mat2str(MT(3))];[mat2str(MT(4)),'  ',mat2str(MT(5)),'  ',mat2str(MT(6))];...
        [mat2str(MT(7)),'  ',mat2str(MT(8)),'  ',mat2str(MT(9))]}); 
end
X(isinf(X))=NaN;
Y(isinf(Y))=NaN;
Z(isinf(Z))=NaN;
%Rescale the axes if necessary
if options.FP
    FaultPlanePlot(MT,h,options);
end
%Faded patch for viable area

delta=clvd2-clvd1;
n=100;
x=ones(1,n);
y=ones(1,n);
z=ones(1,n);
for i=1:n
    x1=clvd1+(i*delta/(n));
    x2=-clvd1-(i*delta/(n));
    pointvec1=x1/norm(x1);
    pointvec2=x2/norm(x2);
    X1(i)=pointvec1(1);
    Y1(i)=pointvec1(2);
    Z1(i)=pointvec1(3); 
    X2(i)=pointvec2(1);
    Y2(i)=pointvec2(2);
    Z2(i)=pointvec2(3); 
end
[DevCircx1,DevCircy1,DevCircz1]=options.ProjFn(X1,Y1,Z1,options);
[DevCircx2,DevCircy2,DevCircz2]=options.ProjFn(X2,Y2,Z2,options);
fullsphere=options.FullSphere;
options.FullSphere=true;
[x,y,z]=GetGreatCircle([1,0,0],[0,1,0],4,1000);
[x,y,z]=options.ProjFn(x,y,z,options);
Edgex=x;
Edgey=y;
Edgez=z;
mv=max(x);
options.FullSphere=fullsphere;
[x,y,z]=(GetGreatCircle(iso,clvd1));
[Limit1Circx,Limit1Circy,Limit1Circz]=options.ProjFn(x,y,z,options);
Limit1Circx=Limit1Circx(~isnan(Limit1Circx));
Limit1Circz=Limit1Circz(~isnan(Limit1Circy));
Limit1Circy=Limit1Circy(~isnan(Limit1Circy));
[x,y,z]=(GetGreatCircle(iso,dc));
[DCCircx,DCCircy,DCCircz]=options.ProjFn(x,y,z,options);
DCCircx=DCCircx(~isnan(DCCircx));
DCCircz=DCCircz(~isnan(DCCircy));
DCCircy=DCCircy(~isnan(DCCircy));
[x,y,z]=(GetGreatCircle(iso,clvd2));
[Limit2Circx,Limit2Circy,Limit2Circz]=options.ProjFn(x,y,z,options);
Limit2Circx=Limit2Circx(~isnan(Limit2Circx));
Limit2Circz=Limit2Circz(~isnan(Limit2Circy));
Limit2Circy=Limit2Circy(~isnan(Limit2Circy));
m1=sqrt(Limit1Circx.^2+Limit1Circy.^2+Limit1Circz.^2);
% n1=m1>=mv;
% Limit1Circx(n1)=mv*Limit1Circx(n1)./m1(n1);
% Limit1Circy(n1)=mv*Limit1Circy(n1)./m1(n1);
% Limit1Circz(n1)=mv*Limit1Circz(n1)./m1(n1);
m2=sqrt(Limit2Circx.^2+Limit2Circy.^2+Limit2Circz.^2);
mdc=sqrt(DCCircx.^2+DCCircy.^2+DCCircz.^2);
% n2=m2>=mv;
% Limit2Circx(n2)=mv*Limit2Circx(n2)./m2(n2);
% Limit2Circy(n2)=mv*Limit2Circy(n2)./m2(n2);
% Limit2Circz(n2)=mv*Limit2Circz(n2)./m2(n2);
hold on
plot3(DevCircx1,DevCircy1,DevCircz1,'Color','k','LineWidth',options.LineWidth,'LineStyle',':','Marker','None')
plot3(DevCircx2,DevCircy2,DevCircz2,'Color','k','LineWidth',options.LineWidth,'LineStyle',':','Marker','None')
%Add edge
[~,ind1]=sort(m1);
[~,ind2]=sort(m2);
[~,inddc]=sort(mdc);
ind1=ind1(end-1:end);
ind2=ind2(end-1:end);
inddc=inddc(end-1:end);
%lower
edge_limit1x=Limit1Circx(ind1);
edge_limit1y=Limit1Circy(ind1);
edge_limit2x=Limit2Circx(ind2);
edge_limit2y=Limit2Circy(ind2);
edge_dcx=DCCircx(inddc);
edge_dcy=DCCircy(inddc);
if abs(diff(edge_limit1x))> abs(diff(edge_limit1y))
lower1x=min(edge_limit1x);
upper1x=max(edge_limit1x);
lower1y=edge_limit1y(edge_limit1x==min(edge_limit1x));
upper1y=edge_limit1y(edge_limit1x==max(edge_limit1x));
else
lower1y=min(edge_limit1y);
upper1y=max(edge_limit1y);
lower1x=edge_limit1x(edge_limit1y==min(edge_limit1y));
upper1x=edge_limit1x(edge_limit1y==max(edge_limit1y));
end
if abs(diff(edge_limit2x))>abs(diff(edge_limit2y))
lower2x=min(edge_limit2x);
upper2x=max(edge_limit2x);
lower2y=edge_limit2y(edge_limit2x==min(edge_limit2x));
upper2y=edge_limit2y(edge_limit2x==max(edge_limit2x));
else
lower2y=min(edge_limit2y);
upper2y=max(edge_limit2y);
lower2x=edge_limit2x(edge_limit2y==min(edge_limit2y));
upper2x=edge_limit2x(edge_limit2y==max(edge_limit2y));
end
if abs(diff(edge_dcx))> abs(diff(edge_dcy))
lowerdcx=min(edge_dcx);
upperdcx=max(edge_dcx);
lowerdcy=edge_dcy(edge_dcx==min(edge_dcx));
upperdcy=edge_dcy(edge_dcx==max(edge_dcx));
else
lowerdcy=min(edge_dcy);
upperdcy=max(edge_dcy);
lowerdcx=edge_dcx(edge_dcy==min(edge_dcy));
upperdcx=edge_dcx(edge_dcy==max(edge_dcy));
end
vl1=[lower1x-ISOx;lower1y-ISOy];
vl2=[lower2x-ISOx;lower2y-ISOy];
vu1=[upper1x-ISOx;upper1y-ISOy];
vu2=[upper2x-ISOx;upper2y-ISOy];
vl1=vl1/sqrt(sum(vl1.^2));
vl2=vl2/sqrt(sum(vl2.^2));
vu2=vu2/sqrt(sum(vu2.^2));
vu1=vu1/sqrt(sum(vu1.^2));
dc1=[lowerdcx-ISOx;lowerdcy-ISOy];
dc2=[upperdcx-ISOx;upperdcy-ISOy];
dc1=dc1/sqrt(sum(dc1.^2));
iso_dc1_phi=mod(atan2(dc1(2),dc1(1)),2*pi);
iso_dc2_phi=mod(atan2(dc2(2),dc2(1)),2*pi);
iso_dc_phi=[iso_dc1_phi,iso_dc2_phi];
iso_l_phi=[mod(atan2(vl1(2),vl1(1)),2*pi),mod(atan2(vl2(2),vl2(1)),2*pi)];
iso_u_phi=[mod(atan2(vu1(2),vu1(1)),2*pi),mod(atan2(vu2(2),vu2(1)),2*pi)];
if ~(any((iso_dc_phi>min(iso_l_phi)).*(iso_dc_phi<max(iso_l_phi)))||any((iso_dc_phi<max(iso_u_phi)).*(iso_dc_phi>min(iso_u_phi))))
    l2=[lower2x,lower2y];
    lower2x=upper2x;
    lower2y=upper2y;
    upper2x=l2(1);
    upper2y=l2(2);
end
[~,ind]=sort(acos([lower1x,lower1y]*[Limit1Circx;Limit1Circy]./(sqrt(2).*m1)));
Limit1Circx=Limit1Circx(ind);
Limit1Circy=Limit1Circy(ind);
Limit1Circz=Limit1Circz(ind);
[~,ind]=sort(acos([lower2x,lower2y]*[Limit2Circx;Limit2Circy]./(sqrt(2).*m2)));
Limit2Circx=Limit2Circx(ind);
Limit2Circy=Limit2Circy(ind);
Limit2Circz=Limit2Circz(ind);
%Get Edge indices between lower1 and lower2
phi1=mod(atan2(lower1y,lower1x),2*pi);
phi2=mod(atan2(lower2y,lower2x),2*pi);
if abs(abs(phi1)-abs(phi2))-acos([lower1x,lower1y]*[lower2x;lower2y]/(mv*mv))>0.1
    if phi2>phi1
        phi2=phi2-2*pi;
    else
        phi1=phi1-2*pi;
    end
end
phi=linspace(min([phi1,phi2]),max([phi1,phi2]),200);
edgex=mv*cos(phi);
edgey=mv*sin(phi);
if abs(edgex(1)-Limit1Circx(1))<abs(edgex(end)-Limit1Circx(1))    
    Limit1Circx=[fliplr(edgex),Limit1Circx];
    Limit1Circy=[fliplr(edgey),Limit1Circy];
    Limit1Circz=[0*phi,Limit1Circz];
else
    Limit1Circx=[edgex,Limit1Circx,];
    Limit1Circy=[edgey,Limit1Circy];
    Limit1Circz=[0*phi,Limit1Circz];
end
phi1=mod(atan2(upper1y,upper1x),2*pi);
phi2=mod(atan2(upper2y,upper2x),2*pi);
if abs(abs(phi1)-abs(phi2))-acos([upper1x,upper1y]*[upper2x;upper2y]/(mv*mv))>0.1
    if phi2>phi1
        phi2=phi2-2*pi;
    else
        phi1=phi1-2*pi;
    end
end
phi=linspace(min([phi1,phi2]),max([phi1,phi2]),200);
edgex=mv*cos(phi);
edgey=mv*sin(phi);
if abs(edgex(1)-Limit1Circx(end))<abs(edgex(end)-Limit1Circx(end))    
    Limit1Circx=[Limit1Circx,edgex];
    Limit1Circy=[Limit1Circy,edgey];
    Limit1Circz=[Limit1Circz,0*phi];
else
    Limit1Circx=[Limit1Circx,fliplr(edgex)];
    Limit1Circy=[Limit1Circy,fliplr(edgey)];
    Limit1Circz=[Limit1Circz,0*phi];
end

if strcmpi(options.Dimension,'2d')
xlim([-1.5,1.5]);ylim([-1.5,1.5]);
    color='g';
    if options.Contour
        color=[0.4,0.4,0.4];
    end
    Limit1Circz=Limit1Circz-1;
    Limit2Circz=Limit2Circz-1;
    hf=fill3([Limit2Circx,fliplr(Limit1Circx)],[Limit2Circy,fliplr(Limit1Circy)],[Limit2Circz,fliplr(Limit1Circz)],color,'EdgeColor',color,'AlphaDataMapping','none');
    alpha(hf,0.1);
else
plot3(Limit1Circx,Limit1Circy,Limit1Circz,'g');
plot3(Limit2Circx,Limit2Circy,Limit2Circz,'g');
end
if options.Contour    
    [x,y,z,c,~]=xyzc(MT,options,options.Phase);
    [X,Y,~]=options.ProjFn(x,y,z,options);
    contour(X,Y,c);
    colormap(options.Colormap);
    maxc=max([abs(max(max(c))),abs(min(min(c)))]);
    caxis([-maxc maxc]);
end
hold off
end
%
% Riedesl Projection Marker Fetch
%
function [marker,X,Y,Z]=GetRiedeselProjection(vec,options) 
% Get projection coordinates and marker for Riedesel-Jordan  plot (v is in
% that hemisphere, ^ is inverted
    marker='v';
    if vec(3)<0
        vec=-vec;
        marker='^';
    end
    marker='v';
    [X,Y,Z]=options.ProjFn(vec(1),vec(2),vec(3),options); 
end