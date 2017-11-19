function varargs=LunePlot(MT,h,options)
varargs=[];
MT=MTcheck(MT);
if isstruct(MT)
    maxSource=numel(options.Probability)>0&&(options.MaxSource||options.Contour);
else
    maxSource=numel(options.Probability)>0&&((iscell(MT)&&options.MaxSource)||(iscell(MT)&&all(cellfun(@iscell,MT)))||(iscell(MT)&&options.Contour));
end
if isstruct(MT)&& any(strcmpi('d',fieldnames(MT)))&&any(strcmpi('g',fieldnames(MT)))
    d=MT.d;
    g=MT.g;
elseif isstruct(MT)&& any(strcmpi('MTSpace',fieldnames(MT)))
    MT=MT.MTSpace;
    [~,~,~,E]=MT2TNPE(MT);
    [g,d]=E2GD(E);
elseif isstruct(MT)
    error('MTplot:MTstruct','No d,g fields or MTSpace in struct')
else
%     fprintf(1,'Converting to g,d');
    [~,~,~,E]=MT2TNPE(MT);
    [g,d]=E2GD(E);
end
if any(strcmpi(fieldnames(options),'PreMarginalise'))
    if options.PreMarginalise
    b=pi/2-d;
    x=cos(g).*sin(b);
    y=sin(g).*sin(b);
    z=cos(b);
    [xrange,yrange,zrange,c]=lunehist(x,y,z,options,options.Probability);
    varargs={xrange,yrange,zrange,c};
    return 
    end
end
set(0, 'currentfigure', h)
hold on

if (~options.Contour&&~options.MaxSource)&&numel(options.Probability)>0&&~(iscell(MT)&&all(cellfun(@iscell,MT)))
    %Lune PDF
    b=pi/2-d;
    x=cos(g).*sin(b);
    y=sin(g).*sin(b);
    z=cos(b);
    [xrange,yrange,zrange,c]=lunehist(x,y,z,options,options.Probability);
    options.Lower=false;
    if strcmpi(options.Dimension,'2d')
        R=[0,1,0;0,0,1;-1,0,0];
