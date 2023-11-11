%% gemessene werte
f = [100,500,750,1000,1500,2000,2500,3200,4000,5000,6000,7500,10000,12000,15000,20000,30000,50000];
Quot = [1,1,0.99,0.98,0.95,0.92,0.88,0.84,0.78,0.70,0.63,0.55,0.45,0.39,0.31,0.24,0.17,0.10];

%% berechnung der Amplitudengang in dezibel und Phasenwinkel
amp = 20*log(Quot);
phi = atand(Quot);
fg = 5000; % in hz
R = 1003;           % [Ohm]
tr = 120.9e-6;      % [s] Anstiegszeit
tau = 0.455*tr;     % [s]   Zeitkonstante
fg = 0.70;          %[Hz] Grenzfrequenz
C = tau/R;          %[F] Kapazität

% Betrag des Frequenzgangs
G_RC = @(w) 1./sqrt(1+(w*tau).^2)


%% graphique
figure(1)
set(gcf,'units','normalized','position',[0.3 0.05,0.6,0.85])
clf

%% Amplitudengangsdiagramm
h1 = subplot(2,1,1);
set(h1,'position', [0.08,0.56,0.88,0.4]);
set(h1,'fontsize',12)
Ad = plot(f,amp,'linewidth', 3);
set(h1,'xscale','log');
xlabel('Frequenz [Hz]')
set(h1,'ylim', [-45 5]);
grid on
title('Betragsfrequenzgang RC-tiefpass')
%hold (h1, 'on')
%fminmax = get(h1,'xlim');
%plot(fminmax,[-3, -3],'k--')
%gminmax = get(h1,'ylim');
%plot([fg,fg],gminmax,'k--')
ylabel('Dämpfung [dB]')
%hold (h1, 'off')

%% Phasenwinkel
h2 = subplot(2,1,2);
set(h2,'position', [0.08,0.08,0.88,0.4]);
set(h2,'fontsize',12)
f = logspace(2,6,1000);
hb = semilogx(f, 20*log10(G_RC(2*pi*f)),'linewidth',2);
grid
%get(h2);
set(h2,'xscale','log');
set(h2,'ylim', [5 50]);
ylabel('Phasen winkel [°]')
xlabel('Frequenz [Hz]')
grid on
title('Argument frequenzgang RC-tiefpass')