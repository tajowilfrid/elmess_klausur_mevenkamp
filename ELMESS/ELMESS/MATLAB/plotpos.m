function h = plotpos(ndiag,ddiag,dleft,dbottom,dtop,dright)

% PLOTPOS positioniert ndiag Diagramme an definierter Position.
%
% Dabei muss der linke Rand, der Abstand oben und/oder unten sowie
% der Abstand zwischen den Diagrammen jeweils in Prozent (!) der
% Hoehe bzw. Breite der figure angegeben werden.  
% D.h.: werden dleft, dbottom und dtop auf 0 gesetzt, so liegen die
% Raender der Diagramme am Rand der figure, so dass also keine
% Achsbeschriftungen mehr erscheinen.
% 
% Aufruf: h = plotpos(ndiag,ddiag [,dleft,dbottom,dtop,dright]);
%
% Eingabeparameter:
%
% ndiag      - Anzahl der Diagramme (nur eine Spalte moeglich)  
% ddiag      - Abstand zwischen den Diagrammen 
% dleft      - linker Rand  (optional), Default: 0.06
% dbottom    - unterer Rand (optional), Default: 0.05
% dtop       - oberer Rand  (optional), Default: 0.03
% dright     - rechter Rand (optional), Default: 0.06
%
% Ausgabeparameter:
%
% h          - Vektor, der die Handles aller Diagramme von oben nach unten
%              sortiert enthaelt
%

%
% L. Weise,	31.10.95
% M. Mevenkamp,	12.04.96	überarbeitet
%

% Parameterübergabe prüfen

if (nargin < 2 | nargin > 6 | nargout > 1 )
   error('Aufruf:   h = plotpos(ndiag,ddiag,dleft,dbottom,dtop,dright);');
end

clf


% Defaultwerte setzen

if nargin < 3
   dleft   = 0.06;
   dbottom = 0.05;
   dtop    = 0.03;
   dright  = 0.06;
elseif nargin < 4
   dbottom = 0.05;
   dtop    = 0.03;
   dright  = 0.06;
elseif nargin < 5
   dtop    = 0.03;
   dright  = 0.06;
elseif nargin < 6
   dright  = 0.06;
end


% Positionen der Diagramme bestimmen und Plausibilitäts-Pruefung
% Diagrammhoehe bestimmen 

blank = dtop + ((ndiag -1)* ddiag) + dbottom; 
if blank > 0.9
   error('Der nicht bedruckbare Bereich ist zu gross!')
end
rest = 1 - blank;
dhoe = rest/ndiag;


% Diagrammbreite

blank = dleft + dright;
if blank > 0.9
   error('Der nicht bedruckbare Bereich ist zu gross!')
end
dwei = 1 - blank;


% Diagramme erzeugen

for it = 1:ndiag
    h(it) = axes;
    pos = [dleft (dbottom + ((ddiag+dhoe)*(it-1))) dwei dhoe];
    set(h(it),'Position',pos)
end

h = fliplr(h)';
