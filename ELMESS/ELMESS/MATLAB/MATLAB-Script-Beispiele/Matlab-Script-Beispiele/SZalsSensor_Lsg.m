function  [] = SZalsSensor_Lsg()
%
% Lösung zur Übungsaufgabe 2.2.5 "Kurzschlussstrom einer Solarzelle"
% 
% (siehe auch: doc polyfit, doc cov)

% Mev, 28.9.08

%% gegebene Daten
E = [1000 750 500 250 100]';
I = [2.5 1.8 1.3 0.6 0.2]';
N = length(E);

%% Ausgleichsgerade
p = polyfit(E,I,1);
Eag = (E(end):10:E(1))';
Iag = p(1)*Eag+p(2);
disp(['Empfindlichkeit: ', num2str(p(1)*1000), ' mA/(W/m²)'])

%% Unsicherheit
v = cov([E,I]);     % Kovarianzmatrix (28.9.18: ([E,I) statt (E,I) wg. Octave
r_EI = v(1,2) / (sqrt(v(1,1)) * sqrt(v(2,2)))   % Korrelationskoeffizient
B_EI = r_EI*r_EI;                               % Bestimmtheitsmaß
s = sqrt(v(2,2)) / sqrt(v(1,1)) * sqrt((1-B_EI)/(N-2));

fprintf('Standardabweichung der Empfindlichkeit: %7.3g mA/(W/m²)\n', 1000*s)

%% Grafik
hl = plot(E,I,'o',Eag,Iag);
axis([0, 1100, 0, 3])
grid
xlabel('Bestrahlungsstärke [W/m^2]')
ylabel('Kurzschlussstrom [A]')
legend('Messwerte','Ausgleichsgerade','Location','NorthWest')