function [] = fw_von_v_dlog()
%
% Windwiderstandskraft in Abhängigkeit von der Geschwindigkeit
% Ansatz:       Fw = c * v^x
% Ermittlung des Exponenten durch eine Ausgleichsgerade in der
% doppelt logarithmischen Darstellung der Windwiderstandskraft
% über der Geschwindigkeit
%

% Mev, 09/2008

%% Messreihe (fiktiv, aber realitätsnah)
%----------------------------------------------------------------------
v = (5:5:40)';

% Werte erzeugt durch
% fw = 0.1*v.^2 .*(1+0.4*(rand(size(v))-0.5)) 
fw = [
    2.6787
   11.0310
   24.6882
   38.2756
   66.3869
   78.1627
  132.5963
  130.0373
];

%% doppelt logarithmische Darstellung und Ausgleichsgerade
logv  = log10(v);
logfw = log10(fw);
mb = polyfit(logv, logfw, 1);
m = mb(1); b = mb(2);
vag = linspace(logv(1),logv(end));  % Wertepaare der Ausgleichsgerade
ag = m*vag+b;                       % zwecks Plot


%% Grafik
%----------------------------------------------------------------------
figure(1)
clf
set(gcf,'units','normalized','position',[0.1 0.3,0.5,0.6])
h = axes('position', [0.08,0.11,0.88,0.85]);
hl = plot(logv, logfw, 'bx', vag, ag, 'g');
set(hl(1),'linewidth',2)
set(hl(2),'linewidth',1)
grid
legend('Messwerte (doppelt logarithmisch)', 'Ausgleichsgerade','Location','SouthEast')
text(0.3, 0.6,['Steigung (= Exponent x)  = ' num2str(m,'%10.3g')],'fontsize',12,'units','normalized')
set(h,'fontsize',12)
axis([0.6 1.8 0.2 2.4])
ylabel('lg(Fw)')
xlabel('lg(v)')

