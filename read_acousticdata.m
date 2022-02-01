function [x,Fs,t,fstart,fend,calib]=read_acousticdata(fullname,datatype,tstart,tend)

% extract file name
tmp=strsplit(fullname,'\');
fname=tmp{end};

% extract Fs (Hz)
I=audioinfo(fullname);
Fs=I.SampleRate;

% extract file start time from file name based on datatype
switch datatype
    
    case 'HARP'
        tmp=strsplit(fname,'_');
        if length(tmp{4})==6
            fstart=datenum([tmp{4},tmp{5}],'yymmddHHMMSS');
        else
            fstart=datenum([tmp{5},tmp{6}(1:6)],'yymmddHHMMSS');
        end

    case 'SoundTrap'
        tmp=strsplit(fname,'.');
        fstart=datenum(tmp{2},'yymmddHHMMSS');

end

% extract file end time
fend=fstart+I.Duration/86400;

if nargin==2 % load entire file
    x=audioread(fullname);
elseif nargin==4 % load specificed time window
    N=round(Fs*(([tstart tend]-fstart)*86400))+1;
    x=audioread(fullname,N);
end

% time vector (s)
t=[0:1:length(x)-1]'/Fs;

% calibration
if strcmp(datatype,'SoundTrap')==1
        recorder=str2double(tmp{1});
        hydrophone=find_ST500_hydrophone(fstart,recorder);
        x=ST500_calib(x,recorder,hydrophone);
        calib=1;
else
    calib=0;
end

% remove mean
x=x-mean(x);







