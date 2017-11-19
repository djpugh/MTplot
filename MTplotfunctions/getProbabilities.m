function prob=getProbabilities(C,dA,options)
C=reshape(C,[1 options.Resolution^2]);
dA=reshape(dA,[1 options.Resolution^2]);
error=options.ProbabilityError+abs(C).*options.ProbabilityPercentageError/100;
prob=zeros(1, options.Resolution^2);
reducedElements=MemoryBalancer(@(x) x^2,C,dA,error);
NIt=floor(numel(C)/reducedElements)+1;
fprintf(1,'%s','Probability Calculation Percentage: ');
fprintf(1,'%2u%%',0);
for i=0:NIt-1
    fprintf(1,'\b\b\b%2u%%',floor(i/NIt*100));
elements=min(reducedElements,numel(C)-i*reducedElements);
elementIndex=i*reducedElements;
prob(elementIndex+1:elementIndex+elements)=(normpdf(C(elementIndex+1:elementIndex+elements),...
    C(elementIndex+1:elementIndex+elements),error(elementIndex+1:elementIndex+elements)).*...
    dA(elementIndex+1:elementIndex+elements))./sum(...
    normpdf(kron(C',ones(1,elements)),...
    kron(C(elementIndex+1:elementIndex+elements),ones(length(C),1)),...
    kron(error',ones(1,elements))).*...
    kron(dA',ones(1,elements)));
end
fprintf(1,'\n');
prob=reshape(prob,[options.Resolution options.Resolution]);
end