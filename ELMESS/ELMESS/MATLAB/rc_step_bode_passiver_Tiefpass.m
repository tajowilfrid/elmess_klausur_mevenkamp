function [tau] = rc_step_bode()
%
% Sprungantwort und Bodediagramm des RC-Tiefpasses
% Mev, 10/2017, 11/2020

%% RC-Tiefpass
R = 1003;           % [Ohm]
C = 54.85e-9;       % [F]
tau = R*C;          % [s]   Zeitkonstante
fg = 5000; % in [Hz] Grenzfrequenz

freq =  [500,5000,20000];
G = [1,1,0.251];

% Amplitude und Phasenwinkel
amp = 20*log(G);
phi = atand(G);

% Betrag des Frequenzgangs
G_RC = @(w) 1./sqrt(1+(w*tau).^2)

%% Grafiken
%----------------------------------------------------------------------
figure(1)
set(gcf,'units','normalized','position',[0.3 0.05,0.6,0.85])
clf

%% Amplitudengangsdiagramm
h1 = subplot(2,1,1);
set(h1,'position', [0.08,0.56,0.88,0.4]);
set(h1,'fontsize',12)
Ad = plot(freq,amp,'linewidth', 3);
set(h1,'xscale','log');
xlabel('Frequenz [Hz]')
set(h1,'ylim', [-45 5]);
grid on
title('Betragsfrequenzgang aktiver Tiefpass')
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
Pw = plot(freq,phi,'linewidth', 3);
%get(h2);
set(h2,'xscale','log');
set(h2,'ylim', [5 50]);
ylabel('Phasen winkel [°]')
xlabel('Frequenz [Hz]')
grid on
title('Argument frequenzgang aktiver Tiefpass')

%% Bodediagramm
%h2 = subplot(2,1,2);
%set(h2,'position', [0.08,0.08,0.88,0.4]);
%set(h2,'fontsize',12)
%f = logspace(2,5,1000)
%hb = semilogx(f, 20*log10(G_RC(2*pi*f)),'linewidth',2);
%grid
%title('RC-Tiefpass, Betragsfrequenzgang')
%hold on
%yline(-3,'k--')
%xline(fg,'k--')
%ylabel('Dämpfung [dB]')
%xlabel('Frequenz [Hz]')
%hold off