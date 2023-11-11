function [] = floetentoene_spektrum()
% FLOETENTOENE
% Ermöglicht eine 5-Sekunden Aufnahme z. B. von einer Blockflöte über
% den Mic-Eingang des PC und berechnet und zeigt anschließend das Spektrum
% bis zur Frequenz f_S/2
% f_S kann vorgegeben werden (Default: 12 kHz)

% Mev, 23.11.2020 Ohne Abspielen der Aufnahme, Spektrum nur bis f_S/2

% Abtastrate der Aufnahme abfragen, mit Defaultwert
fSdef = 12e3;
fS = input(['Abtastfrequenz für diese Aufnahme [', num2str(fSdef/1e3), 'kHz]? fS = '])
if isempty(fS)
    fS = fSdef;
end

% Aufnahme starten
%--------------------------------------------------------------------
r = audiorecorder(fS, 16, 1);
disp('Bitte 5 Sek. ins Mikro flöten oder einen Ton summen ...')
pause(1)
record(r);
for i = 1:5
    disp(i)
    pause(1)
end
stop(r);
disp('stop')
pause(1)
disp('und hier das Spektrum der Aufnahme ...')

%% Spektrum dieser Aufnahme (gemitteltes-Spektrum mit myfft())
%--------------------------------------------------------------------
floetenton = getaudiodata(r, 'double'); % Aufnahme als Array im Workspace
ns = length(floetenton);
nfft = 4096;
li = 1:nfft;			% Indexvektor des Folgenausschnitts
dl = nfft/4;            % Abstand aufeinanderfolgender Ausschnitte
f = (li-1)'/nfft*fS;    % Frequenzachse des Spektrums
win = hanning(nfft);    % Leckeffekt verringern durch Hanning
Sp = zeros(nfft,1);
nspec = 0;
while li(nfft) <= ns
    nspec = nspec + 1;
    flk = floetenton(li);
    S = fft((flk-mean(flk)).*win);
    Sp = Sp + abs(S);
    li = li + dl;
end
Sp = Sp / nspec;

% Plot
%--------------------------------------------------------------------
figure(1)
clf
if ~strcmp(get(gcf,'windowstyle'),'docked')
    set(gcf,'units','normalized','position',[0.35 0.3,0.57,0.52])
end
axes('position',[0.08, 0.1, 0.89, 0.83])
hl1 = plot(f(1:nfft/2+1),Sp(1:nfft/2+1));
set(hl1,'linewidth',1.5)
xlim([0 fS/2])
grid minor
title('Spektrum der Aufnahme')
xlabel('Frequenz [Hz]')


function w = hanning(n)
% HANNING(N) liefert das N-Werte Hanning-Fenster als Spaltenvektor
w = 0.5*(1 - cos(2*pi*(1:n)'/(n+1)));

