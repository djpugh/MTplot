function [X,Y,Z]=EqualAngleProj(x,y,z,options)
    %Equal Angle Stereographic Projection.
    if nargin<4
        options.Lower=true;
        options.FullSphere=false;
        options.ProjectionAxis=false;
    end
    if options.ProjectionAxis
        rAxis=cross(options.ProjectionAxis,[0;0;1]);
        theta=-asin(sqrt(sum(rAxis.^2))/(sqrt(sum(options.ProjectionAxis.^2))));
        rAxis=rAxis/sqrt(sum(rAxis.^2));
        rX=rAxis(1);
        rY=rAxis(2);
        rZ=rAxis(3);
        R=[1,0,0;0,1,0;0,0,1]*cos(theta)+sin(theta)*[0,-rZ,rY;rZ,0,-rX;-rY,rX,0]+(1-cos(theta))*(rAxis*rAxis');
        v=R*[x;y;z];
        x=v(1,:);
        y=v(2,:);
        z=v(3,:);
    end
	if options.Lower
		X=x./(z+1);
		Y=y./(z+1);
        if ~options.FullSphere
            X(z<0)=NaN;
            Y(z<0)=NaN;
        end
	else
		X=x./(1-z);
		Y=y./(1-z);
        if ~options.FullSphere
             X(z>0)=NaN;
             Y(z>0)=NaN;
              
        end
    end
    Z=zeros(size(X));
    X(isinf(X))=NaN;
    Y(isinf(Y))=NaN;
    Z(isinf(Z))=NaN;
end