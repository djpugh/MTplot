function [h,x]=MT2HX(MT)
[g,d,~,~,~]=MT2Tape(MT);
[h,x]=GD2HX(g,d);
end