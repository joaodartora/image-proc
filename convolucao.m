# Lê imagem
original = imread('lua.jpg');

# Mostra original
imshow(uint8(original));
title ('Imagem original');

# TRANSFORMA PRA DOUBLE
original = double(original);

# Cria filtro
filtro = zeros(3,3);

#filtro = [1 1 1;1 1 1;1 1 1]/9; # MÉDIA/BOX BLUR (PASSA-BAIXA)
#filtro = [1 2 1;2 4 2; 1 2 1]/16 # MÉDIA/GAUSSIAN BLUR (PASSA-BAIXA)

#filtro = [0 -1 0; -1 4 -1;0 -1 0]; # 4-CONECTADA (PASSA-ALTA)
#filtro = [-1 -1 -1;-1 8 -1;-1 -1 -1]; # 8-CONECTADA (PASSA-ALTA)
#filtro = [-2 -1 0; -1 1 1; 0 1 2]; # AUMENTA RELEVO (PASSA-ALTA)
#filtro = [0 -1 0; -1 5 -1;0 -1 0]; 


# Flipagem do filtro
filtro = flipud(fliplr(filtro));

# Recebe o tamanho da imagem e do filtro

linhasImagem = rows(original);
colunasImagem = columns(original);

linhasFiltro = rows(filtro);
colunasFiltro = columns(filtro);

# Insere uma borda na imagem
original = padarray(original,[2,2]);

# Cria imagem (matriz) pra receber resultado da convolução
resultado = zeros(linhasImagem+linhasFiltro-1, colunasImagem+colunasFiltro-1);

# Realiza a filtragem com o kernel desejado

for x = 1 : linhasImagem+linhasFiltro-1
  for y = 1 : colunasImagem+colunasFiltro-1
    for i = 1 : linhasFiltro
      for j = 1 : colunasFiltro
        resultado(x, y) = resultado(x, y) + (original(x+i-1, y+j-1) * filtro(i, j));
       endfor
    endfor
  endfor
endfor  

# Exibe resultado 

figure;
imshow (uint8(resultado));
title ('Imagem filtrada');

# Realiza aguçamento da imagem

#resultado = padarray(resultado,[1,1]);
#agucada = imadd(original, resultado);
#figure;
#imshow(uint8(agucada));
#title('Imagem aguçada');


