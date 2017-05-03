A=load('JGL_ice_250m.u24') ;

n=length(A)

% set UTM zone
zonenr=24


N=A(:,2);
E=A(:,1);

for i=1:n
    [lat(i),lon(i)] = utm2geo(N(i),E(i),zonenr) ;
end

plot(lon,lat)
hold

