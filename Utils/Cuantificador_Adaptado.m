function im_sal = Cuantificador_Adaptado(im_ent, N)
% CUANTIFICADOR_ADAPTADO de N niveles
%  
%  im_sal=cuantificador_adaptado(im_ent, N) ecualiza el
%  histograma de la imagen de valores reales im_ent y
%  a continuación cuantifica la imagen resultante mediante
%  un cuantificador uniforme de N niveles. Finalmente,
%  deshace la transformación de contraste implícita a la
%  ecualización, para evitar variaciones de contraste de
%  la imagen original.
%
%  Ver también CUANTIFICADOR_ADAPTADO
%
% JRC Feb98, josep@gps.tsc.upc.es
% P Salembier, Mar08 

% calcula y ecualiza el histograma
[im_eq,T]=histeq(im_ent,256);

% cuantifica
if (N>0)
%im_eqq = round((N-1)*im_eq)/(N-1);
    im_eqq = quantificuniforme(im_eq,N);
else
	error('El número de niveles debe ser superior a 1');
end

% contraste inverso: el mapping efectuado por la 
% ecualizacion está en T. Calculamos una aprox. 
% del maping inverso
[X,map] = gray2ind(im_eqq,256);
newmap = zeros(size(map));
for i=1:256 
    newmap(T(i)*255+1,1)=(i-1)/255.0;
end
for i=2:256 
    newmap(i,1)=max(newmap(i,1),newmap(i-1,1));
end
newmap(256,1)=newmap(255,1)+newmap(255,1)-newmap(254,1);
newmap(:,2)=newmap(:,1);
newmap(:,3)=newmap(:,1);

% Se efectua el maping inverso
im_sal = double(ind2gray(X,newmap))/256;
  
