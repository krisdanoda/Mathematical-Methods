clear

% indlæs data for grundfjeldet og isens højde 
A=load('JI_fjeld_overfl.xy');

% ind 2 filer med is hastigheder
A2=load('JI_05_06.xy');
B2=load('JI_00_01.xy');

%indlæs gletsjer front linie 
front=load('JI_front.xy') ;


for i=1:length(A)
 is_tykkelse(i)=A(i,4)-A(i,3) ;      % her beregnes is tykkelsen
 hastigheds_aendring(i)=A2(i,3)-B2(i,3) ;  % her beregnes hastigheds forskellen i x-retning 
end


% vi laver en profil hvor igennem is-fluxen beregnes....profilens nordlige
% punk er (x1,y2) og sydlige punkt er (x1,y1)  

y2=-2220000 ;
y1=-2280000;

x1=-415000 ;

j=0 ;
for i=1:length(A)
    if(A(i,1) == x1)
        if(A(i,2) < y2 & A(i,2) > y1)
            j=j+1;
            profilv_x(j) = A(i,1) ;
            profilv_y(j) = A(i,2) ;
            profilv_z(j) = is_tykkelse(i) ;
	    profilv_dv(j) = hastigheds_aendring(i) ;
        end
    end
end


figure(1)
subplot(1,2,1)
scatter(A(:,1),A(:,2),30,A(:,3),'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('grundfjeld')

% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten
plot(profilv_x,profilv_y,'r')
plot(front(:,1),front(:,2),'k')


subplot(1,2,2)
scatter(A(:,1),A(:,2),30,A(:,4),'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('overflade')
% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten
plot(profilv_x,profilv_y,'r')
plot(front(:,1),front(:,2),'k')



figure(2)
subplot(1,2,1)
scatter(A(:,1),A(:,2),30,is_tykkelse,'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('is tykkelse')

% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten
plot(profilv_x,profilv_y,'r')
plot(front(:,1),front(:,2),'k')


subplot(1,2,2)
scatter(A(:,1),A(:,2),30,hastigheds_aendring,'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('hastigheds ændring ')
% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten
plot(profilv_x,profilv_y,'r')
plot(front(:,1),front(:,2),'k')


figure(3)
subplot(2,1,1)
% plot is-tykkelsen gennem flux linien
plot(profilv_y*0.001,profilv_z,'.-')   % afstand vises i km fremfor meter
xlabel('afstand in km')
ylabel('is tykkelse  - meters')

subplot(2,1,2)
% plot is-tykkelsen gennem flux linien
plot(profilv_y*0.001,profilv_dv*0.001,'.-')
xlabel('afstand in km')
ylabel('hastighed - km/yr')


% nu beregnes masse flxen gennem profilen % engenden er Gigaton/år
for i=1:length(profilv_z)
    flux(i)=1.0 * profilv_z(i)*0.001 * profilv_dv(i)*0.001 * 0.917  ;
end


Giga_ton_is_pr_aar = sum(flux)

figure(4)
subplot(1,3,1)
quiver(A2(:,1),A2(:,2),A2(:,3),A2(:,4),10)
subplot(1,3,2)
quiver(B2(:,1),B2(:,2),B2(:,3),B2(:,4))
subplot(1,3,3)
quiver(B2(:,1),B2(:,2),A2(:,3)-B2(:,3),A2(:,4)-B2(:,4))


