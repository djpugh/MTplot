function Events=MTread(filename,machinefmt)
%Reads binary file structure into Events object.
fid=fopen(filename);
fseek(fid,0,1);
nmax=ftell(fid);
fseek(fid,0,-1);
if nargin<2
    machinefmt='n';
end
Events={};
i=1;
while ftell(fid)<nmax
    X=fread(fid,[2,1],'uint64',0,machinefmt);
    Events{i}=struct();
    Events{i}.total_number_samples=X(1);
    number_mt_samples=X(2);
    converted=fread(fid,[1],'uint8',0,machinefmt);
    if converted>0
        Events{i}.bayesian_evidence=fread(fid,[2,1],'double',machinefmt);
    end
    Events{i}.MTSpace=zeros(6,number_mt_samples);
    Events{i}.Probability=zeros(1,number_mt_samples);
    Events{i}.Ln_P=zeros(1,number_mt_samples);
    if converted
        Events{i}.g=zeros(number_mt_samples,1);
        Events{i}.d=zeros(number_mt_samples,1);
        Events{i}.k=zeros(number_mt_samples,1);
        Events{i}.h=zeros(number_mt_samples,1);
        Events{i}.s=zeros(number_mt_samples,1);
        Events{i}.u=zeros(number_mt_samples,1);
        Events{i}.v=zeros(number_mt_samples,1);
        Events{i}.s1=zeros(number_mt_samples,1);
        Events{i}.d1=zeros(number_mt_samples,1);
        Events{i}.r1=zeros(number_mt_samples,1);
        Events{i}.s2=zeros(number_mt_samples,1);
        Events{i}.d2=zeros(number_mt_samples,1);
        Events{i}.r2=zeros(number_mt_samples,1);
    end
    for j=1:number_mt_samples
        X=fread(fid,[8,1],'double',machinefmt);
        Events{i}.Probability(1,j)=X(1);
        Events{i}.Ln_P(1,j)=X(2);
        Events{i}.MTSpace(1,j)=X(3);
        Events{i}.MTSpace(2,j)=X(4);
        Events{i}.MTSpace(3,j)=X(5);
        Events{i}.MTSpace(4,j)=sqrt(2)*X(6);
        Events{i}.MTSpace(5,j)=sqrt(2)*X(7);
        Events{i}.MTSpace(6,j)=sqrt(2)*X(8);
        if converted>0
            X=fread(fid,[13,1],'double',machinefmt);         
            Events{i}.g(j)=X(1);
            Events{i}.d(j)=X(2);
            Events{i}.k(j)=X(3);
            Events{i}.h(j)=X(4);
            Events{i}.s(j)=X(5);
            Events{i}.u(j)=X(6);
            Events{i}.v(j)=X(7);
            Events{i}.s1(j)=X(8);
            Events{i}.d1(j)=X(9);
            Events{i}.r1(j)=X(10);
            Events{i}.s2(j)=X(11);
            Events{i}.d2(j)=X(12);
            Events{i}.r2(j)=X(13);
        end
    end
    i=i+1;
end
if numel(Events)==1
    Events=Events{1};
end
fclose(fid)
end