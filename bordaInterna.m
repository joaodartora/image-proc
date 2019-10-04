% BORDAS INTERNAS

original = imread('lena.png');
binarizada = im2bw(original);

filtro(1:3, 1:3) = true;

[m,n] = size(filtro);

pt_pretos = 0;

for i = 1:m
    for j = 1:n
        if (filtro(i,j) == 1)
            pt_pretos = pt_pretos +1;
        endif
    endfor
endfor

% Tamanho da imagem
[tam_linhas,tam_colunas] = size(binarizada);

% Cria uma imagem vazia
erodida(1:tam_linhas,1:tam_colunas) = false;

% Percorrendo a matriz
for i = 1:tam_linhas
    for j = 1:tam_colunas
        fit = 0;
        cnt = 0;
        for x = 1:m
            for y = 1:n
                if  (i+x-1 < tam_linhas+1 && j+y-1<tam_colunas)
                    if ( filtro(x,y) == 1 && binarizada(i+x-1,j+y-1) == 1)
                        fit = fit + 1;
                    endif
                else
                    if(filtro(x,y) == 1 )
                        cnt = cnt + 1;
                    endif
                endif
            endfor
        endfor
        if (fit == pt_pretos - cnt)
            erodida(i,j) = 1;
        endif
    endfor
endfor

borda_interna = original - erodida;

figure;
imshow(original);
title ("Original");
figure;
imshow(borda_interna);
title ("Borda Interna");