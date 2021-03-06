addpath('C:\Users\Kris\Documents\DTU\Semester 4\Mathematical and Numerical Methods in Earth and Space Physics\Mathematical-Methods','C:\Users\Kris\Documents\DTU\Semester 4\Mathematical and Numerical Methods in Earth and Space Physics\Mathematical-Methods\elastisk deformation')
GR_rates= load('GR_rates_2009til2012_2_5km.txt');
Coordinates = readtable('COORDINATES.txt');

%% coordinates

for k = 1:height(Coordinates)
    tic;
    co =Coordinates{k, 1:2};
    
    latP1 = co(1);
    lonP1 = co(2);
    
    
    lat1 = GR_rates(:,1);
    lon1 = GR_rates(:,2);
    
    %% 1
    Greens=load('greens.txt') ;
    
    
    theta = Greens(:,1);
    g = Greens(:,2);
    count=0;
    for i=1:length(GR_rates(:,1))
        
        
        latP=latP1*(pi/180) ;
        lonP=lonP1*(pi/180) ;
        lat=lat1(i)*(pi/180) ;
        lon=lon1(i)*(pi/180) ;
        dlon = abs(lonP-lon) ;
        
        new_d = acos(sin(lat)*sin(latP) + cos(lat)*cos(latP)*cos(dlon)) ;
        new_d =new_d * 180 / pi ;
        d(i) = new_d;
        
        Gi = interp1(theta,g,new_d,'linear');
        G(i)=Gi;
        count=count+1;
        
    end
    d = d';
    
    
    
    %% 3
    
    rho=1;
    % disk st�rrelsen er 2.5 km
    area1=2.*pi*(1-cos(2.5/6371.))*6371^2;
    % afstanden i meter mellem grid punkter
    grid = 2500;
    area = (grid*1e-3)^2 ;
    
    % resultatet �nskes i mm.
    d_sigma=1000*area/area1;
    h = GR_rates(:,3);
    uplift_mm_pr_yr_k = 0;
    
    for i =1:length(GR_rates(:,1))
        
        hi= h(i); % is tykkelse i m
        
        Gi = G(i);
        
        uplift_mm_pr_yr_k = uplift_mm_pr_yr_k + rho*Gi*hi*d_sigma;
        
    end
        
        uplift_mm_pr_yr(k) = uplift_mm_pr_yr_k;
        toc
end
%%
dable = table(Coordinates{:,1},Coordinates{:,2},uplift_mm_pr_yr',Coordinates{:,4},'VariableNames',{'Lat' 'Lon' 'uplift_mm_pr_yr' 'Station'})

