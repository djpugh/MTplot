function LocationBeachBalls(MT,h,options)
MT=MTcheck(MT);
if strcmp(char(class(MT)),'cell')
    imax=max(size(MT));
else
    MT={MT};
    imax=1;
end
set(0, 'currentfigure', h)
maxc=0;
hold on;
scale=min([diff(options.Locations(:,1)),diff(options.Locations(:,2)),diff(options.Locations(:,3))])/10;
for i=1:imax    
    [x,y,z,c,~]=xyzc(MT{i},options,options.Phase);
    [X,Y,Z]=options.ProjFn(x,y,z,options);
    X=scale*X+options.Locations(i,1);
    Y=scale*Y+options.Locations(i,2);
    Z=scale*Z+options.Locations(i,3);
    maxc=max([abs(max(max(c))), abs(min(min(c))),maxc]);
    surf(X,Y,Z,c);
    shading interp;
end
hold off
colormap(options.Colormap)
%Set the c scale to be symmetrical
caxis([-maxc maxc]);

end