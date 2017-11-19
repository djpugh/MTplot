function MT=TNPE2MT(T,N,P,E)
% Calculate the moment tensor from the T,N,P axes(eigenvectors), and E, the eigenvalues.
%
% Inputs are the T, N, P axes and the Eigenvalues as (v1,v2,v3)
%
% Returns the full 3x3 moment tensor
%

%Matrix of eigenvectors(diagonalising matrix)
L=[T,N,P];

%Diagonalised matrix of eigenvalues
D=diag(E);

%Undiagonalising the MT into Coords: N, E, Down for x,y,z
MT=L*D*L';

%Make sure symmetrical (floating point errors)
MT=triu(MT,0)+triu(MT,1)';