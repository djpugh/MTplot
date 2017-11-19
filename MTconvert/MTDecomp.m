function [Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon]=MTDecomp( MT )
%Decompose the Moment Tensor into the Isotropic and Deviatoric Components, and then further decompose the deviatoric component according to Jost and Hermann SRL 1989
%
MT=MTcheck(MT);
%Diagonalise MT
[R,M]=eigs(MT,3,'lm');
Isotropic=symm(R*(1/3)*trace(M)*eye(3)*R');
Deviatoric=(M-Isotropic);
VM=diag(M);
VDev=diag(Deviatoric);
Deviatoric=symm(R*Deviatoric*R');
TripleDipole={symm(R*VDev(1)*[1,0,0;0,0,0;0,0,0]*R'),...
    symm(R*VDev(2)*[0,0,0;0,1,0;0,0,0]*R'),symm(R*VDev(3)*[0,0,0;0,0,0;0,0,1]*R')};
TripleDC={symm(R*(1/3)*MTcheck([VM(1)-VM(2),-VM(1)+VM(2),0,0,0,0])*R'),...
    symm(R*(1/3)*MTcheck([0,VM(2)-VM(3),-VM(2)+VM(3),0,0,0])*R'),...
    symm(R*(1/3)*MTcheck([VM(1)-VM(3),0,-VM(1)+VM(3),0,0,0])*R')};
TripleCLVD={symm(R*(1/3)*VM(1)*MTcheck([2,-1,-1,0,0,0])*R'),...
    symm(R*(1/3)*VM(2)*MTcheck([-1,2,-1,0,0,0])*R'),symm(R*(1/3)*VM(3)*MTcheck([-1,-1,2,0,0,0])*R')};
% Ordering of eigenvalues is |m1*|>=|m2*|>=|m3*|
%Take eigenvector of m3* to be null direction (N axis)
MajMinDC={symm(R*MTcheck([VDev(1),-VDev(1),0,0,0,0])*R'),symm(R*MTcheck([0,-VDev(3),+VDev(3),0,0,0])*R')};
F=-VDev(3)/VDev(1);
DCCLVD={symm(R*VDev(1)*(1-2*F)*MTcheck([1,-1,0,0,0,0])*R'),symm(R*VDev(1)*F*MTcheck([2,-1,-1,0,0,0])*R')};
epsilon=-min(abs(VDev))/abs(max(abs(VDev)));

end

function MT=symm(MT)
% Corrections to account for numerical errors - take upper triangle of each
% part and reconvert to the matrix - makes sure it is symmetrical
    MT=MTcheck([MT(1,1), MT(2,2), MT(3,3), sqrt(2)*MT(1,2), sqrt(2)*MT(1,3), sqrt(2)*MT(2,3)]);
end