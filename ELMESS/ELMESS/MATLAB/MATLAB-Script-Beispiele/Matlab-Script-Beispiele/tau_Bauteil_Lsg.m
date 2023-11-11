% tau_Bauteil_Lsg.m
%
% Lösung zur Übungsaufgabe 2.4.1 "Zeitkonstante einer Bauteilabkühlung"
% Gleichzeitig Skriptbeispiel

% Mev, 28.9.08, 8.10.09, 21.10.2014

%% Daten einlesen
%[data] = textread('Temperaturmessung-10-2008.dat','','commentstyle','shell','delimiter',' ');
fileID = fopen('Temperaturmessung-10-2008.dat');
if fileID == -1, error('File not found!'), end
DataCell = textscan(fileID,'%f %f %f %f','HeaderLines',3);
fclose(fileID);
data = cell2mat(DataCell);
t0 = 55;                    % [Min.]    Zeitpunkt des Beginns des Abkühlvorgangs
i=find(data(:,1) >= t0);    % Indizes der Zeilen mit t >= 55 Min.
t = data(i,1)-t0;           % Zeitachse beginnend bei 0, nicht bei 55
TU = 23;                    % Umgebungstemperatur = Endtemperatur der Abkühlung
theta = data(i,2);
y=log((theta-TU) ./ (theta(1)-TU));

%% Ausgleichsgerade
p = polyfit(t,y,1);
t_ag = [0; 60];             % Zeitachse für Plot der Ausgleichsgerade
y_ag = p(1)*t_ag+p(2);

%% Gesuchte Lösung ausgeben, auch im Matlab-Fenster (";" weggelassen)
tau = -1/p(1)
disp(['Steigung: ', num2str(p(1)), ' 1/min'])
disp(['Zeitkonstante: ', num2str(tau), ' min'])


%% Grafik
figure(1)
clf
set(gcf,'units','normalized','position',[0.1 0.4,0.45,0.5])
hl = plot(t,y,'o',t_ag,y_ag);
grid
xlabel('Zeit [min]')
ylabel('ln((\vartheta-\vartheta_U)/(\vartheta_{max}-\vartheta_0))')
legend('Messwerte (halblogarithmisch)', 'Ausgleichsgerade')
set(gca,'position',[0.07 0.11 0.88 0.86])   % Anpassen der Diagrammabmessungen