% Dgl 2. Ordnung simulieren (kontinuierlich und diskret)
% Übungsblatt 2, Aufgabe 2
% Vorlage von M. Mevenkamp, 5.11.21
% ergänzt von

figure("Units","normalized","Position",[0.1 0.3 0.5 0.5])

%% Lösung kontinuierlich
% Dgl  y'' - (ln 2)^2 * y = 2 * (ln 2)^2 * u
% y1' = y2;
% y2' = (ln 2)^2 * y + 2 * (ln 2)^2 * u
ln22 = log(2)^2;
u = @(t) -2.5*(t<1);
y0 = [3; 0];
tmax = 5;
dydt = @(t,y) [y(2); ln22*(y(1)+2*u(t))];
[tode, yode] = ode45(dydt,[0,tmax],y0,odeset('RelTol',1e-3));
plot(tode,yode(:,1),'b')
grid; ylim([0,9]); xlabel('Zeit t')

%% Vektor-Differentialgleichung
A = [log(2) 0; 0 -log(2)];
B = [log(2); -log(2)];
dxdt = @(t,x) A*x+B*u(t);
x0 = [1;1]*y0(1)/2;
T = 1/2;
kmax = round(tmax/T);
tk = (0:kmax)*T;
[tv,xv] = ode45(dxdt,tk,x0)
yv = xv(:,1)+xv(:,2);
hold on
plot(tk,yv,'o')

%% Euler-Diskretisierung
% x_k+1 = A*x_k + B*u_k
% ...


%% Exakte Diskretisierung
% ...


