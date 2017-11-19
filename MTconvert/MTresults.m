classdef MTresults
%Contains all results from the moment tensor conversions.
%
%    Properties are:
%         Strike0           Initial Strike - empty if unspecified
%         Dip0              Initial Dip - empty if unspecified
%         Rake0             Initial Rake - empty if unspecified
%         MT                3x3 Full MT matrix
%         T                 T axis (eigenvector)
%         N                 N axis (eigenvector)
%         P                 P axis (eigenvector)
%         E                 Eigenvectors - array as [v1,v2,v3]
%         N1                Fault Plane 1 Normal
%         N2                Fault Plane 2 Normal
%         Strike1           Strike of Fault Plane 1 in degrees
%         Dip1              Dip of Fault Plane 1 in degrees
%         Rake1             Rake of Fault Plane 1 in degrees
%         Strike2           Strike of Fault Plane 2 in degrees
%         Dip2              Dip of Fault Plane 2 in degrees
%         Rake2             Rake of Fault Plane 2 in degrees
%         Ta                Strike and Dip of the Tension axis in degrees
%         Na                Strike and Dip of the Neutral axis in degrees
%         Pa                Strike and Dip of the Pressure axis in degrees
%         N1a               Strike and Dip of the Fault Plane 1 Normal in degrees
%         N2a               Strike and Dip of the Fault Plane 2 Normal in degrees
%         Isotropic         Isotropic component of the MT
%         Deviatoric        Deviatoric Component of the MT
%         TripleDipole      Deviatoric Decomposition into 3 Dipoles
%         TripleDC          Deviatoric Decomposition into 3 DCs
%         TripleCLVD        Deviatoric Decomposition into 3 CLVDs
%         MajMinDC          Deviatoric Decomposition into Major and Minor DCs
%         DCCLVD            Deviatoric Decomposition into DC & CLVD
%         Epsilon           Deviation of Source From Pure DC 
%         Explosive         Explosive component from BiAxes Decomposition
%         BiAxes            BiAxes
%         AreaDisplacement  Area x Displacement from BiAxes Decomposition
%         MotionAngle       Motion Angle from BiAxes Decomposition
%         MotionType        Motion Type from BiAxes Decomposition
%         Gamma             Tape and Tape 2012 Parameterisation - Source Longitude in radians on Fundamental Lune from -pi/6 to pi/6
%         Beta              Tape and Tape 2012 Parameterisation - Source Colatitude in radians on Fundamental Lune from 0 to pi
%         Delta             Tape and Tape 2012 Parameterisation - Source Latitude in radians on Fundamental Lune from -pi/2 to pi/2
%         Kappa             Tape and Tape 2012 Parameterisation - Strike in radians from 0 to 2pi
%         Sigma             Tape and Tape 2012 Parameterisation - Slip in radians from -pi/2 to pi/2
%         h                 Tape and Tape 2012 Parameterisation - Cosine Dip 0 to 1
%         CosAlpha          Cosine of the opening angle alpha for the basic CDC model 0 to 1
%         Poisson           Poisson Ratio From basic CDC model
%
% Coordinates are x=North, y=East, z=Down
% 

