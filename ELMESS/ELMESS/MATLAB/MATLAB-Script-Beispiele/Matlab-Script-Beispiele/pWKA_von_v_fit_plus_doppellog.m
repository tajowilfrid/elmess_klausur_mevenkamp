function [] = pWKA_von_v_fit_plus_doppellog()
%
% Leistung einer Windkraftanlage als Potenz der Windgeschwindigkeit
% Ansatz:       Pwka = c * v^x
% Ermittlung des Exponenten durch
% a) "best fit" (LSQCURVEFIT)
% b) Ausgleichsgerade in der doppelt logarithmischen Darstellung
%    der Leistung über der Geschwindigkeit
%

% Mev, 09/2008, 28.9.2018 (Octave-Anpassung)
v=ver;if(strcmp(v(1).Name,'Octave')) isMATLAB = 0; else, isMATLAB = 1; end
if isMATLAB == 0, pkg load optim, end


%% Messreihe
%----------------------------------------------------------------------
v = [3 4 5 6 8 10 12]';
pwka = [35 80 140 250 600 900 1500]';

% Ausgleichsgerade bei doppelt logarithmischer Darstellung
logv    = log10(v);
logpwka = log10(pwka);
mb = polyfit(logv, logpwka, 1); m = mb(1); b = mb(2);
x = m
c = 10^b

% Wertepaare für den Plot der Ausgleichsgerade
vag = linspace(logv(1),logv(end));
ag = m*vag+b;


%% Best fit
%----------------------------------------------------------------------
% Approximation mit lsqcurvefit (Funktion pWKA_approx() siehe unten)
% Startwerte der Parameteroptimierung ([10;2]) grob geschätzt
% Ansatzfunktion:       Pwka = x1 * v^x2
% v:  Werte der Windgeschwindigkeit
% p1, p2: die zu optimierenden Parameter
pWKA_approx = @(p,v) p(1) * v .^ p(2);
x0 = [10;2];
xopt = lsqcurvefit(pWKA_approx,x0,v,pwka)
cf = xopt(1)
xf = xopt(2)

vf = v(1):0.1:v(end);
pwkaf = cf * vf .^ xf;
pwka_ag = c * vf .^ x;          % zum Vergleich (mit log-log-Parametern)


%% Grafik
%----------------------------------------------------------------------
figure(1)
clf
set(gcf,'units','normalized','position',[0.4 0.04,0.55,0.86])
h = plotpos(2,0.08,0.1,0.07);
axes(h(1))
hl = plot(logv, logpwka, 'bx', vag, ag, 'r');
set(hl(1),'linewidth',2)
set(hl(2),'linewidth',1)
grid
legend('Messwerte (doppelt logarithmisch)', 'Ausgleichsgerade', 'Location', 'northwest')
text(0.75, 0.72,['Steigung x = ' num2str(x,'%10.3g')],'fontsize',12,'units','normalized')
ylabel('lg(p_{WKA})')
xlabel('lg(v_{Wind})')

axes(h(2))
hl = plot(v, pwka, 'bx', vf, pwkaf, 'g', vf, pwka_ag, 'r');
set(hl(1),'linewidth',2)
set(hl(2:3),'linewidth',1.5)
grid
legend('Messwerte', '"best fit"-Funktion p = c*v^x', ...
    'p = c*v^x mit loglog-Parametern', 'Location', 'northwest')
text(0.8, 0.59,['Exponent x = ' num2str(xf,'%10.3g')],'fontsize',12,'units','normalized')
ylabel('p_{WKA} [kW]')
xlabel('v_{Wind} [m/s]')

set(h,'fontsize',12)



