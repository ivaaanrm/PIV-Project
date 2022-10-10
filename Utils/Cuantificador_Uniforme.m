function [imaq,llindars]=Cuantificador_Uniforme(ima,L)
% Quantificació uniforme L nivells d'una imatge de reals entre 0 i 1
% TG. Març 2016

if max(max(ima))>1, error('la imatge ha de ser de reals entre 0 i 1'), end
[N,M]=size(ima);
valq=1/(2*L):1/L:1;
llindars=(1:L-1)/L;
aux=reshape(ima,M*N,1);
[~,auxq] = quantiz(aux,llindars,valq);
imaq=reshape(auxq,N,M);
