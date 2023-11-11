function [a0, a, b] = fourierzerlegung_spektrum(fT,T,n)
% FOURIERZERLEGUNG_SPEKTRUM plottet Oberschwingungen und Spektrum von fT(t)
%
% fourierzerlegung_spektrum(fT,T,n) berechnet die ersten n+1 reellen
% Fourier-Koeffizienten der auf [0, T] definierten Funktion fT(t)
% und visualisiert f (die periodische Fortsetzung von fT) und dessen
% DC-Anteil sowie die AC-Anteile bis zur n-ten (Ober-)Schwingung
% für t im Intervall [-T,2T].
% In einem weiteren Diagramm wird das Amplitudenspektrum dargestellt.
% Aufrufbeispiele:
%	[a0,a,b] = fourierzerlegung_spektrum(@(t) t/pi, 2*pi, 9)
%	fourierzerlegung_spektrum(@(t) abs(sin(t)))

% Mev, 11/2019, 11/2020

format compact; format long;    % legt Darstellung im Command Window fest

%% Parameter der Fourierreihe, Definition f(t) für 0<=t<T
if nargin < 3
    n = 9;
    if nargin < 2
        T = 2*pi;
        if nargin < 1
            fT = @(t) 2*(t < T/2)-1;  % Rechteck-Signal
            %fT = @(t) t/pi;           % Sägezahn
        end
    end 
end
if n>9
    disp('n wird auf den Maximalwert 9 begrenzt.')
    n = 9;
end
omega = 2*pi/T;
t_limit = [-T, 2*T];

%% Definition f(t), Periodische Fortsetzung
% f(t=k*T+Rest) = f(t=Rest) = fT(t=Rest)
% Deshalb Anwendung der Modulo-Funktion mod(t,T)
f = @(t) fT(mod(t,T));   % periodische Fortsetzung über [0,T] hinaus

%% Bestimmung der Fourierkoeffizienten durch numerische Integration
a0 = (2/T)*integral(f,0,T);
a = zeros(n,1); b=zeros(n,1);
for k=1:n
    a(k)=(2/T)*integral(@(t) f(t).*cos(k*omega*t),0,T);
    b(k)=(2/T)*integral(@(t) f(t).*sin(k*omega*t),0,T);
end
% Null-Elemente (wie z. B. bei Rechtecksignal) gleich Null setzen
% und Amplituden berechnen
a(abs(a)<1e-9) = 0;
b(abs(b)<1e-9) = 0; 
A = sqrt(a.^2+b.^2);

%% Grafik: Harmonische, Fourierapproximation, Spektrum
figure(1)
set(gcf,'units','normalized','position',[0.08,0.1,0.5,0.7])
clf

% Diagramm der Funktion und Fourierapproximation
hax(1) = subplot(3,1,1);
hf = fplot(f, t_limit, 'color','b');
grid on
xlabel('Zeit')
title('Fourierapproximation einer Funktion, Harmonische und Spektrum')
hold on;
% DC-Anteil
fk = @(t) ones(size(t))*a0/2;   % ones() vermeidet "vectorize"-Warnung
h10 = plot(t_limit,fk(t_limit),'linestyle','--','color','k');
text(-1.2*T,a0/2,'$\frac{a0}{2}$','interpreter','latex','fontsize',16)
ylimits = hax(1).YLim;
ym=sum(ylimits)/2; yd=diff(ylimits);
ylim(ym+0.6*[-yd,yd])   % Diagrammskala nach oben und unten um 10% erweitern

% Diagramm der Harmonischen
hax(2) = subplot(3,1,2);
ymax = ceil(max(A)*12)/10;
ylim([-ymax,ymax])
grid on
xlabel('Zeit')
hold on;
set(hax(1:2),'xlim',t_limit)

% Diagramm des Spektrums
hax(3) = subplot(3,1,3);
h30 = stem(0,a0/2,'linewidth',2,'color','k');
grid on
xlabel('Frequenz')
hold on;
ymax = ceil(max([a0/2;A])*12)/10;
set(hax(3),'xlim',[0,n/T],'ylim',[0,ymax])
set(hax(3),'xtick',0:1/T:n/T)
set(hax,'fontsize',14)

% Oberschwingungen in die Plots eintragen
% k=1: Grund; k=2: 1.Ober; k=3: 2.Ober; ....
colour = {'r';'b';'g';'c';'m';'k';'b';'b';'b'};
for k = 1:n
    pause(1)
    if k>1, delete(h1); end
    harm_k = @(t) a(k).*cos(k*omega*t) + b(k).*sin(k*omega*t);
    fk = @(t) fk(t) + harm_k(t);
    h1 = fplot(hax(1),fk, t_limit,'color','k');
    h2 = fplot(hax(2),harm_k, t_limit,'color',colour{k});
    h3 = stem(hax(3),k/T,A(k),'linewidth',2,'color','k');
end
hold off
