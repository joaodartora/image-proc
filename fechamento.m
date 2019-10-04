function Fechamento()

I = imread('Fig0911(a)(noisy_fingerprint).tif');
B = im2bw(I); %comando do octave para binarizar a imagem


filtro(1:3, 1:3) = true;

dilatada = dilatar(B,filtro);
erodida = erodir(dilatada,filtro);

fechamento_mat = imclose(B,strel('square',7)); %função do octave para fechamento, para comparação das 2

figure;
imshow(B); 
title('Imagem binarizada')
figure;
imshow(erodida); 
title('Imagem com fechamento')
figure;
imshow(fechamento_mat); 
title('Fechamento do Octave')


end

%1º passo: Dilatação
function dilatada = dilatar(B,filtro)

%g
[linha_gx,coluna_gy] = size(B);
dilatada = B;

[m,n] = size(filtro);

for i= 1:linha_gx
    for j= 1:coluna_gy
        hit = 0;
        
        for x = 1:m
            for y = 1:n
                
                if  (i+x-1 < linha_gx && j+y-1<coluna_gy)
                    if ( filtro(x,y) == 1 && B(i+x-1,j+y-1) == 1)
                        hit = 1;
                        
                    end
                end
                
            end
        end
        
        if (hit ==1)
            dilatada(i,j) = 1;
        end
        
    end
end
end

%2º passo: Erosão da imagem anteriormente dilatada

function erodida = erodir(B,filtro)
[m,n] = size(filtro);

n_pretos = 0; %contador de pontos pretos na máscara

for i = 1:m
    for j = 1:n
        if (filtro(i,j) == 1)
            n_pretos = n_pretos +1;
        end
    end
end

%g
[linha_gx,coluna_gy] = size(B);
erodida(1:linha_gx,1:coluna_gy) = false;

for i= 1:linha_gx
    for j= 1:coluna_gy
        fit = 0;
        count = 0;
        
        for x = 1:m
            for y = 1:n
                if  (i+x-1 < linha_gx+1 && j+y-1<coluna_gy)
                    if ( filtro(x,y) == 1 && B(i+x-1,j+y-1) == 1)
                        fit = fit + 1;
                    end
                else
                    if(filtro(x,y) == 1 )
                        count = count + 1;
                    end
                end
            end
        end
        
        if (fit == n_pretos - count)
            erodida(i,j) = 1;
        end
        
    end
end

end




