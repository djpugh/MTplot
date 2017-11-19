function D=BiAxes2D(Phi)
D=Phi(:,1)*Phi(:,2)'+Phi(:,2)*Phi(:,1)';
end