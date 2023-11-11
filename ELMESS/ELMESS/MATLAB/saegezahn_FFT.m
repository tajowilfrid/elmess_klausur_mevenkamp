function  [] = saegezahn_FFT()
% Erzeugt eine Sägezahn-Wertefolge und berechnet das Spektrum
% mit Grafik
% Mev, 10/2019

%% Sägezahnschwingung mit Amplitude A und Periodendauer T
%--------------------------------------------------------------------
A = 10;
T = 20;
nT = 50;                % Zahl der Perioden im Messzeitraum
N = nT * T;
t = (0:N-1)';           % Abtastzeit T_S = 1
x = rem(t,T)*A/T;

%% Fourier-Transformation
%--------------------------------------------------------------------
Xc = fft(x);            % komplexes Spektrum, N Werte
nc = length(Xc);

% Amplitudenspektrum (Frequenzachse bis zur halben Abtastfrequenz)
nf = nc/2;
f = (0:nf)'/N;
X = [abs(Xc(1)); 2*abs(Xc(2:nf)); abs(Xc(nf+1))] / N;


%% Grafik
%--------------------------------------------------------------------
figure(1)
clf
set(gcf,'units','normalized','position',[0.08 0.2,0.5,0.5])

% Zeitverlauf
subplot(2,1,1)
plot(t,x)
grid
legend('Zeitverlauf')
ylabel('x(t)')
xlabel('Zeit')
text(0.94,-0.08,'sec','units','normalized')
title('Zeitsignal und Spektrum einer Sägezahnschwingung')

% Amplitudenspektrum
subplot(2,1,2)
hl1 = stem(f,X);
grid
set(hl1,'linewidth',1.5)
legend('Amplitudenspektrum')
ylabel('|X(\omega)|')
xlabel('Frequenz')
text(0.94,-0.08,'Hz','units','normalized')

