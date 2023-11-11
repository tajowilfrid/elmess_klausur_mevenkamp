% woche2_population
% Vorlage: Mev, 26.10.2021
%
% Logistisches Wachstum
% Populationsentwicklung einer Population N (Angabe in 1000 Stk.)
% N' = r*N*(K-N)*(N-S)

%% Parameter und Startwerte
r = 0.1;                % Reproduktionsrate
K = 5;                  % Kapazitätsgrenze (5000)
S = 0.5;                % Aussterbeschwelle (500)
N0 = [7, 1, 0.4];       % 3 verschiedene Anfangswerte (x 1000 Stk.)

%% Simulation mit Anfangswert N0(1)
% mit Lösungsalgorithmus ode45, siehe: >> doc ode45
% Umsetzung ähnlich wie im Beispiel w01_flugbahn.m (vereinfachte Version)
% dxdt = @(t,x) A*x+B*g;
% [tout,xzv] = ode45(dxdt, [0,t_end], xzv0);
t_end = 10;
dNdt = @(t,N) ........
[t,N] = ode45(dNdt ........., N0(1));

%% Ergebnis und weitere Simulationen
figure(1)
plot(t,N)
...
...
% Raster, Beschriftungen

% Die Simulationen mit dem 2. und 3. Anfangswert ergänzen
% hold on
% [t,N] = ode45(dNdt ........., N0(2));
% plot(t,N)
% ...
% ...
% hold off
% ggf. auch legend('...','...  ) hinzufügen


