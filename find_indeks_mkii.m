%For at finde alle datapunkterne mellem vores 2 valgte punkter, bruger vi
%interpolering.
clear
close all
addpath('C:\Users\Kristofer Pedersen\Documents\MATLAB\DAY11\ZI_NG')

A = load('ZI_NG_fjeld_overfl.xy');
front=load('ZI_NG_front.xy') ;
A2=load('ZI_NG_05_06.xy');
B2=load('ZI_NG_00_01.xy');

a = [400000, -1050000];
b = [500000, -1115000];

x = [a(1), b(1)];
y = [a(2), b(2)];

%Vi finder alle x punkter som ligger mellem vores 2 x-koordinater.
X = a(1):b(1);

%Nu interpolerer vi for vores 2 punkter, med alle punkter i X, og afrunder.
Y=interp1(x,y,X)
Y=round(Y)

%Vi vil gerne finde hvilke punkter i X som passer med x-værdierne i A. Det
%gør vi med nedenstående, og laver en ny, betydeligt mindre vektor.
X2 = ismember(X,A(:,1))
profilv_x = X(X2)

%Samme fremgangsmåde bruger vi for alle y-koordinaterne.
Y2 = ismember(Y,A(:,2))
profilv_y = Y(Y2)

%Nu plotter vi det hele, med vores nyfunde tværsnits linje, fundet ud fra
%Y_A og X_A.
figure(1)
subplot(1,2,1)
scatter(A(:,1),A(:,2),30,A(:,3),'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('grundfjeld')
subplot(1,2,2)
scatter(A(:,1),A(:,2),30,A(:,4),'fill')
hold
xlabel('X - meters')
ylabel('Y - meters')
title('overflade')
plot(front(:,1),front(:,2),'k')
plot(profilv_x,profilv_y)
x_vek = A2(:,3); %east hastighed, x.
y_vek = A2(:,4); %north hastighed, y
%Vi laver et vektorfelt for isens udflydning til havet, og angiver
%vektorfelts pilene med rødt.
quiver(A2(:,1),A2(:,2),x_vek,y_vek, 3, 'color', [0 1 1])


% plot den linie hvoraf der beregnes is-flux samt gletsjer fronten
plot(profilv_x,profilv_y,'r')


for i=1:length(A)
 is_tykkelse(i)=A(i,4)-A(i,3) ;      % her beregnes is tykkelsen
 hastigheds_aendring(i)=A2(i,3)-B2(i,3) ;  % her beregnes hastigheds forskellen i x-retning 
end

for i = 1:length(profilv_x)
    for j = 1:length(A)
        
        if A(j,1) == profilv_x(i) && A(j,2) == profilv_y(i)
            profilv_z(i) = is_tykkelse(j) ;
            profilv_dv(i) = hastigheds_aendring(j)
            
            
        end
        
    end
    
    
end

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