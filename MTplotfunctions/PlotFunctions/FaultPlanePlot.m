function [Xmax,Ymax,Zmax]=FaultPlanePlot(MT,h,options,~)
    MT=MTcheck(MT);    
    if options.BA
        [Phi1,Phi2]=MT2BA(MT,options.C);
        if ~iscell(Phi1)
            Phi1={Phi1};
        end
        if ~iscell(Phi2)
            Phi2={Phi2};
        end
        hold on;
        set(0, 'currentfigure', h);
        options.Indices=false;

        if options.FP && numel(options.Probability)>1     
            
            [P,ind]=sort(options.Probability,'ascend');
            options.Probability=P;
            Phi1=Phi1(ind);
            Phi2=Phi2(ind);
        end
        for i=1:numel(Phi1);
            set(0, 'currentfigure', h);
            %Orthogonal Vectors in plane
            if Phi1{i}/sqrt(sum(Phi1{i}.^2))~=[1;1;1]/sqrt(3)
                v1=cross(Phi1{i},[1;1;1]/sqrt(3));
                v2=cross(Phi1{i},v1);
                v1=v1/sqrt(sum(v1.^2));
                v2=v2/sqrt(sum(v2.^2));
            else
                v1=cross(Phi1{i},[1;-1;1]/sqrt(3));
                v2=cross(Phi1{i},v1);
                v1=v1/sqrt(sum(v1.^2));
                v2=v2/sqrt(sum(v2.^2));
            end
            vx1=v1(1,:);
            vy1=v1(2,:);
            vz1=v1(3,:);
            vx2=v2(1,:);
            vy2=v2(2,:);
            vz2=v2(3,:);
            [x1,y1,z1]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
            if Phi2{i}/sqrt(sum(Phi2{i}.^2))~=[1;1;1]/sqrt(3)
                v1=cross(Phi2{i},[1;1;1]/sqrt(3));
                v2=cross(Phi2{i},v1);
                v1=v1/sqrt(sum(v1.^2));
                v2=v2/sqrt(sum(v2.^2));
            else
                v1=cross(Phi2{i},[1;-1;1]/sqrt(3));
                v2=cross(Phi2{i},v1);
                v1=v1/sqrt(sum(v1.^2));
                v2=v2/sqrt(sum(v2.^2));
            end
            vx1=v1(1,:);
            vy1=v1(2,:);
            vz1=v1(3,:);
            vx2=v2(1,:);
            vy2=v2(2,:);
            vz2=v2(3,:);
            [x2,y2,z2]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
            [X1,Y1,Z1]=options.ProjFn(x1,y1,z1,options);
            [X2,Y2,Z2]=options.ProjFn(x2,y2,z2,options);
            if options.FP
                if numel(options.Probability)>1            
                    %Invert so large prob ahead of small prob
                    plot3(X1,Y1,Z1,'Color',(double(options.Probability(i))*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.3,'Marker','None')
                    plot3(X2,Y2,Z2,'Color',(double(options.Probability(i))*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.3,'Marker','None')
                else
                    plot3(X1,Y1,Z1,'Color','k','LineWidth',options.LineWidth,'Marker','None')
                    plot3(X2,Y2,Z2,'Color','k','LineWidth',options.LineWidth,'Marker','None')
                end
            end
        end
    else
        [strike1,dip1,~,strike2,dip2,~]=MT2SDR(MT);
        hold on;
        set(0, 'currentfigure', h);
        options.Indices=false;

        if options.FP && numel(options.Probability)>1     
            [P,ind]=sort(options.Probability,'ascend');
            options.Probability=P;
            strike1=strike1(ind);
            strike2=strike2(ind);
            dip1=dip1(ind);
            dip2=dip2(ind);
        end
        for i=1:length(strike1);
            set(0, 'currentfigure', h);
            [vx1,vy1,vz1]=toa2xyz((strike1(i)+90),(90-dip1(i)),false,'deg');
            [vx2,vy2,vz2]=toa2xyz(strike1(i),90,false,'deg');
            [x1,y1,z1]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
            [vx1,vy1,vz1]=toa2xyz((strike2(i)+90),(90-dip2(i)),false,'deg');
            [vx2,vy2,vz2]=toa2xyz(strike2(i),90,false,'deg');
            [x2,y2,z2]=GetGreatCircle([vx1,vy1,vz1],[vx2,vy2,vz2]);
            [X1,Y1,Z1]=options.ProjFn(x1,y1,z1,options);
            [X2,Y2,Z2]=options.ProjFn(x2,y2,z2,options);
            if options.FP
                if numel(options.Probability)>1            
                    %Invert so large prob ahead of small prob
                    plot3(X1,Y1,Z1,'Color',(double(options.Probability(i))*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.1,'Marker','None')
                    plot3(X2,Y2,Z2,'Color',(double(options.Probability(i))*[-0.8 -0.8 -0.8]+0.8),'LineWidth',0.1,'Marker','None')
                else
                    plot3(X1,Y1,Z1,'Color','k','LineWidth',options.LineWidth,'Marker','None')
                    plot3(X2,Y2,Z2,'Color','k','LineWidth',options.LineWidth,'Marker','None')
                end
            end
        end
    end
    %Rescale the axes if necessary
end