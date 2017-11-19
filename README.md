MT Coordinate system used in this code 
    X=North, Y=East, Z=Down

Package Contents:

    MTplot:
        Plots the moment tensor radiation pattern in a variety of ways(for more help and commands use help MTplot)

    Conversions:
    MTconvert will convert any mt/focal plane input into all the different formats and return it as an MTresults class

    There are several functions to convert the moment tensor to different formats i.e.
        Strike, Dip and Rake, or Fault Plane Normals, or TNP axes:
            MT2SDR:     Moment Tensor to Strike, Dip and Rake
                MT2TNPE     Moment Tensor to T, N ,P axes and Eigenvalues
                TP2FP       T,P axes to Fault Plane Normals
                FP2SDR      Fault Plane Normals to Strike, Dip and Rake
            SDR2MT:     Converts Strike, Dip and Rake to Moment Tensor
            SDR2FP:     Converts Strike, Dip and Rake to Fault Plane Normals
            FP2TNP:     Converts Fault Plane Normals to T, N, P axes
            TNPE2MT:    Converts T, N, P axes and Eigenvalues to the Moment Tensor

            convert2voigt:  Converts MT or C tensor to (modified) voigt form
            voigt2MT:   Converts (modified) voigt form of MT to the 3x3 MT
            MTC2D:  Converts MT and C to Potency Tensor
            MT2BiAxes:  Converts MT and C to the BiAxes information of area displacement, isotropic volume and the biaxes
            D2TNPE:     Converts D to TNPE
            MT2Tape:    Converts MT to the Tape parameters (gamma,delta,kappa,sigma,h)

    Omega: Calculates the 6-angle between two moment tensors in radians.

    poissonRatio: Calculates the exact (isotropic material) or approximate poissons ratio (following Chapman and Leaney, 2011 eqs. 81a and b) for either lambda and mu or the full 21 
                    component stiffness vector
    isotropicC: Calculates the full 21 component stiffness vector for an isotropic lambda and mu

    VTIC: Calculates the full 21 component stiffness vector for the 6 VTI stiffness parameters: C11,C12,C13,C33,C44,C66


    Test:   Runs a test on an input using these functions to convert Strike, Dip and Rake to the MT and back, or the MT to Strike, Dip and Rake and back
            and compares the differences.
            Uses SDRtest and MTtest

    ExampleConvert:     Example Script for running batch conversion and outputting to file.
                            Input needs to be written by the user - dependent on format

    The code needs the panel package (from mathworks central).
            
There is some additional functionality designed to work well with mtfit.

*N.B. This code was written as part of a PhD project and is not under active development or support.*