% MTCONVERT
%
% Files
%   BasicCDC2MT   - Convert opening angle, strike, dip, rake and poisson ratio (default =0.25) to full moment tensor
%   convert2voigt - Convert elastic parameters to voigt form or MT to modified voigt form
%   D2TNPE        - Convert MT C and the isotropic component to Potency and then to Principle Axes and Eigenvalues 
%   E2GD          - Convert Eigenvalues to Gamma and Delta from Tape and Tape GJI 2012
%   FP2SDR        - Calculate strike, dip and rake in degrees for a normal and slip vector
%   FP2TNP        - Converts fault plane normals to the T, N, P axes
%   GD2E          - Convert Gamma and Delta (Tape and Tape GJI 2012) to Eigenvalues
%   MT2SDR        - Calculate the strike dip and rake of the fault planes from the moment tensor using MT2TNPE, TP2FP and FP2SDR
%   MT2Tape       - Converts a moment tensor to the Tape parameterisation, gamma, delta, kappa, h and sigma using MT2TNPE, E2GD, TP2FP and MT2SDR
%   MT2TNPE       - Converts a moment tensor to the T, N, P axes and the eigenvalues
%   MTC2D         - Convert MT, C and isotropic component to the potency tensor
%   MTconvert     - Converts input into all forms and decompositions of the moment tensor,returning an MTRESULTS object
%   MTDecomp      - Decompose the Moment Tensor into the Isotropic and Deviatoric Components, and then further decompose the deviatoric component according to Jost and Hermann SRL 1989
%   MTresults     - Contains all results from the moment tensor conversions.
%   MTtest        - Test code for converting a moment tensor to strike dip rake and back.
%   SDR2FP        - Convert strike, dip and rake to the slip and normal for a plane (i.e. the normals to the fault and auxiliary planes)
%   SDR2MT        - Converts strike dip and rake to the full moment tensor
%   SDR2SDR       - Convert Strike, Dip and Rake of one plane to Strike, Dip and Rake of the other
%   SDRtest       - Test the functions for calculating the strike, dip and rake from a full MT
%   SDSD2FP       - Convert Fault and auxiliary plane Strike and Dip pairs to slip and normal vectors
%   SDSD2MT       - Convert Fault and auxiliary plane Strike and Dip pairs to full moment tensor
%   Tape2MT       - Convert Tape and Tape Parameters gamma, delta, kappa, h and sigma to Moment Tensor 
%   Tape2TNPE     - Convert Tape and Tape Parameters gamma, delta, kappa, h and sigma to Tension, Neutral, Pressure and Eigenvalues 
%   ConvertTest   - Test moment tensor to strike dip rake code
%   TNPE2MT       - Calculate the moment tensor from the T,N,P axes(eigenvectors), and E, the eigenvalues.
%   TP2FP         - Calculate the normals to the fault and auxiliary planes from the T and P axes.
%   voigt2MT      - Converts Voigt form Moment Tensor to 3x3 Moment Tensor
% 
%
% Main function to use is MTconvert (See below) which returns an <a href="matlab:help MTRESULTS">MTresults</a> object
% Other functions are helper functions and conversion function