%         v=R*[x';y';z'];
%         x=v(1,:);
%         y=v(2,:);
%         z=v(3,:);
        v=R*[reshape(xrange,1,numel(xrange));reshape(yrange,1,numel(yrange));reshape(zrange,1,numel(zrange))];
        xrange=reshape(v(1,:),size(xrange,1),size(xrange,2));
        yrange=reshape(v(2,:),size(yrange,1),size(yrange,2));
        zrange=reshape(v(3,:),size(zrange,1),size(zrange,2));
    end
%     [X,Y,Z]=options.ProjFn(x,y,z,options);
    [Xr,Yr,Zr]=options.ProjFn(xrange,yrange,zrange,options);
%     X(isinf(X))=NaN;
%     Y(isinf(Y))=NaN;
%     Z(isinf(Z))=NaN;
%     [xrange,yrange,zrange,c]=lunehist(X,Y,Z,options,options.Probability);
    hold on;
%     surf(xrange,yrange,zrange,c,'EdgeColor','none','FaceColor','interp');
    if ~options.Logarithm
        c(c==0)=nan;
    else
        c(c==-inf)=nan;
    end
    if options.Interp
    surf(Xr,Yr,Zr,c,'EdgeColor','none','FaceColor','interp');
    else
    surf(Xr,Yr,Zr,c,'EdgeColor','none');
    end
    cm=colormap(options.Colormap);
    if ~options.Logarithm
        cm=[1,1,1;cm];
        colormap(cm);
        x=caxis;
        caxis([0,x(2)]);
    end
    freezeColors;
    hold off
    axis square;
else
    hold on
    color='b';
    if ischar(color)
    color=bitget(find('krgybmcw'==color)-1,1:3);
    end
    facecolor=min((color+0.5*[1,1,1])',1)';
    if isnumeric(options.Chain)&&numel(options.Chain)>0
        b=pi/2-d;
        x=cos(g).*sin(b);
        y=sin(g).*sin(b);
        z=cos(b);
        options.Lower=false;
        if strcmpi(options.Dimension,'2d')
            R=[0,1,0;0,0,1;-1,0,0];
            v=R*[x';y';z'];
            x=v(1,:);
            y=v(2,:);
            z=v(3,:);
        end
        [X,Y,Z]=options.ProjFn(x,y,z,options);
        X(isinf(X))=NaN;
        Y(isinf(Y))=NaN;
        Z(isinf(Z))=NaN;
        if sum(Z)==0
            Z=Z+1;
        end
        if strcmpi(options.Dimension,'3d')
            d=1.1;
            X=d*X;
            Y=d*Y;
            Z=d*Z;
        end
        if options.Movie
            width=30;
            height=35;
            set(h,'Units','centimeters')
            set(h, 'Position',[1 1 width height],...
                   'PaperSize',[width height],...
                   'PaperPositionMode','auto',...
                   'InvertHardcopy', 'off');
            movieplot(X,Y,Z,h,options)
        else
            plot3(X,Y,Z,'-','Color',[0.5,0.5,0.5],'LineWidth',0.2*options.LineWidth)
            Xr=X(options.Chain<0.01);
            Yr=Y(options.Chain<0.01);
            Zr=Z(options.Chain<0.01);
            color='r';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Xr,Yr,Zr,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
            Xb=X(options.Chain>0.99);
            Yb=Y(options.Chain>0.99);
            Zb=Z(options.Chain>0.99);
            color='b';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Xb,Yb,Zb,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
        end
    else
        if maxSource
            for j=1:size(g,2)
                if ~iscell(g)
                    g={g};
                    d={d};
                    options.Probability={options.Probability};
                end
                if options.Contour&&~isnumeric(options.Contour)
                    options.Contour=0.99;
                end
                %Lune Max Source Plot
                b=pi/2-d{j};
                x=cos(g{j}).*sin(b);
                y=sin(g{j}).*sin(b);
                z=cos(b);
                options.Lower=false;
                [xrange,yrange,zrange,c]=lunehist(x,y,z,options,options.Probability);
                if strcmpi(options.Dimension,'2d')
                    R=[0,1,0;0,0,1;-1,0,0];
                    v=R*[reshape(xrange,1,numel(xrange));reshape(yrange,1,numel(yrange));reshape(zrange,1,numel(zrange))];
                    xrange=reshape(v(1,:),size(xrange,1),size(xrange,2));
                    yrange=reshape(v(2,:),size(yrange,1),size(yrange,2));
                    zrange=reshape(v(3,:),size(zrange,1),size(zrange,2));
                end
                [Xr,Yr,Zr]=options.ProjFn(xrange,yrange,zrange,options);
                hold on;
                sorted_c=sort(reshape(c,numel(c),1),'descend');
                contour=c;
                frac_c=cumsum(sorted_c')/sum(sorted_c);
                contour(contour<max(sorted_c(frac_c>options.Contour)))=0;
                contour(contour>0)=1;
                if iscell(options.Color)
                    color=options.Color{j};
                else
                    color=options.Color;
                end
                    
                if ischar(color)
                    color=bitget(find('krgybmcw'==color)-1,1:3);
                end
                facecolor=min((color+0.5*[1,1,1])',1)';
                contourcolor=min((facecolor+0.2*[1,1,1])',1)';
                surf(Xr,Yr,Zr,contour+j,'EdgeColor','none');
                plot3(xmax,ymax,zmax,options.Marker,'Color',facecolor,'MarkerEdgeColor',color,'MarkerFaceColor',facecolor,'MarkerSize',options.MarkerSize,'LineWidth',options.LineWidth);
                cm=colormap();
                if j>1
                    cm=[cm;contourcolor];
                else
                    cm=[1,1,1;contourcolor];
                end
                colormap(cm);
            end
        else
            for j=1:size(g,1)
                b=pi/2-d(j);
                x=cos(g(j)).*sin(b);
                y=sin(g(j)).*sin(b);
                z=cos(b);
                options.Lower=false;
                if iscell(options.Color)
                    color=options.Color{j};
                else
                    color=options.Color;
                end
                
                if ischar(color)
                    color=bitget(find('krgybmcw'==color)-1,1:3);
                end
                facecolor=min((color+0.5*[1,1,1])',1)';
                if strcmpi(options.Dimension,'2d')
                    R=[0,1,0;0,0,1;-1,0,0];
                    v=R*[x';y';z'];
                    x=v(1,:);
                    y=v(2,:);
                    z=v(3,:);
                end
                [X,Y,Z]=options.ProjFn(x,y,z,options);
                X(isinf(X))=NaN;
                Y(isinf(Y))=NaN;
                Z(isinf(Z))=NaN;
                if sum(Z)==0
                    Z=Z+1;
                end
                if options.MarkerSize>0
                    plot3(X,Y,Z,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
                end
            end
        end
        hold off
    end
end
hold off
end
function movieplot(X,Y,Z,h,options)
    color='b';
    options.Lower=1;
    options.BackgroundFn([],h,options)
    wO=VideoWriter('LuneChain.avi');
    wO.open()
    wO.writeVideo(getframe);
    n=0;
    for i=1:numel(X)    
        for j=1:n
            fprintf(1,'\b')
        end
        x=sprintf('frame %u',i);
        n=size(x,2);
        fprintf(1,x);
        cla
        options.BackgroundFn([],h,options)
        hold on        
        if i>1                
            if color==bitget(find('krgybmcw'=='b')-1,1:3)
                if options.Chain(i-1)>0.99
                    color='g';
                else
                    color='r';
                end
                color=bitget(find('krgybmcw'==color)-1,1:3);
                facecolor=min((color+0.5*[1,1,1])',1)';
            end
            color=facecolor;
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(X(i-1),Y(i-1),Z(i-1),'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
            %Old values
            Xr=X(options.Chain(1:i-2)<0.01);
            Yr=Y(options.Chain(1:i-2)<0.01);
            Zr=Z(options.Chain(1:i-2)<0.01);
            color='r';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            color=min((color+0.5*[1,1,1])',1)';
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Xr,Yr,Zr,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
            Xb=X(options.Chain(1:i-2)>0.99);
            Yb=Y(options.Chain(1:i-2)>0.99);
            Zb=Z(options.Chain(1:i-2)>0.99);
            color='g';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            color=min((color+0.5*[1,1,1])',1)';
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Xb,Yb,Zb,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
            %Chain
            Xb=X(options.Chain(1:i)>0.99);
            Yb=Y(options.Chain(1:i)>0.99);
            Zb=Z(options.Chain(1:i)>0.99);
            if strcmpi(options.Dimension,'2d')
                plot3(X(1:i),Y(1:i),Z(1:i)-1,'-','Color',[0.8,0.8,0.8],'LineWidth',0.2*options.LineWidth)
            end
            if strcmpi(options.Dimension,'2d')
                plot3(Xb,Yb,Zb-1,'-','Color',[0.3,0.3,0.3],'LineWidth',0.2*options.LineWidth)
            end
        end
        if i>1&&options.Chain(i)<0.01
            color='r';
        elseif i>1&&options.Chain(i)>0.99
            color='g';
        else
            color='b';
        end
        color=bitget(find('krgybmcw'==color)-1,1:3);
        facecolor=min((color+0.5*[1,1,1])',1)';
        plot3(X(i),Y(i),Z(i),'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
        hold off
        wO.writeVideo(getframe)
    end
    hold off
    wO.close()
end
function [xrange,yrange,zrange,c,xmax,ymax,zmax]=lunehist(X,Y,Z,options,probability)
    n=min(max(size(Z,2)/2,100),options.Resolution);
    phirange=linspace(-pi/6,pi/6,n);
    zrange=linspace(-1,1,n);
    %convert to Phi and theta
    Phi=atan2(Y,X)';
    c=probhistc2d(Phi,Z',phirange,zrange,probability,options.Marginalised,options.Logarithm,options.Normalise);        
    [phirange,zrange]=meshgrid(phirange,zrange);
    xrange=sin(acos(zrange)').*cos(phirange');
    yrange=sin(acos(zrange)').*sin(phirange');
    zrange=zrange';
    c=c';%weird accumarray behaviour
    pmax=unique(phirange(sum(c==max(max(c)),2)>0));
    zmax=unique(zrange(sum(c==max(max(c)),1)>0)');
    xmax=sin(acos(zmax)).*cos(pmax);
    ymax=sin(acos(zmax)).*sin(pmax);
end