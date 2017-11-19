function MT=RTP2NED(mt)
six=false;
if ~iscell(mt)
    if size(mt,1)==6||size(mt,2)==6
        six=true;
    end
    mt=MTcheck(mt);
    MT=[mt(3,3);mt(2,2);-mt(1,1);-sqrt(2)*mt(2,3);sqrt(2)*mt(1,3);sqrt(2)*-mt(1,2)];
    if ~six
        MT=MTcheck(MT);
    end
else
     for i=1:numel(mt)
         MT{i}=RTP2NED( mt{i});
     end
     MT=reshape(MT,size(mt,1),size(mt,2));
end
end