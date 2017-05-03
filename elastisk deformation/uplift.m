
% densitet af load
rho=1

% disk størrelsen er 2.5 km
area1=2.*pi*(1-cos(2.5/6371.))*6371^2

% afstanden i meter mellem grid punkter 
grid = 1000

% area for hvert kvadrat i km^2
area = (grid*1e-3)^2 ;

% resultatet ønskes i mm.
d_sigma=1000*area/area1

hi=1000 % is tykkelse i m

G = 3.7822e-06

uplift_mm_pr_yr = rho*G*hi*d_sigma










