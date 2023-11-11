%% RCstep_lsqfit

% Übergangsfunktion des RC-Tiefpasses (verrauscht) mit Anpassung durch
% Ausgleichsfunktion (Sättigungsverlauf) mittels lsqcurvefit
% aus der Optimization TB

% Mev, 10/2017, überarbeitet 10/2020

%% "Mess"reihe (theoretischer Verlauf mit überlagertem Rauschen)
%----------------------------------------------------------------------
rc = 33e3*33e-6;        % R = 33kOhm , C = 33µF
fprintf(['\nZeitkonstante: T = %5.3f s\n'], rc)
Tmess = 5*rc; N = 50;   % Messzeit = 5 Zeitkonstanten, 50 Abtastwerte
t = (0:N-1)'*Tmess/N;
u = 0.05*randn(size(t));
t0 = t(N/10);   % Anstieg beginnt erst nach dem Zeitpunkt t0 = Tmess/10
k = t>t0;
u(k) = u(k) + 2*(1-exp(-(t(k)-t0)/rc));

%% Fit
%----------------------------------------------------------------------
% Theoretischer Verlauf: u(t) = u0 für t < t0  und
% u(t) = u0 + (u1-u0)*(1-exp(-(t-t0)/tau))  für t > t0
% Daraus ergibt sich die folgende Ansatzfunktion mit par = [t0, u0, u1, tau] 
urc = @(par,t) (t<par(1))*par(2) + (t>=par(1)).*(par(2) + (par(3) - par(2)) ...
                                        * (1 - exp(-(t-par(1))/par(4))));

% Suche mit plausiblen Anfangsschätzwerten starten
par = [t(end)/10; 0; 2; 0.1]; 
[paropt, resnorm] = lsqcurvefit(urc, par, t, u);

fprintf(['\nMittlere Abweichung der Messpunkte von der Ausgleichskurve',...
        '\ndelta_u = %6.3f\n'], sqrt(resnorm/length(u)))

%% Grafik
figure(1)
clf
set(gcf,'units','normalized','position',[0.05 0.3,0.7,0.6])
h = axes('position', [0.08,0.11,0.88,0.85]);
hl = plot(t, u, 'bo', t, urc(paropt,t), 'g');
grid
set(hl(1),'linewidth',2)
set(hl(2),'linewidth',1.5)
set(h,'ylim',[-0.25, 2.25],'fontsize',14)
xlabel('Zeit [s]'); ylabel('Spannung u(t) [V]')
legend('"Mess"werte', 'Ausgleichskurve ("fit")','Location','NorthWest')
info1 = sprintf('Optimale Parameter: t0 = %5.2f ,  U0 = %5.2f , ',paropt(1),paropt(2));
info2 = sprintf('U1 = %5.2f ,  \\tau = %5.2f', paropt(3),paropt(4));
text(0.25,0.05, [info1, info2], 'units', 'normalized', 'fontsize',14)
