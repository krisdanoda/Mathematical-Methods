%% Script med forklaringer og eksempler p� MATLAB plots og interpolationer
% Kursus 30150 - Matematiske og Numeriske Metoder i Rum- og Geofysik

% Scriptet indehodler desuden eksempler p� l�sninger af n�sten alle hjemme-
% opgaver uddelt d. 09/02-2017. 

clear all;close all;clc; % "Restart"

addpath('C:\Program Files\MATLAB\R2016a\toolbox\matlab\m_map',...
'C:\Users\Kristofer Pedersen\Documents\Desuku\DTU\New folder\cn (9)\DAY02')
 % alle relevante filplaceringer defineres her. Der er ingen grund til
 % at definere yderligere filplaceringer senere i scriptet. Keep it simple!
 % "..." kommandoen betyder "denne linjes kode fort�ttes (som om den var
 % ubrudt) p� n�ste linje", og kan bruges til n�sten alting i MATLAB.

uplift=load('udotmap.dat');
 % Load data. Hvis filplaceringer allerede er defineret (s� mappen er i din
 % MATLAB-sti) er det tilstr�kkeligt at angive filnavnet alene! (Medmindre
 % at man har flere filer af samme navn+type i sin sti - pas p� med det!)

%% Ops�tning af projektionsfunktionen

% Projektionsfunctionen m_proj definerer omr�det som skal plottes, og
% hvilken form omr�det skal tage p� et plot. 
m_proj('albers equal-area','long',[-77 -8],'lat',[57 85],'rectbox','off'); % rectbox can �ndres fra 'off' til 'on' for at generere et kvadratisk plot
% Ved at �ndre projektionstypen kan man generere plots som engner sig til
% forskellige ting. Eksempler kan produceres ved at k�re de f�lgende tre
% linjers kode:

% ######################################################################
% figure(1)
% m_proj('Stereographic');  % Example for stereographic projection
% m_coast;
% m_grid('xtick',10,'ytick',10,'tickdir','out','yaxislocation','right','fontsize',7);
% title('Example of the Stereographic projection')
% ######################################################################

% Her kan "Stereographic" �ndres til "albers equal-area", "Mollweide", etc.
% for at vise de forskellgie typer af projetioner.
% Se endvidere "Yeah, but which projection should i use?"-afsnittet p�
% m_maps hjemmesiden (og ja, det hedder afsnittet rent faktisk).

%% Klarg�r datas�ttet

% Vores datas�t er angivet i l�ngdegrader i intervallet [0:360] (rundt om
% jorden i �stlig retning fra prim�rmeridianen), og i breddegrader i
% intervallet [-90:90] (fra geografisk syd til geografisk nord).
% m_maps anvender per definition intervallet [-180:180] til l�ngdegrader,
% og intervallet [-90:90] til breddegrader.

%Data �ndres fra l�ngdegrads-intervallet [0:360] til [-180:180]
data(:,1)=rem((data(:,1)+180),360)-180;

% For at g�re scriptet hurtigere (mindre kr�vende at k�re) er det
% fornuftigt at trimme "for store" datas�t, n�r man gerne vil plotte
% scattered datapunkter.

%% Data trimmes til projektionsomr�det:

[rlat,clat]=find(data(:,2)>85 | data(:,2)<57); % Find alt data som falder udenfor det �nskede breddegrads-interval, [57:85]
data(rlat,:)=[]; % Fjern disse datar�kker fra datamatricen

[rlon,clon]=find(data(:,1)>-8 | data(:,1)<-77); % Find alt data undefor specificeret l�ngdegrads-interval, [-77:-8]
data(rlon,:)=[]; % Fjern disse datar�kker fra datamatricen
