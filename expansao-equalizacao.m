#----- CARREGAMENTO DA IMAGEM E VARREDURA DOS PIXELS -----

# Carrega imagem
imagem = imread('Fig0304(a)(breast_digital_Xray).tif');
imhist(imagem);
title("Histograma Original");
figure;
imshow(imagem);
title("Imagem original");

imagem = double(imagem);

# Encontra tom de cinza máximo e mínimo
rmin = 256;
rmax = 0;

linha = rows(imagem);
coluna = columns(imagem);

for i = 1 : linha
  for j = 1 : coluna
    if imagem(i,j) < rmin
      rmin = imagem(i, j);
    elseif imagem(i, j) > rmax
      rmax = imagem(i, j);
    endif
  endfor
endfor

printf ("Pixel mais claro: %d\n", rmax);
printf ("Pixel mais escuro: %d\n", rmin);

#----- EXPANSÃO -----

L = 256;

imagemExp = imagem;

for i = 1 : linha
  for j = 1 : coluna
    imagemExp(i,j) = (((imagemExp(i,j)-rmin)/(rmax-rmin))*(L-1));
  endfor
endfor

imagemExp = uint8(imagemExp);

figure;
imhist(imagemExp);
title("Histograma Expandido");
figure;
imshow(imagemExp);
title("Imagem Expandida");

#----- EQUALIZAÇÃO -----

imagemEqual = imagemExp;

imagemEqual = double(imagemEqual);

tabelaCores = [1:256];
somatorio = 0;

for m = 1 : 256
  for n = 1 : m
      somatorio = somatorio+n;
  endfor
  tabelaCores(m) = somatorio;
endfor

for i = 1 : rows(imagemExp)
  for j = 1 : columns(imagemExp)
    corEqual = imagemEqual(i,j);  
    imagemEqual(i,j) = imagemEqual(i,j) = (((L-1)/(rows(imagemExp)*columns(imagemExp)))*tabelaCores(corEqual+1));
  endfor
endfor

imagemEqual = uint8(imagemEqual);

figure;
imhist(imagemEqual);
title("Histograma Equalizado");
figure;
imshow(imagemEqual);
title("Imagem Equalizada");











































