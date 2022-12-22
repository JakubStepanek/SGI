clear all;
close all;
clc

load digits_test;
% N...počet testovacích obrázků = 1000
% y_test...indexy tříd testovacích dat, rozměr: 1000x1 = Nx1
y_test = test_trida;
%MATLAB indexuje od čisla 1 =>
%Pokud spočítáme skóre pro číslovky od 0 do 9, budou tato skóre v poli, kde
%skóre pro číslovku 0 bude na pozici 1 a skóre pro číslovku 9 na pozici 10.
%Pokud pak bude mít např. číslovka 0 maximální skóre, bude index nejlepší třídy 1 nikoli 0.
%V referencich má ale číslovka 0 index třídy 0 a číslovka 9 index třídy 9 =>
%Pokud k těmto referenčním indexům přičteme číslo jedna, budou indexy
%sedět s MATLABEM a usnadníme si vyhodnocování úspěšnosti rozpoznávání!
N = size(y_test,2);
y_test = y_test + ones(1,N);

load digits_tren;
% Testovací data je nutné nejprve předzpracovat:
    % Je nutné je normalizovat = odečíst střední hodnotu trénovacích dat
        % Případně je možné je i vycentrovat
    % Dále jsou v rámci předzpracování testovací data převedena z matice
    % Nx32x32 do matice Nx(32*32+1)

X_test = data_preprocessing(test_data,tren_data);
% Funkce data_preprocessing lze optimalizovat pomoci vektorovych operaci. 
%X_test = data_preprocessing_fast(test_data,tren_data);

% načtení matice vah
% D...dimenze = a*b+1, kde a je výška a b je šířka obrázku = 1025
% C...počet tříd = 10
% W...matice vah klasifikátoru, rozměr: DxC 1025x10 = 
load multiclass_perceptron_params.mat;
D = size(W,1);
C = size(W,2);

%Nyní jsou k dispozici připravená testovací data v matici X_test a
%parametry klasifikátoru v matici W

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% KLASIFIKACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%I. Výpočet úspěšnosti (přesnosti) = accuracy pomocí dvou cyklů%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
accuracy = 0;
% ========================== VÁŠ KÓD ZDE ======================
% cyklus pres testovací data:
for i=1:N        
    maxscore = realmin('single'); %score nejlepší třídy   
    predict = -1; %Index nejlepší třídy
    % cyklus pres jednotlivé třídy:
    for c=1:C    
        %score = sigmoid( i-ty radek v X_test * c-ty sloupek v W )
        score = sigmoid_scalar(X_test(i,:) * W(:, c));

        % najdete tridu s nejvyssim skore
        if(score > maxscore)
            maxscore = score;
            predict = c;
        end
    end
    if (predict == y_test(i)) %Lze zapsat takto díky posunutí indexů, jinak by muselo být predict == y_test(i) + 1
        accuracy = accuracy+1;
    end
end
% Kontrola: první vypočtená hodnota score = 0.7729
% Kontrola: accuracy = 49%
% =============================================================
fprintf('Přesnost pomocí dvou vnořených cyklů: %f\n', 100*accuracy/N);
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%II. Výpočet přesnosti pomocí jednoho cyklu%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pouze vnější cyklus pro testovací data
tic
accuracy1 = 0;
% ========================== VÁŠ KÓD ZDE ======================
for i=1:N   
    % vynasobte data cisla "i" a vahy 
    scores = sigmoid_cycles(X_test(i, :) * W);
    % pomoci funkce max nalezneme nejvhodnejsi tridu (predict)
    [~, predict] = max(scores(:));
    if (predict == y_test(i))
        accuracy1 = accuracy1+1;
    end
end
% =============================================================
fprintf('Přesnost pomocí jednoho cyklu: %f\n', 100*accuracy1/N);
toc

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %III. Výpočet přesnosti bez použití cyklů !!!!%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
tic
% ========================== VÁŠ KÓD ZDE ======================
%Nejprve výpočet matice obsahující skóre pro všechna testovací data a třídy, její rozměr musí být N*C:
%vynasobne matici testovacich dat a vah perceptronu
scores = sigmoid_fast(X_test * W);
%Funkce max pak zjistí pozice maximální hodnoty v každém řádku předchozí
%matice, výsledkem je tedy vektor predicts, nejlepších skóre o rozměrech 1*N
[~, predicts] = max(scores,[],2);
%Výpočet přesnosti lze pak zapsat na jeden řádek elegantně jako:
accuracy2 = mean(double(predicts == y_test')) * 100;
% =============================================================
fprintf('Přesnost maticově: %f\n', accuracy2);
toc