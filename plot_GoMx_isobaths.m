function isob=plot_GoMx_isobaths(z1,z2,dz)

% load Gulf of Mexico bathymetry (50m)
GoM_bath=shaperead('C:\Users\ludovic.tenorio\Documents\SEFSC_Laptop\MatlabLibray/GoM_bathymetry/50m/50m.shp');

% isobars
vec_iso=-z1:-dz:-z2;

% color scale
cscale=cmocean('deep',length(vec_iso));

% loop over each bathymetry element
for k=1:length(GoM_bath)
    % finds isobath and associates color from scale
    I=find(GoM_bath(k).CONTOUR==vec_iso);
    coltmp=cscale(I,:);

    % plot isobath
    if coltmp
        plot(GoM_bath(k).X,GoM_bath(k).Y,'Color',coltmp,'LineWidth',1);
        hold on
    end
end

