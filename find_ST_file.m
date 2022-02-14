function fname=find_ST_file(t,recorder,fldr,dur)
% finds SoundTrap filename associated with time t (datenum) and serial number (recorder) 
% fldr is the full path to the soundtrap folders
% dur is the SoundTrap file duration in days

if recorder==5450
    t=t-datenum(0,0,0,4,0,0);
end

fldr=[fldr,'\',num2str(recorder),'\'];

D=dir(fldr);

count=1;
for k=1:length(D)
    tmp=split(D(k).name,'.');
    if ~isempty(tmp{2})
        fnames{count}=D(k).name;
        tstart(count)=datenum(tmp{2},'yymmddHHMMSS');
        tend(count)=tstart(count)+dur;
        count=count+1;
    end
end

fname=fnames{find(t>=tstart & t<tend)};


