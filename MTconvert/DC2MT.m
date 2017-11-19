 function MT = DC2MT( D,C,isotropic )
 if nargin<3
     isotropic=0;
 end
 if nargin<2
     C=isotropicC();
 end
 if iscell(D)
     for i=1:numel(D)
         if iscell(isotropic)
             iso=isotropic{i};
         else
             iso=isotropic;
         end
         MT{i}=DC2MT( D{i},C,iso);
     end
     MT=reshape(MT,size(D,1),size(D,2));
 else
    MT=voigt2MT(convert2voigt(C)*(convert2voigt(D)+isotropic*[ 1;1;1; 0;0;0]));
 end
