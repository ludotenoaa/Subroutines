function [x,Fs,t,tstart_file,tend_file]=read_GOM_data(fullname,tstart,tend)
% inputs:
% fullname: file name and location
% tstart/tend: start/end times to load in datenum
% outputs:
% x: data
% Fs: sample frequency
% t: time vector (s)
% tstart_file/tend_file: start/end of file in datenum

% extract file name
tmp=strsplit(fullname,'\');
fname=tmp{end};

% extract file start time
tmp=strsplit(fname,'_');
tstart_file=datenum([tmp{5},tmp{6}],'yymmddHHMMSS');

% extract Fs (Hz)
I=audioinfo(fullname);
Fs=I.SampleRate;

% extract file end time
tend_file=tstart_file+I.Duration/86400;

% compute first/last samples based on start/end times
N=round(Fs*(([tstart tend]-tstart_file)*86400));
N(1)=N(1)+1;

% load data
[x,Fs]=audioread(fullname,N);

% time vector (s)
t=[0:1:length(x)-1]'/Fs;





