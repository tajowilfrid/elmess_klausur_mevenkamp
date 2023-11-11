% Theta_lsqfit
%
% Übergangsfunktion der Erwärmung im Versuch Theta
% mit Anpassung durch Ausgleichsfunktion mittels lsqcurvefit
% aus der Optimization TB

% Mev, 10/2009, 06/2011, 10/2016, 28.9.2018 (Octave-Anpassung)
v=ver;if(strcmp(v(1).Name,'Octave')) isMATLAB = 0; else, isMATLAB = 1; end
if isMATLAB == 0, pkg load optim, end



%% Messreihe einlesen
%----------------------------------------------------------------------
fileID = fopen('Temperaturmessung-10-2008.dat');
if fileID == -1, error('File not found!'), end
DataCell = textscan(fileID,'%f %f %f %f','HeaderLines',3);
fclose(fileID);
data = cell2mat(DataCell);
te = 55;                        % [Min.]    Zeitpunkt des Endes der Erwärmung
i = find(data(:,1) <= te);      % Indizes der Zeilen der Datei mit t <= 55 Min.
t = U_C_Verlauf(:,1);                  % Zeitachse
u = U_C_Verlauf(:,2);               % Temperaturmesswerte

%% Fit (Def. tempfun() siehe unten)
%----------------------------------------------------------------------
% Theoretischer Verlauf: theta = T0 + (Tend-T0)*(1-exp(-t/tau))
% Suche mit plausiblen Anfangsschätzwerten starten: par = [T0; Tend; tau]
tempfun = @(par,t)  par(1) + (par(2) - par(1)) * (1 - exp(-t/par(3)));
par = [t(end)/10; 0; 2; 0.1;]; 
paropt = lsqcurvefit(tempfun, par, t, u); 

%% Grafik
figure(1)
clf
set(gcf,'units','normalized','position',[0.2 0.3,0.7,0.6])
h = axes('position', [0.08,0.11,0.88,0.85]);

t2 = t(1):2:t(end)+1;       % feiner aufgelöste Zeitachse
hl = plot(t, u, 'bx', t2, tempfun(paropt,t2), 'g');
set(hl(1),'linewidth',2)
set(hl(2),'linewidth',1.5)
grid
set(h,'ylim',[-1, 3])
set(h,'fontsize',12)
ylabel('Spannungsmessreihe [V]')
xlabel('Zeit [s.]')
legend('Messwerte', 'Ausgleichskurve ("fit")','Location','northwest')
text(0.55,0.05,['Optimale Parameter: T0 = ' num2str(paropt(1),'%6.2f') ...
    ',  Tend = ' num2str(paropt(2),'%6.2f') ',  \tau = ' num2str(paropt(3),'%6.2f')], ...
    'units', 'normalized','fontsize',12)
text(0.55,0.10,['Die Kondensatorladung betraegt: C= ',num2str(paropt(3)/(33000)),'F'],'units', 'normalized','fontsize',12);