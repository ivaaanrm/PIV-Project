function [imaq,llindars]=Cuantificador_MaxLloyd(ima,L,valini)

% Quantificaci? ?ptima segons eqm d'una imatge
% Usa l'algorisme Max-Lloyd de Matlab
%
% Format: [imaq,llindars]=Cuantificador_MaxLloyd(ima,L,valini)
%         ima: imatge d'entrada
%           L: nombre de nivells
%      valini: valors inicials (opcional). Per defecte equidistribuits
%        imaq: imatge quantificada
%    llindars: llindars de decisi?
%
% TG Mar?-2016

%ima=double(ima);
[N,M]=size(ima);
max_ima=double(max(max(ima)));
min_ima=double(min(min(ima)));
if nargin<3, 
    valini=(1:2:2*L)*(max_ima-min_ima)/L/2; 
    valini = valini + min_ima;
end
aux=reshape(ima,M*N,1);
[llindars,valq] = lloyds(aux,valini);
[~,auxq] = quantiz(aux,llindars,valq);
imaq=reshape(auxq,N,M);
