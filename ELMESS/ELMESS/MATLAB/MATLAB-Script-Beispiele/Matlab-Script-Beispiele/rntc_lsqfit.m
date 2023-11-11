function [] = rntc_lsqfit()
% RNTC_LSQFIT   Bestimmung von B durch Kurvenapproximation
% 
% Mev, 6.9.2010, 4.10.12, 20.10.2016, 28.9.2018 (Octave-Anpassung)

v=ver;if(strcmp(v(1).Name,'Octave')) isMATLAB = 0; else, isMATLAB = 1; end
if isMATLAB == 0, pkg load optim, end

%% Messdaten einlesen, Daten aus Aufheizvorgang und Abkühlphase separat
%----------------------------------------------------------------------
fileID = fopen('Temperaturmessung-10-2008.dat');
if fileID == -1, error('File not found!'), end
DataCell = textscan(fileID,'%f %f %f %f','HeaderLines',3);
fclose(fileID);
data = cell2mat(DataCell);
te = 55;                        % [Min.]    Zeitpunkt des Endes der Erwärmung
i = find(data(:,1) <= te);      % Indizes der Daten im Intervall t <= 55 Min.
T_D_h = data(i,2);              % Temperaturmesswerte Aufheizphase
R_NTC_h = data(i,3);            % Widerstandsmesswerte
i = find(data(:,1) > te);       % Indizes der Daten mit t > 55 Min.
T_D_k = data(i,2);              % Temperaturmesswerte Abkühlphase
R_NTC_k = data(i,3);            % Widerstandsmesswerte

%% Grafik
%----------------------------------------------------------------------
figure(1)
clf
set(gcf,'units','normalized','position',[0.2 0.2,0.7,0.7])
h = axes('position', [0.06,0.11,0.89,0.85]);    % Diagramm an gewünschter Stelle

% Aufheizphase
% Fit (Suche mit plausiblem Anfangsschätzwert für B starten! Hier: 4000.)
global R0
R0 = R_NTC_h(1)/1000;
B0 = 4000; 
B_opt = lsqcurvefit(@rntcfun, B0, T_D_h, R_NTC_h/1000);
fprintf('Optimal angepasster Parameter B aus Aufheizvorgang: B_opt = %.1f\n',B_opt)

T_D = T_D_h(1):1:T_D_h(end)+1;
hl = plot(T_D_h, R_NTC_h/1000, 'bx', T_D, rntcfun(B_opt, T_D), 'b');
set(hl(1),'linewidth',2)
text(30.5, 26.5,['B_{opt} = ', num2str(B_opt,'%.1f')],'fontsize',12,'color','b')
hold on

% Abkühlphase
[T_D_k,it] = sort(T_D_k);
R_NTC_k = R_NTC_k(it);
R0 = R_NTC_k(1)/1000;
B_opt = lsqcurvefit(@rntcfun, B0, T_D_k, R_NTC_k/1000);
fprintf('Optimal angepasster Parameter B aus Abkühlphase: B_opt = %.1f\n',B_opt)

T_D = T_D_k(1):1:T_D_k(end)+1;
hl = plot(T_D_k, R_NTC_k/1000, 'gx', T_D, rntcfun(B_opt, T_D), 'g');
set(hl(1),'linewidth',2)
text(40.5, 7.5,['B_{opt} = ', num2str(B_opt,'%.1f')],'fontsize',12,'color','g')

legend('Messwerte Aufheizphase', 'Ausgleichskurve ("fit")', ...
        'Messwerte Abkühlphase', 'Ausgleichskurve ("fit")','Location','NorthEast')
grid
set(h,'fontsize',12)
ylabel('R_{NTC} [k\Omega]')
xlabel('Temperatur [°C]')
end

function [rntc] = rntcfun(B, t)
% Parameter R0 muss in der aufrufenden Function definiert und
% "global" deklariert sein.
global R0
T0 = t(1) + 273;
rntc = R0 * exp(B*(1./(t+273)-1/T0));
end
