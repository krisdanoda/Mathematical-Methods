function LSQ_fit_line_annual(data_type)

% vælg data_type
% data_type = 2 betyder vertical landbevægelse
% data_type = 4 betyder øst-vest landbevægelse
% data_type = 6 betyder nord-syd landbevægelse

% eksempel:   LSQ_fit_line_annual(2)

% indsast navn på data fil
DATA=load('KAGA_UEN.txt') ;

y=DATA(:,data_type) ;

% den første sihle




F1=1 ;


A1=1 ;
P1=1 ;
a=1 ;
b=1 ;

for iteration=1:3 ;

    
t=(DATA(:,1)) ;
t=t*365.25 ;

n = length(DATA) ;

 for i=1:n
   err(i) = DATA(i,data_type+1)^2 ;
 end
 
  % Start model
  for k=1:n
     yannual(k,1) = A1*cos( (t(k)*F1*(pi/180)) + P1 ); 
     ylin(k,1) = a*t(k)+b ;
     
     y0(k,1) =  ylin(k,1) + yannual(k,1) ;
  end
  
 dy=y-y0;
 
  x0=[ A1 ; P1 ; a ; b ];

 % Create the model matrix 'G'
  
  for k=1:n
    dydA1(k,1)=cos(t(k)*F1*(pi/180)+P1);
    dydP1(k,1)=-A1*sin(t(k)*F1*(pi/180)+P1);
    dyda(k,1)=t(k);
    dydb1(k,1)=1;
  end

  G=[ dydA1 dydP1 dyda dydb1 ];

 %covariance matrix C_obs
 C_obs = diag(err);

 %Use least square method
 H=inv((G')*G)*(G');

 dx=inv((G')*inv(C_obs)*G)*(G')*inv(C_obs)*dy ;
 
 % estimated standard deviations
 C_est=H*C_obs*H';

 x=x0+dx ;
 
A1=x(1);
P1=x(2);
a=x(3);
b=x(4);


 end
 % end iteration
 
 di=diag(C_est);

 for i=1:2 ;
    std(i,1)=sqrt(di(i));
 end
  
t_min=min(t)-1 ;
nmax=max(t)-min(t) ;

 for i=1:nmax
    tid(i)=t_min+i ;
    predict_lin(i)= x(3) * tid(i) + x(4);
    predict_ann(i)= x(1)*cos( (tid(i)*F1*(pi/180)) + x(2) );
    predict(i) =  predict_lin(i) + predict_ann(i) ;
 end

plot(t/365.25, y,'k.') 
hold
plot(tid/365.25, predict,'r')

x(3)*365.25

xlabel('tid i år')
ylabel('bevæggelse i mm') 
