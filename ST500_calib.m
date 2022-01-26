function xcal=ST500_calib(x,recorder,hydrophone)
% calibrates SoundTrap ST500 data based on recorder and hydrophone serial numbers

% Recorder calibration data
calib_data.recorder=[5625	-1.9
5618	-1.8
5451	-1.8
5617	-1.8
5620	-1.9
5464	-1.8
5449	-1.8
5450	-1.8
5447	-1.8
5623	-1.9
5453	-1.8
5629	-1.9
5626	-1.8
5462	-1.8];

% Hydrophone calibration data
calib_data.hydrophone=[1182	176.8
1251	177.4
1177	176.6
1179	177.4
1180	177.3
1181	177.7
1185	177.4
1184	177.2
1249	176.9
1255	178
1254	177.5
1250	177.5
1253	176.6
1262	176.2];

% Find recorder calibration (dB re. 1V)
Ir=find(recorder==calib_data.recorder(:,1));
rcal=calib_data.recorder(Ir,2);

% Find hydrophone calibration (dB re. 1 uPa/V)
Ih=find(hydrophone==calib_data.hydrophone(:,1));
hcal=calib_data.hydrophone(Ih,2);

% End-to-end system calibration (see ST500 user manual)
caldB=rcal+hcal;

% Covert calibration factor from dB to ratio
cal=10.^(caldB/20);

% Apply calibration to times series data
xcal=x*cal;

