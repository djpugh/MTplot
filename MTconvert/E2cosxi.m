function cosxi =E2cosxi(E)
if iscell(E)
    for i=1:numel(E)
        cosxi{i}=E2cosxi( E{i});
    end
    cosxi=reshape(cosxi,size(E,1),size(E,2));

else
    E=E./kron(ones(1,size(E,2)),sqrt(sum(E.^2,2)));
    cosxi=sqrt(2*(E(:,1)-E(:,2)).*(E(:,2)-E(:,3)));
end
end