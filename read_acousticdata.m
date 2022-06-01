function [x,Fs,t,fstart,fend,calib]=read_acousticdata(fullname,datatype,tstart,tend)
% Ludovic Tenorio 03/07/2022
% Read specified time window from acoustic data based on datatype (file name format).

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

    case 'GoMxST'
        tmp=strsplit(fname,'_');
        fstart=datenum([tmp{6},tmp{7}],'yyyymmddHHMMSS');

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
try
    if strcmp(datatype,'SoundTrap')==1
        recorder=str2double(tmp{1});
    elseif strcmp(datatype,'GoMxST')==1
        recorder=str2double(tmp{5}(3:6));
    end
    hydrophone=find_ST500_hydrophone(fstart,recorder);
    x=ST500_calib(x,recorder,hydrophone);
    calib=1;
catch
    calib=0; % calib=0 means no calibration could be performed
end

% remove mean
x=x-mean(x);







