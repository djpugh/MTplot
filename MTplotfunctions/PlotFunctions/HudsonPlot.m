function varargs=HudsonPlot(MT,h,options)
%Set up and calculate parameters for Hudson type source plot and then plot
%either t,k or U,V depending on projection argument
varargs=[];
MT=MTcheck(MT);

if isstruct(MT)
    maxSource=numel(options.Probability)>0&&(options.MaxSource||options.Contour);
else
    maxSource=numel(options.Probability)>0&&((iscell(MT)&&options.MaxSource)||(iscell(MT)&&all(cellfun(@iscell,MT)))||(iscell(MT)&&options.Contour));
end
if ~iscell(MT)
    MT={MT};
end
if any(strcmpi(fieldnames(options),'PreMarginalise'))%call for pre marginalisation (memory saver)
    if options.PreMarginalise
    [xrange,yrange,z]=hudsonhist(MT,options,options.Probability);
    varargs={xrange,yrange,z};
    return 
    end
end
set(0, 'currentfigure', h)
if (~options.Contour&&~options.MaxSource)&&numel(options.Probability)>0&&~(iscell(MT)&&all(cellfun(@iscell,MT)))
    %ProbHist
    [xrange,yrange,z]=hudsonhist(MT,options,options.Probability);
    if options.AxisTitle
        if strcmp(options.Projection,'tau-k')
                title('\tau-k Source Probability Plot');
            else
                title('Equal Area Source Probaility  Plot (U,V)');
        end   
    end
    hold on;
    
    if options.Interp
        surf(xrange,yrange,zeros(size(z)),z,'EdgeColor','none','FaceColor','interp');
    else
        surf(xrange,yrange,zeros(size(z)),z,'EdgeColor','none');
    end
    cm=colormap(options.Colormap);
    if ~options.Logarithm
        x=caxis;
        if min(x)>=0               
        caxis([0,max(max(z))]);
        end
    end
    freezeColors;
    hold off
else
    %Marker plots
    if strcmp(options.Projection,'tau-k')
        title1='\tau-k Plot';
    else
        title1='Equal Area Source Plot (U,V)';
    end
    
    if options.AxisTitle
        title(title1);   
    end
    hold on   
%     if numel(options.Probability)>0&&((iscell(MT)&&options.MaxSource)||(iscell(MT)&&options.Contour))&& ~(iscell(MT)&&all(cellfun(@iscell,MT)))
%         MT={MT};
%         options.Probability={options.Probability};
%     end
    if options.Contour&&~isnumeric(options.Contour)
        options.Contour=0.99;
    end
    for j=1:numel(MT)
        if maxSource
            %Max source type plot
            [xrange,yrange,z]=hudsonhist(MT{j},options,options.Probability{j});            
            xmax=xrange(sum(z==max(max(z)),1)>0);
            ymax=yrange(sum(z==max(max(z)),2)>0);
            hold on;
            sorted_z=sort(reshape(z,numel(z),1),'descend');
            contour=z;
            frac_z=cumsum(sorted_z')/sum(sorted_z);
            contour(contour<max(sorted_z(frac_z>options.Contour)))=0;
            contour(contour>0)=j;
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
            if options.Contour
                if options.Interp
                    surf(xrange,yrange,0*z-(j-1),contour,'EdgeColor','none','FaceColor','interp');
                else
                    surf(xrange,yrange,0*z-(j-1),contour,'EdgeColor','none');
                end
%                 alpha('color');
            end
            plot3(xmax,ymax,1,options.Marker,'Color',facecolor,'MarkerEdgeColor',color,'MarkerFaceColor',facecolor,'MarkerSize',options.MarkerSize,'LineWidth',options.LineWidth);
            cm=colormap();            
            if j>1
                cm=[cm;contourcolor];
            else
                cm=[1,1,1;contourcolor];
            end
            colormap(cm);
        else           
            [x,y]=options.ProjFn(MT{j});
            if iscell(options.Color)
                color=options.Color{j};
            else
                color=options.Color;
            end
            if ischar(color)
                color=bitget(find('krgybmcw'==color)-1,1:3);
            end
            facecolor=min((color+0.5*[1,1,1])',1)';
            plot3(x,y,0.2,options.Marker,'Color',facecolor,'MarkerEdgeColor',color,'MarkerFaceColor',facecolor,'MarkerSize',options.MarkerSize,'LineWidth',options.LineWidth);
        end
    end
    hold off
    if numel(MT)>1&&options.Legend
        customlegend(h,1.5,-1,options.Marker,options.Names,options.LegendColors);
    end
    axis equal;
    axis square;
end
end
function customlegend(h,posx,posy,symbol,names,colors)
% Set up custom legend for a display
    if any(strcmpi(symbol,{'d','diamond'}))
        symbol='\diamondsuit';
    end
    outstring={};
    for i=1:length(names)
        outstring={outstring{:},horzcat('\color',colors{i},' ',symbol,' \color {black} ',names{i})};
    end
    set(0, 'currentfigure', h)
    text(posx,posy,outstring','HorizontalAlignment','Center')
        

end
function [xrange,yrange,z]=hudsonhist(MT,options,probability)
    tic
    if isstruct(MT)&& any(strcmpi('tau',fieldnames(MT)))&&any(strcmpi('k',fieldnames(MT)))&&strcmpi(options.Projection,'tau-k')
        X=MT.t;
        Y=MT.k;
    elseif isstruct(MT)&& any(strcmpi('u',fieldnames(MT)))&&any(strcmpi('v',fieldnames(MT)))&&strcmpi(options.Projection,'u-v')
        X=MT.u;
        Y=MT.v;
    elseif isstruct(MT)
        error('MTplot:MTstruct','No u,v or t,k fields in struct')
    else
        [X,Y]=options.ProjFn(MT);
    end
    N=size(X,2);
    
    n=min(max(N/2,100),options.Resolution);
    if strcmpi(options.Projection,'tau-k')
        xrange=linspace(-1,1,n);
        yrange=linspace(-1,1,n);
    else
        xrange=linspace(-4/3,4/3,n);
        yrange=linspace(-4/3,4/3,n);%Large limits to make bins square
    end
    z=probhistc2d(X,Y,xrange,yrange,probability,options.Marginalised,options.Logarithm,options.Normalise);  
    if options.Logarithm
    z(z==-inf)=nan;
    else        
    z(z==0)=nan;
    end
end

