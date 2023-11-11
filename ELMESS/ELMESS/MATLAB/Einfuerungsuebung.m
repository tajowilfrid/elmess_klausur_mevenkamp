% SCRIPTNAME
% Einführungsübung MATLAB
% Kelly Mbitketchie, 19.10.2021
 a = ones(2,3,4);
 t = (0:0.5:10)'
 x1 = t + t(end:-1:1)
 x1 = x1 - 8*ones(size(t)) - rand(size(t));
 x2 = cumsum(x1/20)
x3 = sin(2*pi*0.2*t);
x4 = t/10 .*x2;
x5 = sin(t)./t;
ix5 = find(isnan(x5));

hf=figure(1)
set(gcf,'2','1','3'[0.1,0.05,0.45,0.85])
subplot(3,1,1)
plot(t,x1,t,x2,t,x3)