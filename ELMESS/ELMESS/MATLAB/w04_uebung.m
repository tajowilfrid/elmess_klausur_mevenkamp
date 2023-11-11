% Übung Woche 4
% Mev, 11/2021


%% Simulation
t_end = 10;
g = @(t) t-2;
dydt = @(t,y) [y(2); g(t)-y(1)-y(2)];
y0 = 0;
dy0 = 0;
[tsim,ysim] = ode45(dydt, [0,t_end], [y0;dy0]);

%% Analytische Lösung
A = 1; B = -3;
C = sqrt(28/3); phi = atan(-1/3/sqrt(3));
ya = @(t) A*t+B+C*exp(-t/2).*cos(sqrt(3)/2*t+phi)

%% Grafik
figure('units','normalized','position',[0.2 0.3,0.6,0.6])
h = axes('position', [0.07,0.11,0.89,0.83]);
set(h,'fontsize',12)
plot(tsim,ysim,'linewidth',2)
grid minor
%ylim([0,6])
ylabel("Ausgangsgröße y(t), y'(t)")
xlabel('Zeit t')
% text(21,0.2,'T','fontsize',18)
% text(3,3.3,'63%','fontsize',14)
% title(['Sprungantwort des Verzoegerungssystems \ $ T\cdot\dot{y}+y=Ku $',...
%     '\ mit $K=5$ und $T=20$'],'interpreter','latex')

% Analytische Lsg. hinzufügen
hold on
fplot(ya,[0 t_end],'xr','linewidth',2)
hold off

%% Euler-Diskretisierung
T = 1/2;
N = 20;             % 20*T = t_end
xk = zeros(2,N);    % Initialisierung
xk(:,1) = [0; 0];     % x(0)
%for k = 1:N-1
%    xk(:,k+1) = .... x(:,k) ...  u(k*T) ...