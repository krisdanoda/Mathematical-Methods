function [d]=afstand(latP1,lonP1,lat1,lon1)
latP1=latP1*(pi/180) ;
lonP1=lonP1*(pi/180) ;
lat1=lat1*(pi/180) ;
lon1=lon1*(pi/180) ;
dlon = abs(lonP1-lon1) ;

d = acos(sin(lat1)*sin(latP1) + cos(lat1)*cos(latP1)*cos(dlon)) ;
d = d * 180 / pi ;

