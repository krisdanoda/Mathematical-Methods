%% Script med forklaringer og eksempler p� MATLAB plots og interpolationer
% Kursus 30150 - Matematiske og Numeriske Metoder i Rum- og Geofysik

% Scriptet indehodler desuden eksempler p� l�sninger af n�sten alle hjemme-
% opgaver uddelt d. 09/02-2017. 


%% Ops�tning af projektionsfunktionen

% Projektionsfunctionen m_proj definerer omr�det som skal plottes, og
% hvilken form omr�det skal tage p� et plot. 
addpath('C:\Program Files\MATLAB\R2016a\toolbox\matlab\m_map','C:\Program Files\MATLAB\R2016a\toolbox\matlab\m_map','C:\Users\Kristofer Pedersen\Documents\Desuku\DTU\New folder\cn (9)\DAY02')
m_proj('albers equal-area','long',[-77 -8],'lat',[57 85],'rectbox','off'); % rectbox can �ndres fra 'off' til 'on' for at generere et kvadratisk plot

data = elastic_deformation_theoretical(:,1:5)
data = table2array(data)
%Data �ndres fra l�ngdegrads-intervallet [0:360] til [-180:180]
data(:,5)=rem((data(:,5)+180),360)-180;

data = elastic_deformation_theoretical(:,1:5)
data = table2array(data)
%Data �ndres fra l�ngdegrads-intervallet [0:360] til [-180:180]
data(:,5)=rem((data(:,5)+180),360)-180;


[rlat,clat]=find(data(:,4)>85 | data(:,4)<57); % Find alt data som falder udenfor det �nskede breddegrads-interval, [57:85]
data(rlat,:)=[]; % Fjern disse datar�kker fra datamatricen

[rlon,clon]=find(data(:,5)>-8 | data(:,5)<-77); % Find alt data undefor specificeret l�ngdegrads-interval, [-77:-8]
data(rlon,:)=[]; % Fjern disse datar�kker fra datamatricen

figure('units','normalized','outerposition',[0 0 1 1])
colormap jet % Min personlige favorit, idet at: lav b�lgel�ngde = "kolde" farver = lave v�rdier, og h�j b�lgel�ngde = "varme" farver = h�je v�rdier
m_scatter(data(:,5),data(:,4),100,data(:,3),'filled'); % "m_scatter" fungerer meget lig "scatter", n�r det kommer til input-argumenter
hold on;
m_gshhs_i('color','k'); % Definer kystlinjen (se endvidere scripts fra Lektion 1 for mere info)
m_grid('xtick',10,'ytick',8,'linewi',1,'tickstyle','dm','tickdir','in','XAxisLocation','bottom','yaxisloc','left'); % Definer gridparametre
title('Theoretical', 'FontSize',15)
ax=gca;

m_quiver(data(:,5),data(:,4),-data(:,1),-data(:,2),2)

hold off
% m_quiver(data(:,5),data(:,4),log10(abs(data(:,1))).*abs(data(:,1))./data(:,1),log10(abs(data(:,2))).*abs(data(:,2))./data(:,2))
%%

% Vores datas�t er angivet i l�ngdegrader i intervallet [0:360] (rundt om
% jorden i �stlig retning fra prim�rmeridianen), og i breddegrader i
% intervallet [-90:90] (fra geografisk syd til geografisk nord).
% m_maps anvender per definition intervallet [-180:180] til l�ngdegrader,
% og intervallet [-90:90] til breddegrader.
data2 = GPS_elastic(:,1:5)


data2 = table2array(data2)
%Data �ndres fra l�ngdegrads-intervallet [0:360] til [-180:180]
data2(:,5)=rem((data2(:,5)+180),360)-180;


% For at g�re scriptet hurtigere (mindre kr�vende at k�re) er det
% fornuftigt at trimme "for store" datas�t, n�r man gerne vil plotte
% scattered datapunkter.


[rlat,clat]=find(data2(:,4)>85 | data2(:,4)<57); % Find alt data som falder udenfor det �nskede breddegrads-interval, [57:85]
data2(rlat,:)=[]; % Fjern disse datar�kker fra datamatricen

[rlon,clon]=find(data2(:,5)>-8 | data2(:,5)<-77); % Find alt data undefor specificeret l�ngdegrads-interval, [-77:-8]
data2(rlon,:)=[]; % Fjern disse datar�kker fra datamatricen

