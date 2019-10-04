% DILATAÇÃO

original = imread('lena.png');
binarizada = im2bw(original);

filtro(1:3, 1:3) = true;

[tam_linhas,tam_colunas] = size(binarizada);

dilatada = binarizada;

[m,n] = size(filtro);

for i= 1:tam_linhas
    for j= 1:tam_colunas
        hit = 0;
        for x = 1:m
            for y = 1:n
                if  (i+x-1 < tam_linhas && j+y-1<tam_colunas)
                    if ( filtro(x,y) == 1 && binarizada(i+x-1,j+y-1) == 1)
                        hit = 1;
                    endif
                endif
                
            endfor
        endfor
        if (hit ==1)
            dilatada(i,j) = 1;
        endif
    endfor
endfor

borda_externa = dilatada - original;

figure;
imshow(original);
title ("Original");
figure;
imshow(borda_externa);
title ("Borda Externa");