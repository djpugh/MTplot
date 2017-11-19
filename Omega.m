function omega=Omega(M1,M2)
M1=MTcheck(M1);
M2=MTcheck(M2);

M16=[M1(1,1),M1(2,2),M1(3,3),sqrt(2)*M1(1,2),sqrt(2)*M1(1,3),sqrt(2)*M1(2,3)];
M26=[M2(1,1),M2(2,2),M2(3,3),sqrt(2)*M2(1,2),sqrt(2)*M2(1,3),sqrt(2)*M2(2,3)];

omega=acos(sum(M16.*M26)/(sqrt(sum(M16.^2))*sqrt(sum(M26.^2))));
end