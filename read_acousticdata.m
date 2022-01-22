function [x,Fs,t,fstart,fend]=read_acousticdata(fullname,datatype,tstart,tend)

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
        fstart=datenum([tmp{5},tmp{6}(1:6)],'yymmddHHMMSS');
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

% remove mean
x=x-mean(x);







