% halogenstrahler_Lsg.m
%
% Lösung zur Übungsaufgabe 2.4.3 "Strahlungsleistung eines Halogenstrahlers"
% Mev, 28.9.08

%% Messreihe, logarithmische Werte
% hier wie folgt erzeugt: Phi = 50 .* D.^1.8 .* (0.95+0.1*rand(size(D)))
D = [100:-20:20]'/100;
Phi = [51; 33; 19; 10; 3];
Dlog = log10(D);
Philog = log10(Phi);

%% Ausgleichsgerade
p = polyfit(Dlog,Philog,1);
D_ag = linspace(Dlog(1),Dlog(end));
Phi_ag = p(1)*D_ag+p(2);
disp(['Steigung x = ', num2str(p(1))])

% Koeffizient c = Phi(D=1) bzw. logarithmisch: c = 10^Philog(Dlog=0)
disp(['Koeffizient c = ', num2str(10^polyval(p,0))])

%% Grafik
hl = plot(Dlog,Philog,'o',D_ag,Phi_ag);
grid
text(0.3, 0.6,['Steigung x = ' num2str(p(1),'%10.3g')],'fontsize',12,'units','normalized')
xlabel('lg(D)')
ylabel('lg(\Phi_e)')