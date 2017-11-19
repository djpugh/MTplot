function [ratio,lnpDC,lnpMT,pDC,pMT]=DCMTEvidenceComparison(fname,relative,rep)
if nargin<2
    relative=false;
end
if nargin<3
    rep={'',''};
end
DCFile=strrep(fname,'MT.mat','DC.mat');
Ev=load(DCFile,'Events');
DCEvents=Ev.Events;
MTFile=strrep(DCFile,[rep{1},'DC.mat'],[rep{2},'MT.mat']);
Ev=load(MTFile,'Events');
MTEvents=Ev.Events;
if relative
 [DCEvents,~]=split_joint_pdf(DCEvents);
 [MTEvents,~]=split_joint_pdf(MTEvents);
 ratio=zeros(size(DCEvents));
 lnpDC=zeros(size(DCEvents));
 lnpMT=zeros(size(DCEvents));
 pDC=zeros(size(DCEvents));
 pMT=zeros(size(DCEvents));
 for i=1:size(DCEvents,1);
    for j=1:size(DCEvents,2);
        [ratio(i,j),lnpDC(i,j),lnpMT(i,j),pDC(i,j),pMT(i,j)]=comparison(DCEvents{i,j},MTEvents{i,j});
    end
 end
else
 [ratio,lnpDC,lnpMT,pDC,pMT]=comparison(DCEvents,MTEvents);
end
end
function [ratio,lnpDC,lnpMT,pDC,pMT]=comparison(DCEvents,MTEvents)
NDC=double(DCEvents.NSamples);
DC=[log((sum(exp(DCEvents.ln_pdf-max(DCEvents.ln_pdf))))),max(DCEvents.ln_pdf)-log(NDC)];
NMT=double(MTEvents.NSamples);
MT=[log((sum(exp(MTEvents.ln_pdf-max(MTEvents.ln_pdf))))),max(MTEvents.ln_pdf)-log(NMT)];
lnpDC=(DC(1)+DC(2));
lnpMT=(MT(1)+MT(2));
ratio=DC(1)+DC(2)-MT(1)-MT(2);
ratio=exp(ratio);
pDC=exp(lnpDC-max([lnpDC,lnpMT]))/(exp(lnpDC-max([lnpDC,lnpMT]))+exp(lnpMT-max([lnpDC,lnpMT])));
pMT=exp(lnpMT-max([lnpDC,lnpMT]))/(exp(lnpDC-max([lnpDC,lnpMT]))+exp(lnpMT-max([lnpDC,lnpMT])));
end