function [Strike1,Dip1,Rake1,Strike2,Dip2,Rake2]=MT2SDR(MT)
% Calculate the strike dip and rake of the fault planes from the moment tensor using MT2TNPE, TP2FP and FP2SDR
%
% Input is the full MT (3x3 matrix)
%
%   Coordinates are x=North, y=East, z=Down
%

if isstruct(MT)    
    if any(strcmpi('S1',fieldnames(MT)))&&any(strcmpi('D1',fieldnames(MT)))&&any(strcmpi('R1',fieldnames(MT)))&&any(strcmpi('S2',fieldnames(MT)))&&any(strcmpi('D2',fieldnames(MT)))&&any(strcmpi('R2',fieldnames(MT)))
        Strike1=MT.S1;
        Dip1=MT.D1;
        Rake1=MT.R1;
        Strike2=MT.S2;
        Dip2=MT.D2;
        Rake2=MT.R2;
        return
    elseif any(strcmpi('MTSpace',fieldnames(MT)))
        MT=MTcheck(MT.MTSpace);
    else
        error('MTplot:struct','structure does not have correct fieldnames, either MTSpace or T,N,P,E required')
    end
end

    [T,~,P,~]=MT2TNPE(MT);
    [N1,N2]=TP2FP(T,P);
    [Strike1,Dip1,Rake1]=FP2SDR(N1,N2);
    [Strike2,Dip2,Rake2]=FP2SDR(N2,N1);
