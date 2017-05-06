clear
a=6378137 ;

%load data file
A=load('test_data.txt') ;
n = length(A) ;

L=A(:,1)*pi/180 ;     % bredde i grader fra input fil
M=A(:,2)*pi/180 ;     % længde i grader fra input fil
Vns_obs=A(:,3) ;
Vew_obs=A(:,4) ;

whos

% rotation vector  
%MwF= MwP - FwP = (wx, wy, wz)

% rotation pole  
%plat = atan(wz / sqrt (wx*wx+wy*wy)) 
%plon = atan(wy/wx) 

T=-2.299*pi/180   % bredde for euler pol 
P=-85.540*pi/180  % længde for euler pol
% rotations hastighed
w= 0.207*(pi/180)/1000000  % rotations hastighed for euler pol


% rotation rate
%rate = sqrt(wx*wx+wy*wy*+wz*wz) 

% velocity at a point (tlat,tlon) 
for i=1:n
Vns_est(i,1) = a*w*cos(T)*sin(M(i)-P) ;
Vew_est(i,1) = a*w*( cos(L(i))*sin(T) - sin(L(i))*cos(T)*cos(M(i)-P)) ;
end

load coast
subplot(2,1,1)
plot(long,lat)
hold
quiver(A(:,2),A(:,1),A(:,4),A(:,3),1)
axis([-180 -20 10 90])

subplot(2,1,2)
plot(long,lat)
hold
quiver(A(:,2),A(:,1),Vew_est,Vns_est,1)
axis([-180 -20 10 90])

%figure(2)
%plot(long,lat)
%hold
%quiver(A(:,2),A(:,1),A(:,4)+Vew_est,A(:,3)+Vns_est,1)
%axis([-180 -20 10 80])

