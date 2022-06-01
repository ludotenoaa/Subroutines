function [toff,tdrift]=compute_toff(t,recorder)

% 2021 May-Nov deployment, based off airgun signals on Aug 23
if t>datenum(2021,5,1,0,0,0) && t<datenum(2021,8,24,0,0,0)

    sites='ABDEFGIJKLMNOP';
    recorders=[5625	5618 5451 5617 5620 5464 5449 5450 5447	5623 5453 5629 5626 5466];
    
    % pre-deplyment calibration
    tstart=datenum(2021,5,2,2,42,0);
    toffs(:,1)=[nan -0.2680   -1.4765   -0.9465   -0.7655   -0.6845   -0.7280 14399.7625 0.2160    0.1900    0.2835    0.0590         0    4.9245];

    % Aug23 10:50 airguns, vessel position: [27.6873 -90.3319]
    tend=datenum(2021,8,23,10,50,0);
    toffs(:,2)=[nan nan -143.7303 59.7123 36.8106 nan nan 14504.3928 120.5899 -14.7857 88.1607 -40.3813 0 nan];

    I=find(recorders==recorder);
    toffs=toffs(I,:);
end

% compute drift in s/day
tdrift=(toffs(2)-toffs(1))/(tend-tstart);

% compute clock offset based on reference site
toff=toffs(1)+tdrift*(t-tstart);
