function  [diff_th] = Temp_Linearisierung_mit_Vorwiderstand(Rv)
% Linearisierung der Kennlinie eines SI-Widerstandstemperaturfühlers
% durch einen Vorwiderstand
% Darstellung der Linearität durch Vergleich von Temperatur
% und Anzeigetemperatur
%
% Input:
% Rv        (double) Vorwiderstand [Ohm] (default: 10 kOhm)
%
% Output:
% diff_th   (Spaltenvektor) Abweichungen von der Soll-Kennlinie
%
% Die Funktion kann mit "lsqnonlin" direkt zur Optimierung verwenden werden:
% Aufruf:  Rvopt = lsqnonlin('Temp_Linearisierung_mit_Vorwiderstand',1e4)
%

% M. Mevenkamp, 02/2013, 01/2018, 01/2020

if nargin == 0
    Rv = 10e3;       % [Ohm]	Vorwiderstand
end

%% Kennlinie Si-Temperatursensorelement
R25 = 2000;                             % [Ohm]
a  = 0.01;                              % [1/°C]  alternativ: a=7.88e-3;
b  = 5.0e-5;                            % [1/(°C)^2]  alternativ: b=1.937e-5;
si_res = @(th) R25*(1+a*(th-25)+b*(th-25).^2);   % Widerstandskennlinie

%% Messpannung Um
U_S = 5;                                % [V]   Speisespannung
Um = @(th) si_res(th)./(Rv + si_res(th)) * U_S;

%% Anzeigetemperatur (Übereinstimmung bei 0 °C und 100 °C)
th = (-20:5:120)';                      % Temperaturen für Plot (X-Achse)
th_anz = 100*(Um(th) - Um(0))/(Um(100) - Um(0));
diff_th = th_anz - th;

%% Grafische Darstellung der Kennlinie th_anz(th)
figure(1); set(gcf,'units','normalized','position',[0.08,0.1,0.5,0.8])
hp = plotpos(2,0.05,0.08,0.08);
hl1 = plot(hp(1),th,th_anz,'+',[-20;120],[-20;120],'k');
set(hp(1),'fontsize',14)
set(hl1(1),'linewidth',1.5)
ylabel('Anzeigetemperatur [°C]')
legend(['Kennlinie bei Rv = ', num2str(Rv/1000,'%6.3f'), ' k\Omega'],'location','nw')
grid

%% Grafische Darstellung der Kennlinienabweichung
axes(hp(2))
hl1 = plot(th,diff_th,'-+',[-20;120],[0;0],'k');
set(hp(2),'fontsize',14)
set(hl1,'linewidth',1.5)
xlabel('Temperatur [°C]')
ylabel('Temperaturabweichung [°C]')
legend(['Linearitätsfehler bei Rv = ', num2str(Rv/1000,'%6.3f'), ' k\Omega'],'location','best')
grid