%
% Properties are set using setNew method to set all the properties
% evaluated, and if an initial strike, dip and rake are provided this can
% be set to strike0, dip0 and rake0 using setInitial
    properties
        Strike0 %Initial Strike - empty if unspecified
        Dip0 %Initial Dip - empty if unspecified
        Rake0 %Initial Rake - empty if unspecified
        MT %3x3 Full MT matrix
        T %T axis (eigenvector)
        N %N axis (eigenvector)
        P %P axis (eigenvector)
        E %Eigenvectors - array as [v1,v2,v3]
        N1 %Fault Plane 1 Normal
        N2 %Fault Plane 2 Normal
        Ta %Strike and Dip of the Tension axis in degrees
        Na %Strike and Dip of the Neutral axis in degrees
        Pa %Strike and Dip of the Pressure axis in degrees
        N1a %Strike and Dip of the Fault Plane 1 Normal axis in degrees
        N2a %Strike and Dip of the Fault Plane 2 Normal axis in degrees
        Strike1 %Strike of Fault Plane 1 in degrees
        Dip1 %Dip of Fault Plane 1 in degrees
        Rake1 %Rake of Fault Plane 1 in degrees
        Strike2 %Strike of Fault Plane 2 in degrees
        Dip2 %Dip of Fault Plane 2 in degrees
        Rake2 %Rake of Fault Plane 2 in degrees
        Isotropic %Isotropic component of the MT
        Deviatoric %Deviatoric component of the MT
        TripleDipole %Deviatoric Decomposition into 3 Dipoles (Jost and Hermann, 1989)
        TripleDC %Deviatoric Decomposition into 3 DCs (Jost and Hermann, 1989)
        TripleCLVD %Deviatoric Decomposition into 3 CLVDs (Jost and Hermann, 1989)
        MajMinDC %Deviatoric Decomposition into Major and Minor DCs (Jost and Hermann, 1989)
        DCCLVD %Deviatoric Decomposition into DC & CLVD (Jost and Hermann, 1989)
        Epsilon %Deviation of Source From Pure DC 
        Explosive %Explosive component from BiAxes Decomposition (Chapman and Leaney, 2011)
        BiAxes %Bi-Axes (Chapman and Leaney, 2011)
        AreaDisplacement %Area x Displacement from BiAxes Decomposition (Chapman and Leaney, 2011)
        MotionAngle %Motion Angle from BiAxes Decomposition (Chapman and Leaney, 2011)
        MotionType %Motion Type from BiAxes Decomposition (Chapman and Leaney, 2011)
        Gamma %Source Longitude in radians on Fundamental Lune from -pi/6 to pi/6 (Tape and Tape, 2012)
        Beta %Source Colatitude in radians on Fundamental Lune from 0 to pi (Tape and Tape, 2012)
        Delta %Source Latitude in radians on Fundamental Lune from -pi/2 to pi/2 (Tape and Tape, 2012)
        Kappa %Strike in radians from 0 to 2pi (Tape and Tape, 2012)
        Sigma %Slip in radians from -pi/2 to pi/2 (Tape and Tape, 2012)
        h %Cosine Dip 0 to 1 (Tape and Tape, 2012)
        CosAlpha %Cosine of the opening angle alpha for the basic CDC model 0 to 1  (Tape and Tape, 2013, Minson et al., 2007)
        Poisson %Poisson Ratio From basic CDC model (Tape and Tape, 2013, Minson et al., 2007)
        perc_DC %Percentage DC according to Vavrycuk 2001
        perc_CLVD %Percentage CLVD according to Vavrycuk 2001
        perc_ISO %Percentage ISO according to Vavrycuk 2001 sign gives ex/implosive
        cdc_xi % CDC estimate of DC
    end
    methods
        function obj=setNew(obj,MT,T,N,P,E,N1,N2,strike1,dip1,rake1,strike2,dip2,rake2,Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon,gamma,delta,kappa,sigma,h,cosalpha,poisson)
            obj.MT=MT;
            obj.T=T;
            obj.N=N;
            obj.P=P;
            obj.E=E;
            obj.N1=N1;
            obj.N2=N2;
            obj.Strike1=strike1;
            obj.Dip1=dip1;
            obj.Rake1=rake1;
            obj.Strike2=strike2;
            obj.Dip2=dip2;
            obj.Rake2=rake2;
            obj.Isotropic=Isotropic;
            obj.Deviatoric=Deviatoric;
            obj.TripleDipole=TripleDipole;
            obj.TripleDC=TripleDC;
            obj.TripleCLVD=TripleCLVD;
            obj.MajMinDC=MajMinDC;
            obj.DCCLVD=DCCLVD;
            obj.Epsilon=epsilon;
            obj=anglesCalculations(obj);
            obj.MotionAngle=(acos(sum(obj.BiAxes(:,1).*obj.BiAxes(:,2)))/2)*180/pi;
            if obj.MotionAngle==0 || obj.MotionAngle==90
                obj.MotionType='Dipole';
            elseif obj.MotionAngle==45
                obj.MotionType='Double-Couple'   ;             
            elseif obj.MotionAngle>45
                obj.MotionType='Closing';
            elseif obj.MotionAngle<45
                obj.MotionType='Opening';
            end
            obj.Gamma=gamma;
            obj.Beta=pi/2-delta;
            obj.Delta=delta;
            obj.Kappa=kappa;
            obj.Sigma=sigma;
            obj.h=h;
            obj.CosAlpha=cosalpha;
            obj.Poisson=poisson;
            obj.perc_ISO=100*(sum(E)/(3))/abs(max(abs(E-sum(E)/3)));
            obj.perc_CLVD=2*epsilon*(100-abs(obj.perc_ISO));
            obj.perc_DC=(100-abs(obj.perc_ISO)-abs(obj.perc_CLVD));
            E=E/sqrt(sum(E.^2));
            obj.cdc_xi=sqrt(2*(E(1)-E(2))*(E(2)-E(3)));
            

        end
        function obj=MTresults(MT,T,N,P,E,N1,N2,strike1,dip1,rake1,strike2,dip2,rake2,Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon,gamma,delta,kappa,sigma,h,cosalpha,poisson)
            if nargin>0
                obj=setNew(obj,MT,T,N,P,E,N1,N2,strike1,dip1,rake1,strike2,dip2,rake2,Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon,gamma,delta,kappa,sigma,h,cosalpha,poisson );
            end
        end

        function obj=setInitial(obj,strike0,dip0,rake0)
            obj.Strike0=strike0;
            obj.Dip0=dip0;
            obj.Rake0=rake0;
        end

        function obj=anglesCalculations(obj)
            obj.Ta=obj.dipStrike(obj.T);
            obj.Na=obj.dipStrike(obj.N);
            obj.Pa=obj.dipStrike(obj.P);
            obj.N1a=obj.dipStrike(obj.N1);
            obj.N2a=obj.dipStrike(obj.N2);
        end
        function string=str(obj,format)
            if strcmp(format,'simple')
                string=sprintf('%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f',obj.Strike1,obj.Dip1,obj.Rake1,obj.Strike2,obj.Dip2,obj.Rake2,obj.N1a(1),obj.N1a(2),obj.N2a(1),obj.N2a(2),obj.Ta(1),obj.Ta(2),obj.Na(1),obj.Na(2),obj.Pa(1),obj.Pa(2)');
            elseif strcmp(format,'extended')
                string=sprintf('%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f',obj.Strike0,obj.Dip0,obj.Rake0,obj.Strike1,obj.Dip1,obj.Rake1,obj.Strike2,obj.Dip2,obj.Rake2,obj.N1a(1),obj.N1a(2),obj.N2a(1),obj.N2a(2),obj.Ta(1),obj.Ta(2),obj.Na(1),obj.Na(2),obj.Pa(1),obj.Pa(2),obj.N1(1),obj.N1(2),obj.N1(3),obj.N2(1),obj.N2(2),obj.N2(3),obj.T(1),obj.T(2),obj.T(3),obj.N(1),obj.N(2),obj.N(3),obj.P(1),obj.P(2),obj.P(3)');
            else
                error('visualisations:FormatCheckFail','Format not recognised');
            end
        end
    end
    methods (Static)
        function v2=dipStrike(v1)
            strike=(atan2(v1(2),v1(1)))*180/pi;
           
            dip=asind(v1(3));
            if dip<0
                dip=-dip;
                strike=strike+180;
            end
            if strike<0
                strike=strike+360;
            elseif strike>360
                strike=strike-360;
            end
            v2=[strike,dip];
        end
        function head=header(format)
            if strcmp(format,'simple')
                head='Strike1,Dip1,Rake1,Strike2,Dip2,Rake2,N1azimuth,N1plunge,N2azimuth,N2plunge,Tazimuth,Tplunge,Nazimuth,Nplunge,Pazimuth,Pplunge\n';
            elseif strcmp(format,'extended')
                head='Strike0,Dip0,Rake0,Strike1,Dip1,Rake1,Strike2,Dip2,Rake2,N1azimuth,N1plunge,N2azimuth,N2plunge,Tazimuth,Tplunge,Nazimuth,Nplunge,Pazimuth,Pplunge,N11,N12,N13,N21,N22,N23,T1,T2,T3,N1,N2,N3,P1,P2,P3\n';
            else
                error('visualisations:FormatCheckFail','Format not recognised');
            end
        end

    end
end

