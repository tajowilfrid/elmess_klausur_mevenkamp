% EULER_HEUN_VERGLEICH
% Mev, 24.9.2021

%% Vektor-Dgl. einer Schwingung
A = [0, 1
    -1, 0];
x0 = [1;0];
C = [1,0];

%% Simulation mit MATLAB ODE45
t_end = 30;
dxdt = @(t,x) A*x;
[t,xsim] = ode45(dxdt,[0, t_end],x0);
y = C*xsim';

%% Euler-Diskretisierung und rekursive Berechnung
T = 0.03;
N = round(t_end/T)+1;
AT = eye(2)+A*T;
xk = zeros(2,N);    % Ausgabearray initialisieren
xk(:,1) = x0;
for k=1:N-1
    xk(:,k+1) = AT*xk(:,k);
end
yk = xk(1,:)';

%% Ergebnis
close all
figure(1)
plot(t,y,'b--','linewidth',1.5)
hold on
plot(0:T:t_end,yk)
grid
xlabel('t')
set(gca,'xaxislocation','origin','yaxislocation','origin')


%% Heun-Diskretisierung und rekursive Berechnung
T = 0.1;
N = round(t_end/T)+1;
AT = inv(eye(2)-A*T/2)*(eye(2)+A*T/2);
xk = zeros(2,N);    % Ausgabearray initialisieren
xk(:,1) = x0;
for k=1:N-1
    xk(:,k+1) = AT*xk(:,k);
end
yk = xk(1,:)';
plot(0:T:t_end,yk,'g')
legend('kontinuierlich','diskret, rekursiv (Euler)', ...
    'diskret, rekursiv (Heun)','location','sw')
hold off
