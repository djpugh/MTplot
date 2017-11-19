function [x,y,z,c]=EventSuperposition(XLocations,YLocations,ZLocations,MTLocations,options)
%Coordinates relative to origin (centre of event cluster)
if nargin<5
    options=1;
end
try
    N=options.Resolution;
catch
    N=100;
end
dA=ones(N,N);
%set up theta values
dt=pi/(N-1);
%set up phi values
dp=2*pi/(N-1);
phi=reshape(kron(0:dp:2*pi,ones([N,1])),[1 N*N]);
theta=reshape(kron(0:dt:pi,ones([N,1]))',[1 N*N]);
%calculate Events centroid
M0=zeros(size(XLocations));
for i=1:length(XLocations)
    M0(i)=sqrt(sum(sum(MTcheck(MTLocations{i}).^2)));
end
M0;
x0=sum(M0.*XLocations)/sum(M0);
y0=sum(M0.*YLocations)/sum(M0);
z0=sum(M0.*ZLocations)/sum(M0);
XLocations=XLocations-x0;
YLocations=YLocations-y0;
ZLocations=ZLocations-z0;
R0=10000*max(sqrt(XLocations.^2+YLocations.^2+ZLocations.^2));
x=R0*sin(theta).*cos(phi);
y=R0*sin(theta).*sin(phi);
z=R0*cos(theta);
c=0*z;
for i=1:length(XLocations)
    MTEv=MTcheck(MTLocations{i});
    R=sqrt(((x-XLocations(i)).^2)+((y-YLocations(i)).^2)+((z-ZLocations(i)).^2));
    rVecEv=[(x-XLocations(i))./R;(y-YLocations(i))./R;(z-ZLocations(i))./R];
    cEv=(sum(rVecEv.*(MTEv*rVecEv)))./R;
    c=c+cEv;
%     figure()
%     surf(reshape(x./R0,[N,N]),reshape(y./R0,[N,N]),reshape(z./R0,[N,N]),reshape(c,[N,N]),'EdgeColor','None');
%     shading interp
%     figure()
%     surf(reshape(x./R0,[N,N]),reshape(y./R0,[N,N]),reshape(z./R0,[N,N]),reshape(cEv,[N,N]),'EdgeColor','None');
%     shading interp
end
x=reshape(x./R0,[N,N]);
y=reshape(y./R0,[N,N]);
z=reshape(z./R0,[N,N]);
c=reshape(c,[N,N]);
    



end