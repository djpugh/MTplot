function AmplitudePlot(MT,h,options)
    MT=MTcheck(MT);
    if options.Superposition
        [x,y,z,c]=EventSuperposition(options.Locations(:,1)',options.Locations(:,2)',options.Locations(:,3)',MT,options);
    else
        [x,y,z,c,~]=xyzc(MT,options,options.Phase);
    end
    [X,Y,Z]=options.ProjFn(x,y,z,options);
    maxc=max([abs(max(max(c))), abs(min(min(c)))]);
    set(0, 'currentfigure', h)
    if strcmpi(options.Mode,'beachball')
        surf(X,Y,Z,c);
    elseif strcmpi(options.Mode,'radiation')        
        if options.Resolution>100
            edgecolor='None';
        else
            edgecolor='Black';
        end
        surf(abs(c).*X,abs(c).*Y,abs(c).*Z,c,'FaceColor','interp','EdgeColor',edgecolor);   
    end
    shading interp;
    colormap(options.Colormap)
    if options.AxisTitle && ~options.Superposition
        title({[regexprep(options.Mode,'(\<[a-z])','${upper($1)}'),' Plot for Moment Tensor:'];[mat2str(MT(1)),'  ',mat2str(MT(2)),'  ',mat2str(MT(3))];[mat2str(MT(4)),'  ',mat2str(MT(5)),'  ',mat2str(MT(6))];[mat2str(MT(7)),'  ',mat2str(MT(8)),'  ',mat2str(MT(9))]}); 
    end
    %Set the c scale to be symmetrical
    caxis([-maxc maxc]);
    set(gca,'CLim',[-maxc maxc])
    %Plotting parameters
    %Number handling from the transformations - deal with INFs
    %Rescale the axes if necessary
    Xmax=1.3*(max(max(abs(X))));
    Ymax=1.3*(max(max(abs(Y))));
    Zmax=1.3*(max(max(abs(Z))));
    if strcmpi(options.Dimension,'3d')&&strcmpi(options.Mode,'beachball')
        xlim([-1.1,1.1])
        ylim([-1.1,1.1])
        zlim([-1.1,1.1])
    end
    if options.FP
        FaultPlanePlot(MT,h,options);
    end
    if strcmpi(options.Dimension,'2d')&&islogical(options.Contour)&&options.Contour
        hold on
        contour(X,Y,c,'-.k');
        hold off
    end