figure('units','normalized','outerposition',[0 0 1 1])
colormap jet % Min personlige favorit, idet at: lav b�lgel�ngde = "kolde" farver = lave v�rdier, og h�j b�lgel�ngde = "varme" farver = h�je v�rdier
m_scatter(data2(:,5),data2(:,4),100,data2(:,3),'filled'); % "m_scatter" fungerer meget lig "scatter", n�r det kommer til input-argumenter
hold on;
m_gshhs_i('color','k'); % Definer kystlinjen (se endvidere scripts fra Lektion 1 for mere info)
m_grid('xtick',10,'ytick',8,'linewi',1,'tickstyle','dm','tickdir','in','XAxisLocation','bottom','yaxisloc','left'); % Definer gridparametre
title('LSQ', 'FontSize',15)
ax=gca;

m_quiver(data2(:,5),data2(:,4),data2(:,2),data2(:,3))
% m_quiver(data2(:,5),data2(:,4),log10(abs(data2(:,1))).*abs(data2(:,1))./data2(:,1),log10(abs(data2(:,2))).*abs(data2(:,2))./data2(:,2))

%%
%%

% Vores datas�t er angivet i l�ngdegrader i intervallet [0:360] (rundt om
% jorden i �stlig retning fra prim�rmeridianen), og i breddegrader i
% intervallet [-90:90] (fra geografisk syd til geografisk nord).
% m_maps anvender per definition intervallet [-180:180] til l�ngdegrader,
% og intervallet [-90:90] til breddegrader.
data3 = LSQ(:,1:5)


data3 = table2array(data3)
%Data �ndres fra l�ngdegrads-intervallet [0:360] til [-180:180]
data3(:,5)=rem((data3(:,5)+180),360)-180;


% For at g�re scriptet hurtigere (mindre kr�vende at k�re) er det
% fornuftigt at trimme "for store" datas�t, n�r man gerne vil plotte
% scattered datapunkter.


[rlat,clat]=find(data3(:,4)>85 | data3(:,4)<57); % Find alt data som falder udenfor det �nskede breddegrads-interval, [57:85]
data3(rlat,:)=[]; % Fjern disse datar�kker fra datamatricen

[rlon,clon]=find(data3(:,5)>-8 | data3(:,5)<-77); % Find alt data undefor specificeret l�ngdegrads-interval, [-77:-8]
data3(rlon,:)=[]; % Fjern disse datar�kker fra datamatricen

figure('units','normalized','outerposition',[0 0 1 1])
colormap jet % Min personlige favorit, idet at: lav b�lgel�ngde = "kolde" farver = lave v�rdier, og h�j b�lgel�ngde = "varme" farver = h�je v�rdier
m_scatter(data3(:,5),data3(:,4),100,data3(:,3),'filled'); % "m_scatter" fungerer meget lig "scatter", n�r det kommer til input-argumenter
hold on;
m_gshhs_i('color','k'); % Definer kystlinjen (se endvidere scripts fra Lektion 1 for mere info)
m_grid('xtick',10,'ytick',8,'linewi',1,'tickstyle','dm','tickdir','in','XAxisLocation','bottom','yaxisloc','left'); % Definer gridparametre
title('Et styks flot plot.', 'FontSize',15)
ax=gca;

m_quiver(data3(:,5),data3(:,4)./data3(:,4),data3(:,1)./abs(data3(:,1)),data3(:,2)./abs(data3(:,2)))
% m_quiver(data3(:,5),data3(:,4),log10(abs(data3(:,1))).*abs(data3(:,1))./data3(:,1),log10(abs(data3(:,2))).*abs(data3(:,2))./data3(:,2))

%% plotting bar

stations = cell2table(hist(:,4))
stations = stations{:,:}

hold on
bar(1:51,cell2mat(hist(:,1)),0.75,'FaceColor',[0.2 0.2 0.5])
bar(1:51,cell2mat(hist(:,2)),0.5,'FaceColor',[0.0 0.7 0.7])
bar(1:51,cell2mat(hist(:,3)),0.25,'FaceColor',[0.7 0.2 0.7])
grid on
grid minor
legend({'GPS Elastic Deformation','Observed Elastic Deformation','Theoretical Elastic Deformation'},'Location','northwest')
ylim([-3 27])
ax = gca;
ax.XTick = 1:51; 
ax.XTickLabels = stations;

ax.XTickLabelRotation = 80;


