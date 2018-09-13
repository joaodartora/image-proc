#----- CARREGA E EXIBE IMAGEM -----
x = imread('Fig0304(a)(breast_digital_Xray).tif');
imshow(x);
title ("Imagem Original");

#----- NEGATIVO DA IMAGEM -----
negativo = uint8(-1*(double(x)-255));
figure;
imshow(negativo);
title ("Negativo da imagem");

#----- AUMENTANDO O BRILHO -----
brilhoMaior = x + 50;
figure;
imshow(brilhoMaior);
title ("Brilho aumentado");

#----- DIMINUINDO O BRILHO -----
brilhoMenor = x - 50;
figure;
imshow(brilhoMenor);
title ("Brilho diminuído");

#----- AUMENTANDO O CONTRASTE -----
 limiar = 130;
 a = double(x)/limiar;
 b = a.^2;
 contrasteMaior = uint8(b*limiar);
 figure;
 imshow(contrasteMaior);
 title ("Contraste aumentado");
 
#----- DIMINUINDO O CONTRASTE -----
 d = double(x)/limiar;
 e = sqrt(d);
 contrasteMenor = uint8(e*limiar);
 figure;
 imshow(contrasteMenor);
 title ("Contraste diminuído");
 
 #----- BINARIZAÇÃO -----
 binario = x >= limiar;
 figure;
 imshow(binario);
 title ("Binarizada");