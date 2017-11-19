 function [T,N,P,E] = D2TNPE( MT,C,isotropic )
  % Convert MT C and the isotropic component to Potency and then to Principle Axes and Eigenvalues 
  %
  %  potency = compliance*(moment-isotropic*[ 1;1;1; 0;0;0]);
  %
  % Input:    isotropic   = isotropic part to remove
  %
  % Internal: moment(6)   = modified moment tensor
  %           voigt(6,6)  = modified Voigt matrix (SWP 4.1.14)
  %
  % Output:   TNP(3,3)    = principal vectors for ordered values
  %           Lambdas(3)  = ordered (decreasing) principal values
  %
  %
  D=MTC2D(MT,C,isotropic);
  if (sqrt(sum(sum(D.^2)))==0)      % happens for explosion
    T = zeros(3,1);
    N = zeros(3,1);
    P = zeros(3,1);
    E = zeros(3,1);
  else
    D=voigt2MT(D);
    [T,N,P,E]=MT2TNPE(D);
  end
  end
