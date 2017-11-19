function D=MTC2D(MT,C,isotropic)
if nargin<3
    isotropic=0;
end
%Convert MT, C and isotropic component to the potency tensor
if iscell(MT)
    for i=1:numel(MT)
    if iscell(isotropic)
        iso=isotropic{i};
    else
        iso=isotropic;
    end
        D{i}=MTC2D(MT{i},C,iso);
    end
    D=reshape(D,size(MT,1),size(MT,2));
else    
D=voigt2MT(convert2voigt(C)\(convert2voigt(MT)-isotropic*[ 1;1;1; 0;0;0]));
end



