function [Xmax,Ymax,Zmax]=FocalPlaneProbPlot(MT,h,options,~)

prob=options.Probability;
if strcmp(char(class(MT)),'cell')
    Xmax=70;
    Ymax=70;
    Zmax=70;
    for i=1:length(MT)
        options.Probability=prob(i);
        [xmax,ymax,zmax]=FocalPlaneProbPlot(cell2mat(MT(i)),h,options);
        Xmax=max(Xmax,xmax);
        Ymax=max(Ymax,ymax);
        Zmax=max(Zmax,zmax);
    end   
    options.Probability=prob;
else
    set(0, 'currentfigure', h);
    MT=MTcheck(MT);
    [strike1,dip1,~,strike2,dip2,~]=MT2SDR(MT);
    set(0, 'currentfigure', h);
    
    opt.Lower=0;
    opt.StationProjection=0;
    opt.Radians=false;
    [vx1,vy1,vz1]=toa2xyz((strike1+90),(90-dip1),opt);
    [vx2,vy2,vz2]=toa2xyz(strike1,90,opt);
    [x1,y1,z1]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
    [vx1,vy1,vz1]=toa2xyz((strike2+90),(90-dip2),opt);
    [vx2,vy2,vz2]=toa2xyz(strike2,90,opt);
    [x2,y2,z2]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
    [X1,Y1,Z1]=options.ProjFn(x1,y1,z1,options);
    [X2,Y2,Z2]=options.ProjFn(x2,y2,z2,options);
    if options.FaultPlane
        hold on;
        plot3(50*X1,50*Y1,50*Z1,'Color',(double(prob)*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.1,'Marker','None')
        plot3(50*X2,50*Y2,50*Z2,'Color',(double(prob)*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.1,'Marker','None')
        hold off
    end
    X=[X1,X2];
    Y=[Y1,Y2];
    Z=[Z1,Z2];
    X(isinf(X))=NaN;
    Y(isinf(Y))=NaN;
    Z(isinf(Z))=NaN;
    %Rescale the axes if necessary
    Xmax=max(max(max(abs(50*X)))+20,70);
    Ymax=max(max(max(abs(50*Y)))+20,70);
    Zmax=max(max(max(abs(50*Z)))+20,70);
end
end