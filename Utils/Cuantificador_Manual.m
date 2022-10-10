function [imaq,llindars]=Cuantificador_Manual(ima,L)

% Cuantificador definit per l'usuari. Entrada interativa dels nivells de
% quantificació sobre l'histograma.
%
% Format: imaq=Cuantificador_Manual(ima,L)
%         ima: imatge d'entrada
%           L: nombre de nivells
%        imaq: imatge quantificada
%
% TG Març-2016

[counts,valbin]=imhist(ima);
f=figure('units','normalized','position',[0,0.5,1,0.5]); ha=axes;
textfix='remaining levels: ';

continuar=0;
while continuar==0
    stem(valbin,counts,'Marker','none','color','b')
    title([textfix,num2str(L)])
    limity=get(ha,'ylim');
    for i=1:L
        [valq(i),~]=ginput(1);
        hl(i)=line([valq(i),valq(i)],limity,'color','k');
        title([textfix,num2str(L-i)])
    end
    valq=sort(valq);
    aux=diff(valq)/2;
    llindars=valq(1:end-1)+aux;
    llindarsext=[0,llindars,1];
    set(hl,'ydata',[0,0],'marker','+','markersize',40,'linewidth',1)
    for i=1:L+1
        hlll(i)=line([llindarsext(i),llindarsext(i)],limity,'color','r','linestyle','--','linewidth',2);
    end
    
    comseguir = questdlg('Validate Selection','','Yes','Reset','Cancel','Yes');
    switch comseguir
        case 'Yes'
            continuar=1;
        case 'Reset'
            delete(hl), delete(hlll)
        case 'Cancel'
            continuar=2;
    end
end

close(f)
if continuar==2
    imaq=[];
else
    [N,M]=size(ima);
    aux=reshape(ima,M*N,1);
    [~,auxq] = quantiz(aux,llindars,valq);
    imaq=reshape(auxq,N,M);
    %figure;Histograma(ima,imaq)
end