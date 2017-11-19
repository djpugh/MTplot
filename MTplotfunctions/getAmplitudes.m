function [x,y,z,c1,c2,dA]=getAmplitudes(MT,options)
    if ~options.P
        [~,~,~,c1,~]=xyzc(MT,options,'SH');
        [x,y,z,c2,dA]=xyzc(MT,options,'SV');
    elseif options.P && options.SV
        [~,~,~,c1,~]=xyzc(MT,options,'P');
        [x,y,z,c2,dA]=xyzc(MT,options,'SV');
    elseif options.P && options.S
        [~,~,~,c1,~]=xyzc(MT,options,'P');
        [x,y,z,c2,dA]=xyzc(MT,options,'S');
    else
        [~,~,~,c1,~]=xyzc(MT,options,'P');
        [x,y,z,c2,dA]=xyzc(MT,options,'SH');
    end
end