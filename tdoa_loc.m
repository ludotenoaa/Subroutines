function [X,LS,lon,lat]=tdoa_loc(tdoa,sensors,Iref,c,sgrid,sres)

% number of sensors
S=size(sensors,1);

% define search grid
dr=km2deg(sres);
lon=[sgrid(1):dr:sgrid(2)];
lat=[sgrid(3):dr:sgrid(4)];

% cycle thourgh each lon, lat & sensor
h=waitbar(0,'Computing TDOA location...');
for klon=1:length(lon)
    for klat=1:length(lat)
        for k=1:S

            % range to each model position
            R=1000*deg2km(distance(lat(klat),lon(klon),sensors(k,2),sensors(k,1)));

            % travel time 
            tt_mod(k)=R/c;
        end

        % convert to tdoa based on reference sensor
        tdoa_mod=tt_mod-tt_mod(Iref);

        % compute error for current model position
        LS(klat,klon)=prod(exp(-(tdoa_mod-tdoa).^2));
    end
    waitbar(klon/length(lon),h)
end
close(h)

% find minimum indices
[tmp,idx] = max(LS);
[~,Ix] = max(tmp);
Iy=idx(Ix);

% estimated position
X=[lon(Ix) lat(Iy)];
