function c=probhistc2d(X,Y,xrange,yrange,probability,Marginalised,Logarithm,Normalise)
if nargin<7
    Logarithm=false;
end
if nargin<8
    Normalise=false;
end
if numel(probability)<2
    c=hist2d(X,Y,xrange,yrange);
elseif Marginalised
    c=marginalisedprobhist2d(X,Y,xrange,yrange,probability);  
else
    c=maxprobhist2d(X,Y,xrange,yrange,probability);
end
if Normalise && (Marginalised||numel(probability)<2)
    c=c/sum(reshape(c,1,numel(c))*mean(diff(xrange))*mean(diff(yrange)));
end
if Logarithm
    c=log(c);
end