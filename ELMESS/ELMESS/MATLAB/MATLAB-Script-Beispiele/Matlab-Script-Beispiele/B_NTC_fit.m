function [B] = B_NTC_fit()

% Lösung zur Aufgabe 2.4.2 (Parameter B eines NTC)

% Mev, 8.9.2010, 10.10.13

%% Messdaten einlesen, Daten aus Aufheizvorgang
%----------------------------------------------------------------------
%[data] = textread('Temperaturmessung-10-2008.dat','','commentstyle','shell','delimiter',' ');
fileID = fopen('Temperaturmessung-10-2008.dat');
if fileID == -1, error('File not found!'), end
DataCell = textscan(fileID,'%f %f %f %f','HeaderLines',3);
fclose(fileID);
data = cell2mat(DataCell);
te = 55;                        % [Min.]    Zeitpunkt des Endes der Erwärmung
i = find(data(:,1) <= te);      % Indizes der Daten im Intervall t <= 55 Min.
T_D_h = data(i,2);              % Temperaturmesswerte Aufheizphase
R_NTC_h = data(i,3);            % Widerstandsmesswerte

% Start- bzw. Referenzwerte
T_D_0 = T_D_h(1)+273;
R0 = R_NTC_h(1);

% "y"- und "x"-Werte für die Ausgleichsgeradenberechnung
%----------------------------------------------------------------------
logRNTC = log(R0 ./ R_NTC_h);
Tx = 1/T_D_0 - 1 ./(T_D_h+273);

%% Ausgleichsgerade
%----------------------------------------------------------------------
p = polyfit(Tx,logRNTC,1);
T_ag = linspace(Tx(1),Tx(end));   % Zeitachse (zu linspace siehe "doc linspace")
logR_ag = p(1)*T_ag+p(2);

%% Gesuchte Lösung im Matlab-Fenster ausgeben, Grafik
%----------------------------------------------------------------------
B = p(1);
fprintf('Steigung (= Parameter B): %.1f K\n', B)

hl = plot(Tx,logRNTC,'ro',T_ag,logR_ag,'b');
set(hl,'linewidth',1.5)
grid
xlabel('1/T0 - 1/T [K^{-1}]')
ylabel('ln((R0)/(R(T)))')
legend('Messwerte', 'Ausgleichsgerade','location','northwest');

