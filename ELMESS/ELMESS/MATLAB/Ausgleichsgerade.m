function [m, b, sm, sb] = Ausgleichsgerade(x,y)
N = length(x);
sI2 = sum((x-mean(x)).^2)/(N-1);    % oder (x-mean(x))'.*(x-mean(x))/(N-1)
sIU = sum((x-mean(x)).*(y-mean(y)))/(N-1);  % (x-mean(x))'*(y-mean(y))/(N-1)
m = sIU/sI2
b = mean(y)-m*mean(x)
sU = sqrt(sum((y-mean(y)).^2)/(N-1));
rIU = sIU/sU/sqrt(sI2);
smrel = sqrt(1/rIU^2-1)/sqrt(N-2);
sm = abs(smrel*m)
sb = sm*sqrt(mean(x.*x))
end