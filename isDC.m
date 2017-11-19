function output=isDC(MT)
MT=MTcheck(MT);
floating_point_zero_error=1e-15;
if iscell(MT)
    output=zeros(size(MT));
    for i=1:size(MT,1)
        for j=1:size(MT,2)
            output(i,j)=isDC(MT{i,j});
        end
    end
else
    [gamma,delta,~,~,~]=MT2Tape(MT);
    if abs(gamma)<floating_point_zero_error && abs(delta)<floating_point_zero_error
        output=1;
    else
        output=0;
    end
end