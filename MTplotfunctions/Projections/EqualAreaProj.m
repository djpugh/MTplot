function [X,Y,Z]=EqualAreaProj(x,y,z,options)
    %Lambert azimuthal equal area projection.
    if nargin<4
        options.Lower=true;
        options.FullSphere=false;
        options.ProjectionAxis=false;
    end
    if size(options.ProjectionAxis,1)==3
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
        %N.B correction is to account for NEDown axis basis
        X=x.*sqrt(2./(1+z));
        Y=y.*sqrt(2./(1+z));
        if ~options.FullSphere
            X(z<0)=NaN;
            Y(z<0)=NaN;
        end
    else
        X=x.*sqrt(2./(1-z));
        Y=y.*sqrt(2./(1-z));
        if ~options.FullSphere
            X(z>0)=NaN;
            Y(z>0)=NaN;
        end
    end
% Not needed as rotated frame is desired frame
%     if options.ProjectionAxis
%         v=R'*[X;Y;Z];
%         X=v(1,:);
%         Y=v(2,:);
%         Z=v(3,:);
%     end
    Z=zeros(size(X));
    X(isinf(X))=NaN;
    Y(isinf(Y))=NaN;
    Z(isinf(Z))=NaN;
    
end