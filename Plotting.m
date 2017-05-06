%% Script med forklaringer og eksempler på MATLAB plots og interpolationer
% Kursus 30150 - Matematiske og Numeriske Metoder i Rum- og Geofysik

% Scriptet indehodler desuden eksempler på løsninger af næsten alle hjemme-
% opgaver uddelt d. 09/02-2017. 

clear all;close all;clc; % "Restart"

addpath('C:\Program Files\MATLAB\R2016a\toolbox\matlab\m_map',...
'C:\Users\Kristofer Pedersen\Documents\Desuku\DTU\New folder\cn (9)\DAY02')
 % alle relevante filplaceringer defineres her. Der er ingen grund til
 % at definere yderligere filplaceringer senere i scriptet. Keep it simple!
 % "..." kommandoen betyder "denne linjes kode fortættes (som om den var
 % ubrudt) på næste linje", og kan bruges til næsten alting i MATLAB.

uplift=load('udotmap.dat');
 % Load data. Hvis filplaceringer allerede er defineret (så mappen er i din
 % MATLAB-sti) er det tilstrækkeligt at angive filnavnet alene! (Medmindre
 % at man har flere filer af samme navn+type i sin sti - pas på med det!)

%% Opsætning af projektionsfunktionen

% Projektionsfunctionen m_proj definerer området som skal plottes, og
% hvilken form området skal tage på et plot. 
m_proj('albers equal-area','long',[-77 -8],'lat',[57 85],'rectbox','off'); % rectbox can ændres fra 'off' til 'on' for at generere et kvadratisk plot
% Ved at ændre projektionstypen kan man generere plots som engner sig til
% forskellige ting. Eksempler kan produceres ved at køre de følgende tre
% linjers kode:

% ######################################################################
% figure(1)
% m_proj('Stereographic');  % Example for stereographic projection
% m_coast;
% m_grid('xtick',10,'ytick',10,'tickdir','out','yaxislocation','right','fontsize',7);
% title('Example of the Stereographic projection')
% ######################################################################

% Her kan "Stereographic" ændres til "albers equal-area", "Mollweide", etc.
% for at vise de forskellgie typer af projetioner.
% Se endvidere "Yeah, but which projection should i use?"-afsnittet på
% m_maps hjemmesiden (og ja, det hedder afsnittet rent faktisk).

%% Klargør datasættet

% Vores datasæt er angivet i længdegrader i intervallet [0:360] (rundt om
% jorden i østlig retning fra primærmeridianen), og i breddegrader i
% intervallet [-90:90] (fra geografisk syd til geografisk nord).
% m_maps anvender per definition intervallet [-180:180] til længdegrader,
% og intervallet [-90:90] til breddegrader.

%Data ændres fra længdegrads-intervallet [0:360] til [-180:180]
data(:,1)=rem((data(:,1)+180),360)-180;

% For at gøre scriptet hurtigere (mindre krævende at køre) er det
% fornuftigt at trimme "for store" datasæt, når man gerne vil plotte
% scattered datapunkter.

%% Data trimmes til projektionsområdet:

[rlat,clat]=find(data(:,2)>85 | data(:,2)<57); % Find alt data som falder udenfor det ønskede breddegrads-interval, [57:85]
data(rlat,:)=[]; % Fjern disse datarækker fra datamatricen

[rlon,clon]=find(data(:,1)>-8 | data(:,1)<-77); % Find alt data undefor specificeret længdegrads-interval, [-77:-8]
data(rlon,:)=[]; % Fjern disse datarækker fra datamatricen
