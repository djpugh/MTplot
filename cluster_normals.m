function [n1,n2,rake]=cluster_normals(N1,N2)
n1=0*N1;
n2=0*N2;
n1(n1==0)=nan;
n2(n2==0)=nan;
n1(:,1)=N1(:,1);
n2(:,1)=N2(:,1);
for i=2:size(N1,2)
    n1_1cos_theta=max(abs(N1(:,i)'*n1));%abs allows vector flipping - if cos theta is negative then the negative vector would have the equivalent positive value
    n1_2cos_theta=max(abs(N2(:,i)'*n1));
    n2_1cos_theta=max(abs(N1(:,i)'*n2));
    n2_2cos_theta=max(abs(N2(:,i)'*n2));
    dist=[n1_1cos_theta,n1_2cos_theta,n2_1cos_theta,n2_2cos_theta];
    ind=find(dist==max(dist));
    if (size(ind,2)==1&&(ind==1|| ind==4))||all(ind==[1,4])
        if max((N1(:,i)'*n1))<0
            N1(:,i)=-N1(:,i);
        end
        if max((N2(:,i)'*n2))<0
            N2(:,i)=-N2(:,i);
        end
        n1(:,i)=N1(:,i);
        n2(:,i)=N2(:,i);
    else
        if max((N1(:,i)'*n2))<0
            N1(:,i)=-N1(:,i);
        end
        if max((N2(:,i)'*n1))<0
            N2(:,i)=-N2(:,i);
        end
        n2(:,i)=N1(:,i);
        n1(:,i)=N2(:,i);
    end    
end
if (var(mean(n1')*n1)>var(mean(n2')*n2))&&(max(var(n1'))>max(var(n2')))
    nx=n1;
    n1=n2;
    n2=nx;
end
%Sort rakes so that they correspond to the correct faultplane
[~,~,rake]=FP2SDR(n1,n2);
rake=rake';
end