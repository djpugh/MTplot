function HXPlot(MT,h,options)
set(0, 'currentfigure', h)
MT=MTcheck(MT);
if isstruct(MT)
    maxSource=numel(options.Probability)>0&&(options.MaxSource||options.Contour);
else
    maxSource=numel(options.Probability)>0&&((iscell(MT)&&options.MaxSource)||(iscell(MT)&&all(cellfun(@iscell,MT)))||(iscell(MT)&&options.Contour));
end
if isstruct(MT)&& any(strcmpi('H',fieldnames(MT)))&&any(strcmpi('x',fieldnames(MT)))
    H=MT.H;
    x=MT.x;
elseif isstruct(MT)
    error('MTplot:MTstruct','No h,x fields in struct')
else
    [H,x]=MT2HX(MT);
end
hold on

if (~options.Contour&&~options.MaxSource)&&numel(options.Probability)>0&&~(iscell(MT)&&all(cellfun(@iscell,MT)))
    %HX PDF
    [hrange,xrange,c,~,~]=hxhist(H,x,options,options.Probability);
    hold on;
    if options.Interp
    surf(hrange,xrange,0*c,c,'EdgeColor','none','FaceColor','interp');
    else
    surf(hrange,xrange,0*c,c,'EdgeColor','none');
    end
    cm=colormap(options.Colormap);
    if sum(sum(c==0))/numel(c)>0.1;
        cm=[1,1,1;cm];
    end
    colormap(cm);
    x=caxis;
    caxis([0,x(2)]);
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
        width=30;
        height=35;
        set(h,'Units','centimeters')
        set(h, 'Position',[1 1 width height],...
               'PaperSize',[width height],...
               'PaperPositionMode','auto',...
               'InvertHardcopy', 'off');
        if options.Movie
            movieplot(H,x,0*x,h,options)
        else
            plot3(H,x,0*x,'-','Color',[0.5,0.5,0.5],'LineWidth',0.2*options.LineWidth)
            Hr=H(options.Chain<0.01);
            Xr=x(options.Chain<0.01);
            color='r';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Hr,Xr,0,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
            Hb=H(options.Chain>0.99);
            Xb=x(options.Chain>0.99);
            color='b';
            color=bitget(find('krgybmcw'==color)-1,1:3);
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(Hb,Xb,0,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
        end
    else
        if maxSource
            for j=1:size(H,2)
                if ~iscell(H)
                    H={H};
                    x={x};
                    options.Probability={options.Probability};
                end
                if options.Contour&&~isnumeric(options.Contour)
                    options.Contour=0.99;
                end
                %
                [hrange,xrange,c,hmax,xmax]=hxhist(H,x,options,options.Probability);
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
                surf(hrange,xrange,0*Zr,contour+j,'EdgeColor','none');
                plot3(hmax,xmax,0,options.Marker,'Color',facecolor,'MarkerEdgeColor',color,'MarkerFaceColor',facecolor,'MarkerSize',options.MarkerSize,'LineWidth',options.LineWidth);
                cm=colormap();
                if j>1
                    cm=[cm;contourcolor];
                else
                    cm=[1,1,1;contourcolor];
                end
                colormap(cm);
            end
        else
            for j=1:size(H,1)
                if iscell(options.Color)
                    color=options.Color{j};
                else
                    color=options.Color;
                end
                
                if ischar(color)
                    color=bitget(find('krgybmcw'==color)-1,1:3);
                end
                facecolor=min((color+0.5*[1,1,1])',1)';              
                if options.MarkerSize>0
                    plot3(H,x,0*x+1,'h','Color',facecolor,'Marker',options.Marker,'MarkerFaceColor',facecolor,'MarkerEdgeColor',color,'markersize',options.MarkerSize,'LineWidth',options.LineWidth);
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
function [hrange,xrange,c,hmax,xmax]=hxhist(H,X,options,probability)
    n=min(max(size(X,2)/2,100),options.Resolution);    
    hrange=linspace(0,1,n);
    xrange=linspace(0,1,n);
    %convert to Phi and theta
    c=probhistc2d(H,X,hrange,xrange,probability,options.Marginalised,options.Normalise);        
    [hrange,xrange]=meshgrid(hrange,xrange);
%     c=c';%weird accumarray behaviour
    hmax=hrange(sum(c==max(max(c)),2)>0);
    xmax=xrange(sum(c==max(max(c)),1)>0)';
end