function [gamma,delta,kappa,sigma,h]=MT2Tape(MT)
% Converts a moment tensor to the Tape parameterisation, gamma, delta, kappa, h and sigma using MT2TNPE, E2GD, TP2FP and MT2SDR
%
% Input is the Moment Tensor
%
%   Coordinates are x=North, y=East, z=Down
%
MT=MTcheck(MT);
if isstruct(MT)&& any(strcmpi('g',fieldnames(MT)))&&any(strcmpi('d',fieldnames(MT)))&&any(strcmpi('k',fieldnames(MT)))&&...
        any(strcmpi('s',fieldnames(MT)))&&any(strcmpi('h',fieldnames(MT)))
        gamma=MT.g;
        delta=MT.d;
        kappa=MT.k;
        sigma=MT.s;
        h=MT.h;
        return
elseif isstruct(MT)&& any(strcmpi('g',fieldnames(MT)))&&any(strcmpi('d',fieldnames(MT)))&&any(strcmpi('S1',fieldnames(MT)))&&...
        any(strcmpi('D1',fieldnames(MT)))&&any(strcmpi('R1',fieldnames(MT)))&&any(strcmpi('S2',fieldnames(MT)))&&...
        any(strcmpi('D2',fieldnames(MT)))&&any(strcmpi('R2',fieldnames(MT)))
    gamma=MT.g;
    delta=MT.d;
    strike=mod(MT.S1.*(abs(MT.R1)<90)+MT.S2.*(abs(MT.R2)<90),360);
    dip=MT.D1.*(abs(MT.R1)<90)+MT.D2.*(abs(MT.R2)<90);
    sigma=(MT.R1.*(abs(MT.R1)<90)+MT.R2.*(abs(MT.R2)<90))*pi/180;
    kappa=pi*strike/180;
    h=cosd(dip);
    return
elseif isstruct(MT)
    MT=MTcheck(MT.MTSpace);
end
if ~iscell(MT)
    [~,~,~,sigma]=MT2TNPE(MT);
    [gamma,delta]=E2GD(sigma);
    [strike1,dip1,rake1,strike2,dip2,rake2]=MT2SDR(MT);
    strike=mod(strike1.*(abs(rake1)<=90)+strike2.*(abs(rake2)<90),360);
    dip=dip1.*(abs(rake1)<=90)+dip2.*(abs(rake2)<90);
    sigma=(rake1.*(abs(rake1)<=90)+rake2.*(abs(rake2)<90))*pi/180;
    kappa=pi*strike/180;
    h=cosd(dip);
else
    
    gamma=num2cell(zeros(1,length(MT)));
    delta=num2cell(zeros(1,length(MT)));
    kappa=num2cell(zeros(1,length(MT)));
    sigma=num2cell(zeros(1,length(MT)));
    h=num2cell(zeros(1,length(MT)));
    for i=1:length(MT)
        [gammai,delati,kappai,sigmai,hi]=MT2Tape(MT{i});
        if iscell(gammai)
            gamma(:,i)=gammai;
            delta(:,i)=delati;
            kappa(:,i)=kappai;
            sigma(:,i)=sigmai;
            h(:,i)=hi;
        else
            gamma{:,i}=gammai;
            delta{:,i}=delati;
            kappa{:,i}=kappai;
            sigma{:,i}=sigmai;
            h{:,i}=hi;
        end
            
    end
    if ~all(cellfun(@iscell,MT))
        gamma=cell2mat(gamma);
        delta=cell2mat(delta);
        kappa=cell2mat(kappa);
        sigma=cell2mat(sigma);
        h=cell2mat(h);
    end
end
