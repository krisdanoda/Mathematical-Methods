clear
close all
% indlæs data for grundfjeldet og isens højde 
A=load('ZI_NG_fjeld_overfl.xy');

% ind 2 filer med is hastigheder
A2=load('ZI_NG_12_13.xy');
B2=load('ZI_NG_00_01.xy');

%indlæs gletsjer front linie 
front=load('ZI_NG_front.xy') ;


for i=1:length(A)
 is_tykkelse(i)=A(i,4)-A(i,3) ;      % her beregnes is tykkelsen
 hastigheds_aendring(i)=A2(i,3)-B2(i,3) ;  % her beregnes hastigheds forskellen i x-retning 
end


% vi laver en profil hvor igennem is-fluxen beregnes....profilens nordlige
% punk er (x1,y2) og sydlige punkt er (x1,y1)  

y2=-1.086*10^6 ;
y1=-1.117*10^6;

x1=4.91*10^5 ;

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

y3=-1.08*10^6;

x3=3.95*10^5 ;
x4=4.6*10^5 ;

j=0 ;

for i=1:length(A)
    if(A(i,2) == y3)
        if(A(i,1) < x4 & A(i,1) > x3)
            j=j+1;
            profilv_x_NG(j) = A(i,1) ;
            profilv_y_NG(j) = A(i,2) ;
            profilv_z_NG(j) = is_tykkelse(i) ;
	    profilv_dv_NG(j) = hastigheds_aendring(i) ;
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
plot(profilv_x_NG,profilv_y_NG,'r')
plot(front(:,1),front(:,2),'k')


subplot(1,2,2)
scatter(A(:,1),A(:,2),30,A(:,4),'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('overflade')
% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten

x_vek = A2(:,3); %east hastighed, x.
y_vek = A2(:,4); %north hastighed, y
%Vi laver et vektorfelt for isens udflydning til havet, og angiver
%vektorfelts pilene med rødt.
quiver(A2(:,1),A2(:,2),x_vek,y_vek, 3, 'color', [0 1 1])
plot(profilv_x,profilv_y,'r')
plot(profilv_x_NG,profilv_y_NG,'r')
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


% nu beregnes masse flxen gennem profilen % enhenden er Gigaton/år
for i=1:length(profilv_z)
    D_flux(i)=1.0 * profilv_z(i)*0.001 * profilv_dv(i)*0.001 * 0.917  ;
    
end


D_flux_Giga_ton_is_pr_aar = sum(D_flux)

for i=1:length(profilv_z)
    D_flux_NG(i)=1.0 * profilv_z_NG(i)*0.001 * profilv_dv_NG(i)*0.001 * 0.917  ;
    
end


D_flux_Giga_ton_is_pr_aar_NG = sum(D_flux_NG)

figure(4)
subplot(1,3,1)
quiver(A2(:,1),A2(:,2),A2(:,3),A2(:,4),10)
subplot(1,3,2)
quiver(B2(:,1),B2(:,2),B2(:,3),B2(:,4))
subplot(1,3,3)
quiver(B2(:,1),B2(:,2),A2(:,3)-B2(:,3),A2(:,4)-B2(:,4))

%%  Plotting the fucking flux


R1=load('ZI_NG_00_01.xy');

R2=load('ZI_NG_05_06.xy');

R3=load('ZI_NG_06_07.xy');

R4=load('ZI_NG_07_08.xy');

R5=load('ZI_NG_08_09.xy');

R6=load('ZI_NG_12_13.xy');



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


for k = 1 :length(Leek)



flux_NG = [];
data_k_NG = cell2mat(Leek(k));
hastighed_NG = data_k_NG(:,4);

j = 0;
for i=1:length(A)
    if(data_k(i,2) == y3)
        if(data_k(i,1) < x4 & data_k(i,1) > x3)
            j=j+1;
            profilv_x_NG(j) = A(i,1) ;
            profilv_y_NG(j) = A(i,2) ;
            profilv_z_NG(j) = is_tykkelse(i) ;
	    profilv_v_NG(j) = hastighed_NG(i) ;
        end
    end
end

for i=1:length(profilv_z)
    flux_NG(i)=1.0 * profilv_z_NG(i)*0.001 * profilv_v_NG(i)*0.001 * 0.917  ;
end

flux_plot_NG(k) =  sum(flux_NG);
    
end
figure(6)
years = [2001 2006 2007 2008 2009 2013];
hold
plot(years,flux_plot)
plot(years,flux_plot,'b*')
ylabel('Flux Gigaton of ice yr^{-1}', 'Fontsize', 15)
xlabel('Year', 'Fontsize', 15)
figure(7)

hold
plot(years,flux_plot_NG)
plot(years,flux_plot_NG,'b*')
