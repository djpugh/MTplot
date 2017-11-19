function [x,y,z,c,dA]=xyzc(MT,options,wave,corr)
%Evaluates the far field radiation pattern on a unit sphere
try
    N=options.Resolution;
catch
    N=100;
end
try
    Logarithm=options.Logarithm;
catch
    Logarithm=false;
end
try
    Abs=options.Abs;
catch
    Abs=false;
end
if nargin<4
    corr=1.0;
end
try
    snr=options.SNR;
catch
    snr=0;
end
%set up theta values
dt=2/(N-1);
%set up phi values
dp=2*pi/(N-1);
phi=reshape(kron(0:dp:2*pi,ones([N,1])),[1 N*N]);
theta=reshape(kron(acos(-1:dt:1),ones([N,1]))',[1 N*N]);
rvec=[sin(theta).*cos(phi);sin(theta).*sin(phi);cos(theta)];
tvec=[cos(theta).*cos(phi);cos(theta).*sin(phi);-sin(theta)];
pvec=[-sin(phi);cos(phi);zeros(1,N*N)];
x=reshape(rvec(1,:),[N N]);
y=reshape(rvec(2,:),[N N]);
z=reshape(rvec(3,:),[N N]);
dA=reshape(sin(theta)*dp*dt, [N N]);
c=getc(rvec,pvec,tvec,wave,MT,N,corr,snr,Abs);
if Logarithm
    c=log(abs(c));
end
end
function c=getc(rvec,pvec,tvec,wave,MT,N,corr,snr,Abs)
    if strcmp(wave,'S')
        c=corr*reshape(sqrt((sum(pvec.*(MT*rvec))).^2+(sum(tvec.*(MT*rvec))).^2),[N N]);
    elseif strcmp(wave,'SH')
        c=corr*reshape(sum(pvec.*(MT*rvec)),[N N]);
    elseif strcmp(wave,'SV')
        c=corr*reshape(sum(tvec.*(MT*rvec)),[N N]);
    elseif strcmp(wave,'P')
        c=corr*reshape(sum(rvec.*(MT*rvec)),[N N]);
    elseif numel(strfind(wave,'/'))
        [wave1,wave2]=strtok(wave,'/');
        wave2=strrep(wave2,'/','');
        if numel(corr)>1
            c1=getc(rvec,pvec,tvec,wave1,MT,N,corr(1),snr,Abs);
            c2=getc(rvec,pvec,tvec,wave2,MT,N,corr(2),snr,Abs);
        else
            c1=getc(rvec,pvec,tvec,wave1,MT,N,corr,snr,Abs);
            c2=getc(rvec,pvec,tvec,wave2,MT,N,corr,snr,Abs);
        end
        c=c1./c2;
    else
        error('MTplot:xyzcPhaseType',['Phase type ',wave,' not recognised'])
    end
    if Abs
        c=abs(c);
    end
    if any(strcmp(wave,{'P','S','SH','SV'}))&&snr>0;
        c(c<max(max(c))/snr)=max(max(c))/snr;
    end
end