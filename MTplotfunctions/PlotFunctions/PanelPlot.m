function PanelPlot(MT,h,options)
set(0, 'currentfigure', h)
axis off;
options.FigureHandle=h;
p=panel('no-manage-font');
p.pack(options.Geometry(1),options.Geometry(2));
n=1;
opts={};
for i=1:options.Geometry(1)
    for j=1:options.Geometry(2)
        fn = fieldnames(options);
        opt=options;
        for str = fn'
            if strcmpi(char(str),'Stations')&&iscell(options.Stations)&&numel(options.Stations)>1&&~iscell(options.Stations{1})
                opt.(char(str)) = options.(char(str)){i,j};
            elseif iscell(options.(char(str)))&&all(size(options.(char(str)))>=[i,j])
                opt.(char(str)) = options.(char(str)){i,j};
            end
        end
        opt.Panel=false;
        opt.PanelMode=true;
        opt.PanelIndex=[i,j];
        %options.FigureHandle=h1;
        if any(size(MT{i,j})>[0,0])
            [~,opt]=MTplot(MT{i,j},'Options',opt);
            opts{i,j}=opt;
            Xmax=max(xlim);
            Ymax=max(ylim);
            Zmax=max(zlim);
            if strcmpi(get(gca,'XDir'),'normal')
                Xmax=-Xmax;
            end
            if strcmpi(get(gca,'YDir'),'reverse')
                Ymax=-Ymax;
                Xmax=-Xmax;
            end
            if strcmpi(get(gca,'ZDir'),'reverse')
                Zmax=-Zmax;
            end
            if all([i,j]<=size(options.Subtitle)) && iscell(options.Subtitle)
                text(+Xmax,Ymax,Zmax,options.Subtitle{i,j},'Color','k','FontSize',options.FontSize);
            elseif numel(MT)>26 || options.Roman
               text(+Xmax,Ymax,Zmax,['(',dec2rom(n),')'],'Color','k','FontSize',options.FontSize);
            else
                text(+Xmax,Ymax,Zmax,['(',char(n-1+'a'),')'],'Color','k','FontSize',options.FontSize);
                hold off;
            end
            freezeColors();
        else            
            axis off;
            grid off;
        end
        n=n+1;
        freezeColors();
    end
end
options.FigureHandle=h;
p.fontsize=options.FontSize;
if ~any(strcmpi(opt.Mode,{'sdr','sdrsilhouette','tape'}))
p.marginright = 10;
p.margintop=10;
p.de.margin = 10;
else
p.margintop=10;
end

for i=1:options.Geometry(1)
    for j=1:options.Geometry(2)
        if any(size(MT{i,j})>[0,0]) && ~any(strcmpi(opts{i,j}.Mode,{'hudson','lune','tape'}))
            p(i,j).select();
            unfreezeColors();
            colormap(getColormap(opts{i,j}))
        end
    end
end

        
end
function ans = dec2rom(z)
d = [ 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
c =  {'m', 'cm', 'd', 'cd', 'c', 'xc', 'l', 'xl', 'x', 'ix', 'v', 'iv', 'i'};
[];
for ii = 1:numel(d)
    if z >= d(ii)    
        ans = [ans,repmat(c{ii},1,fix(z/d(ii)))];
        z = rem(z,d(ii));
    end
end
end