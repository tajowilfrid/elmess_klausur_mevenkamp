% Ausgleichsgerade_2_2_3c.m
% Lösung zur Aufgabe aus Skriptkapitel 2.2.3 mit verkürzter Datenreihe
% Mev, 13.10.16 /25.10.2021
%
format compact

%% Messwertpaare (Strom, Spannung) als Spaltenvektoren
I = [0.2; 0.3; 0.5; 0.7; 0.8; 1.0];
U = [33; 31; 29; 27; 25; 23];

%% Funkstionsaufruf
[m, b, sm, sb] = Ausgleichsgerade(I, U);
f = @(x) m*x+b;

%% Innenwiderstand
Ri = -m

%% Ausgabe der Standardabweichungen
sm = sm % Abweichung des Innenwiderstands

%% Grafik
Iag = [0, 1.2];
Uag = polyval(p,Iag);
plot(I,U,'*',Iag,Uag,'r')
grid minor
xlabel('Strom I [A]')
ylabel('Spannung U [V]')
legend('Messwerte','Ausgleichsgerade','Location','ne')
