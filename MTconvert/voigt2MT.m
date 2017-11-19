function MT=voigt2MT(M)
%Converts Voigt form Moment Tensor to 3x3 Moment Tensor
%
if numel(M)==6
    MT = [ M(1), M(6)/sqrt(2), M(5)/sqrt(2); ...
          M(6)/sqrt(2), M(2), M(4)/sqrt(2); ...
          M(5)/sqrt(2), M(4)/sqrt(2), M(3) ];
else
    MT=M;
end