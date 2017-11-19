function MT=BiAxes2MT(Phi,C)
if nargin<2
    C=isotropicC();
end
D=BiAxes2D(Phi);
MT=voigt2MT(convert2voigt(C)*convert2voigt(D));
end