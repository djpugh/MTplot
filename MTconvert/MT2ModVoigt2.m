function M6 = MT2ModVoigt2(M33)
%Convert 3x3 to modified voigt form 2 
if iscell(M33)
    M6=zeros(6,numel(M33));
    for i=1:numel(M33)
        M6(:,i)=MT2ModVoigt2(M33{i});
    end
else
M6=[M33(1,1),M33(2,2),M33(3,3),sqrt(2)*M33(1,2),sqrt(2)*M33(1,3),sqrt(2)*M33(2,3)]';


end

