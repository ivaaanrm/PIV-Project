function im_sal = cuantificador_uniforme_old(im_ent, N);
% CUANTIFICADOR_UNIFORME de im?genes de N niveles
%  
%  im_sal=cuantificador_uniforme(im_ent, N) cuantifica 
%  la imagen de valores reales im_ent con N niveles 
%  discretos equiespaciados
%
% PIM, Feb98

if (N>1)
im_sal = round((N-1)*im_ent)/(N-1);
else
	error('El n?mero de niveles debe ser superior a 1');
end 
return  
