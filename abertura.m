function Abertura()
  
 %ABERTURA � UMA EROSAO SEGUIDA DE UMA DILATA��O
 
original = imread('Fig0911(a)(noisy_fingerprint).tif');
binarizada = im2bw(original); %comando do octave para binarizar a imagem

filtro(1:3, 1:3) = true;%Cria um filtro 3 x 3
% 1 1 1
% 1 1 1
% 1 1 1

erodida = erodir(binarizada,filtro); % Faz Erosao
dilatada = dilatar(erodida,filtro);% Faz Dilatacao
abertura_mat = imopen(binarizada,strel('square',10)); %fun��o do octave para abertura, para compara��o das 2


%Plota os resultados
figure;
imshow(binarizada);
title('Imagem binarizada')
figure;
imshow(dilatada); 
title('Abertura')
figure;
imshow(abertura_mat); 
title('Abertura do Octave');

end


%1� passo: Eros�o

function erodida = erodir(binarizada,filtro)
[m,n] = size(filtro);

num_pretos = 0; %contador de pontos pretos na m�scara

for i = 1:m
    for j = 1:n
        if (filtro(i,j) == 1)
            num_pretos = num_pretos +1;
        end
    end
end

%pega o tamanho da imagem
[linha_gx,coluna_gy] = size(binarizada);
%cria uma 'imagem vazia'
erodida(1:linha_gx,1:coluna_gy) = false;

%percorre a imagem
for i= 1:linha_gx
    for j= 1:coluna_gy
        % controla os fit
        fit = 0;
        count = 0;
        % percorre o filtro
        for x = 1:m
            for y = 1:n
                %controla as bordas
                if  (i+x-1 < linha_gx+1 && j+y-1<coluna_gy)
                  %se a posi��o do filtro � 1 e a posi��o da imagem tb � 1
                    if ( filtro(x,y) == 1 && binarizada(i+x-1,j+y-1) == 1)
                      %incrementa os fit
                        fit = fit + 1;
                    end
                else
                    if(filtro(x,y) == 1 )
                        count = count + 1;
                    end
                end
            end
        end
        %Testa se houve fit, ou seja, todos os pixels do elemento estruturante 
        %est�o em uma regi�o de 1s da imagem, ent�o esse pixel ser� 1.
        if (fit == num_pretos - count)
            erodida(i,j) = 1;
        end
        
    end
end

end

%2� passo: Dilata��o da imagem anteriormente erodida
function dilatada = dilatar(binarizada,filtro)

%g
[linha_gx,coluna_gy] = size(binarizada);
dilatada = binarizada;

[m,n] = size(filtro);

for i= 1:linha_gx
    for j= 1:coluna_gy
        hit = 0;
        
        for x = 1:m
            for y = 1:n
                
                if  (i+x-1 < linha_gx && j+y-1<coluna_gy)
                    if ( filtro(x,y) == 1 && binarizada(i+x-1,j+y-1) == 1)
                        hit = 1;
                        
                    end
                end
                
            end
        end
        %Testa se houve hit, ou seja, apenas um dos pixels do elemento estruturante 
        %esta em uma regi�o de 1s da imagem, ent�o esse pixel ser� 1.
        
        if (hit ==1)
            dilatada(i,j) = 1;
        end
        
    end
end
end