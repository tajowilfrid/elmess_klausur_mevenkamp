% Theta_lsqfit
%
% Übergangsfunktion der Erwärmung im Versuch Theta
% mit Anpassung durch Ausgleichsfunktion mittels lsqcurvefit
% aus der Optimization TB

% Mev, 10/2009, 10/2021

%% Messreihe einlesen
%----------------------------------------------------------------------
%fileID = fopen('Temperaturmessung-10-2008.dat');
%if fileID == -1, error('File not found!'), end
%DataCell = textscan(fileID,'%f %f %f %f','HeaderLines',3);
%fclose(fileID);
%data = cell2mat(DataCell);
%te = 60;                        % [Min.]    Zeitpunkt des Endes der Erwärmung
%i = find(data(:,1) <= te);      % Indizes der Zeilen der Datei mit t <= 55 Min.
%t = data(i,1);                  % Zeitachse
%Temp = data(i,2);               % Temperaturmessreihe

load RC_Ladung.mat
t = U_C_Verlauf(:,1)

t(1) = []
t(1) = []
t(1) = []
t(1) = []

u = U_C_Verlauf(:,2)

u(1) = []
u(1) = []
u(1) = []
u(1) = []

%% Fit (Parameteranpassung an gegebene Daten)
%----------------------------------------------------------------------
% Theoretischer Verlauf: theta = T0 + (Tend-T0)*(1-exp(-t/tau))
% Suche mit plausiblen Anfangsschätzwerten starten: par = [T0; Tend; tau]
tempfun = @(par,t)  par(1) + (par(2) - par(1)) * (1 - exp(-t/par(3)));

%par = [20; 80; 20];
par = [20; 80; 20];
paropt = lsqcurvefit(tempfun, par, t, u);

%% Grafik
figure(1)
clf
set(gcf,'units','normalized','position',[0.1 0.4,0.5,0.5])
h = axes('position', [0.08,0.11,0.88,0.85]);
t2 = t(1):2:t(end)+1;       % feiner aufgelöste Zeitachse
hl = plot(t, u, 'bx', t2, tempfun(paropt,t2), 'g');
set(hl(1),'linewidth',2)
set(hl(2),'linewidth',1.5)
grid
set(h, "fontsize", 12)
ylabel("U [V]")
xlabel("Zeit [Sek.]")
legend("Messwerte", "Ausgleichskurve", "Location", "northwest")
text(0.55,0.05,['Optimale Parameter: U0 = ' num2str(paropt(1),'%6.2f') ...
    ',  Uend = ' num2str(paropt(2),'%6.2f') ',  \tau = ' num2str(paropt(3),'%6.2f')], ...
    'units', 'normalized','fontsize',12)