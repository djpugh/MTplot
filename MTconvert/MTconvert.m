function results=MTconvert(mt,varargin)
% Converts input into all forms and decompositions of the moment tensor,returning an <a href="matlab:help MTRESULTS">MTresults</a> object
%
%   Coordinates are x=North, y=East, z=Down
%
% Inputs are either the full Moment Tensor (3x3 Matrix) or the symmetric
% moment tensor elements as [Mxx Myy Mzz Mxy Mxz Myz] or the Strike, Dip 
% and Rake.
%
% Returns an <a href="matlab:help MTRESULTS">MTresults</a> object with all the information inside it
%
%
%
% See also MTRESULTS
try
    [options,~]=Parser(varargin{:});
    MT=MTcheck(mt);
catch ME
    if strcmpi(ME.message,'Not enough input arguments.')
        help MTconvert
    end
    ME.rethrow()
end
if strcmpi(char(class(MT)),'cell')
n=length(MT);
results(1,n)=MTresults();
for i=1:n
    results(1,i)=MTconvert(MT{i},varargin{:});
end
else
[T,N,P,E]=MT2TNPE(MT);
[N1,N2]=TP2FP(T,P);
[strike1,dip1,rake1,strike2,dip2,rake2]=MT2SDR(MT);
[gamma,delta,kappa,sigma,h]=MT2Tape(MT);
[Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon]=MTDecomp(MT);
cosalpha=-sqrt(3)*tan(gamma);
poisson=(1+sqrt(2)*(tan((pi/2)-delta).*sin(gamma)))./(2-(sqrt(2)*(tan((pi/2)-delta).*sin(gamma))));
results=MTresults(MT,T,N,P,E,N1,N2,strike1,dip1,rake1,strike2,dip2,rake2,Isotropic,Deviatoric,TripleDipole,TripleDC,TripleCLVD,MajMinDC,DCCLVD,epsilon,gamma,delta,kappa,sigma,h,cosalpha,poisson);
if size(mt)==[1,3]
    strike0=mt(1);
    dip0=mt(2);
    rake0=mt(3);
    results=results.setInitial(strike0,dip0,rake0);
end
end
end
function [options,unmatched]=Parser(varargin)
parser=inputParser();
parser.KeepUnmatched=true;
parser.addParamValue('C',[3,1,1,0,0,0,...
                            3,1,0,0,0,...
                              3,0,0,0,...
                                1,0,0,...
                                  1,0,...
                                    1],@(x) isnumeric(x) &&length(x)==21);
parser.parse(varargin{:});
options=parser.Results;
unmatched=parser.Unmatched;
end
              