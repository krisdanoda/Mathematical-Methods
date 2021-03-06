clear

% indl�s data for grundfjeldet og isens h�jde 
A=load('JI_fjeld_overfl.xy');

% ind 2 filer med is hastigheder
A2=load('JI_00_01.xy');
B2=load('JI_2013.xy');

%indl�s gletsjer front linie 
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
title('hastigheds �ndring ')
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


% nu beregnes masse flxen gennem profilen % engenden er Gigaton/�r
for i=1:length(profilv_z)
    D_flux(i)=1.0 * profilv_z(i)*0.001 * profilv_dv(i)*0.001 * 0.917  ;
    
end


D_flux_Giga_ton_is_pr_aar = sum(D_flux)

figure(4)
subplot(1,3,1)
quiver(A2(:,1),A2(:,2),A2(:,3),A2(:,4),10)
subplot(1,3,2)
quiver(B2(:,1),B2(:,2),B2(:,3),B2(:,4))
subplot(1,3,3)
quiver(B2(:,1),B2(:,2),A2(:,3)-B2(:,3),A2(:,4)-B2(:,4))

%%  Plotting the fucking flux
clear

% indl�s data for grundfjeldet og isens h�jde 
A=load('JI_fjeld_overfl.xy');

y2=-2220000 ;
y1=-2280000;

x1=-415000 ;



for i=1:length(A)
 is_tykkelse(i)=A(i,4)-A(i,3) ;      % her beregnes is tykkelsen
end



R1=load('JI_00_01.xy');

R2=load('JI_05_06.xy');

R3=load('JI_06_07.xy');

R4=load('JI_08_09.xy');

R5=load('JI_09_10.xy');

R6=load('JI_2013.xy');



Leek = {R1 R2 R3 R4 R5 R6};
flux_plot = []

for k = 1 :length(Leek)



flux = [];
data_k = cell2mat(Leek(k));
hastighed = data_k(:,3);

j = 0;
for i=1:length(A)


    if(data_k(i,1) == x1)
        if(data_k(i,2) < y2 & data_k(i,2) > y1)
            j=j+1;
            profilv_x(j) = A(i,1) ;
            profilv_y(j) = A(i,2) ;
            profilv_z(j) = is_tykkelse(i) ;
	    profilv_v(j) = hastighed(i) ;
        end
    end
end

for i=1:length(profilv_z)
    flux(i)=1.0 * profilv_z(i)*0.001 * profilv_v(i)*0.001 * 0.917  ;
end

flux_plot(k) =  sum(flux);
    
end


years = [2001 2006 2007 2009 2010 2013];
figure(5)
ylabel('Flux Gigaton of ice yr^{-1}', 'Fontsize', 15)
xlabel('Year', 'Fontsize', 15)
hold
plot(years,-flux_plot)
plot(years,-flux_plot,'b*')

