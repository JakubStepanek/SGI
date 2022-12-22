clear all;
close all;
clc

% N...počet testovacích obrázků
% C...počet tříd

% načtení dat
% X_test...testovací data, rozměr: 1000x1x32x32 = NxHx32x32
    %   N=1000...počet testovacích obrázků    
    %   H1=1...hloubka obrázku = 1
    %   32x32...velikost obrázku
% y_test...indexy tříd testovacích dat, rozměr: 1000x1 = Nx1
load digits_tren.mat;
load digits_test.mat;
y_test = test_trida;

X_test = data_preprocessing_cnn(test_data,tren_data);
N = size(X_test,1);

%MATLAB indexuje od čisla 1 =>
%Pokud spočítáme skóre pro číslovky od 0 do 9, budou tato skóre v poli, kde
%skóre pro číslovku 0 bude na pozici 1 a skóre pro číslovku 9 na pozici 10.
%Pokud pak bude mít např. číslovka 0 maximální skóre, bude index nejlepší třídy 1 nikoli 0.
%V referencich má ale číslovka 0 index třídy 0 a číslovka 9 index třídy 9 =>
%Pokud k těmto referenčním indexům přičteme číslo jedna, budou indexy
%sedět s MATLABEM a usnadníme si vyhodnocování úspěšnosti rozpoznávání!
y_test = y_test + ones(1,N);

% načtení parametrů klasifikátoru
load cnn_based_classifier_params.mat;

tic
accuracy = 0;
%Vnější cyklus pro testovací data:
for n=1:1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %I. Výpočet první konvoluční vrstvy%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % PARAMETRY
    % ___________________________________________________
    % CW1...matice vah první konvoluční vrstvy
    % rozměr: F1xH1x3x3 = 8x1x3x3
    %   F1 = 8...počet filtrů konvoluční vrstvy
        F1 = size(CW1,1);
    %   H1 = 1...hloubka vstupu konv.vrstvy = hloubka vstupnich obrázků
    %   3x3...velikost konvolučního filtru    
    % Cb1...matice posunů (biasů) první konvoluční vrstvy
    % rozměr: F1x1 = 8x1
    
    % VSTUP
    % ___________________________________________________
    % Jeden obrázek o barevné hloubce 1 v matici X_test
    %   rozměry: H1x32x32 = 1x32x32
    
    % VÝSTUP
    % ___________________________________________________
    % 8 vrstev v matici convout1
    %   rozměry: F1x32x32 = 8x32x32
    %       proč 32?
    %       32 = 32 (velikost obr.) + 2 (rozšíření kvůli paddingu) - 3 (velikost filtru) + 1 
                   
    %Funkce squeeze odstraní první dimenzi matice a vytvoří matici 32x32       
    X_pad = squeeze(X_test(n,:,:));
    
    % Cyklus pro jednotlivé filtry této konvoluční vrstvy:
    for f=...
        %Výpočet konvoluce pro daný filtr
        convout1(...) = filter2(squeeze............);
        
        %Přičtení biasu:
        ...
    end    
    %Aplikace aktivační funkce ReLU pro všechny konvoluční filtry:
    ....
    
    % Kontrola: convout1(1,1,1)=0.1203
    % Kontrola: convout1(2,1,1)=0.2175
           
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %II. Výpočet druhé konvoluční vrstvy%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % PARAMETRY
    % ___________________________________________________
    % CW2...matice vah druhé konvoluční vrstvy
    % rozměr: F2xH2x3x3 = 8x8x3x3
    %   F2 = 8...počet filtrů druhé konvoluční vrstvy
        F2 = size(CW2,1);
    %   H2 = 8...hloubka vstupu druhé konvoluční vrstvy = počet filtrů předchozí
    %   konvoluční vrstvy => H2 = F1 !!!!!!!!!    
        H2 = size(CW2,2);    
    %   3x3...velikost konvolučního filtru    
    % Cb2...matice posunů (biasů) druhé konvoluční vrstvy
    % rozměr: F2x1 = 8x1
    
    % VSTUP
    % ___________________________________________________
    % výstup z předchozí konvoluční vrstvy o hlubce H1
    %   rozměry: H2x32x32 = 8x32x32    
    
    % VÝSTUP
    % ___________________________________________________
    % 8 vrstev v matici convout2
    %   rozměry: F2x32x32 = 8x32x32
    %       proč 32?
    %       32 = 32 (šířka respektive výška vstupu) + 2 (rozšíření kvůli paddingu) - 3 (velikost filtru) + 1         
    
    %Inicializace výstupu:
    convout2x = size(convout1,2)+2-size(CW2,3)+1;
    convout2y = size(convout1,3)+2-size(CW2,4)+1;
    convout2 = zeros(F2,convout2x,convout2y);
        
    %Cyklus pro jednotlivé filtry této konvoluční vrstvy:
    for f=....        
        temp = zeros(convout2x,convout2y);
        %Cyklus navíc pro jednotlivé vrstvy vstupu !!       
        for h=...
            ...
            ....
        end
        convout2(f,:,:) = temp;
        %Přičtení biasu:
        ....
    end    
    %Aplikace aktivační funkce ReLU pro všechny výstupní konvoluční filtry:
    ...
    
     %Kontrola: convout2(1,1,1) = 0
     %Kontrola: convout2(1,1,32) = 0.0055
     %Kontrola: convout2(1,23,17) = 2.8843
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %III. Výpočet max-pool vrstvy%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % VSTUP
    % ___________________________________________________
    % výstup z předchozí konvoluční vrstvy o hlubce H2
    %   rozměry: H2x32x32 = 8x32x32    
    
    % VÝSTUP
    % ___________________________________________________
    % 8 vrstev v matici maxpool
    %   rozměry: F2x16x16 = 8x16x16
    %       proč 16?
    %       max pool filtr vybírá maximum z okenka 2x2
    %       výstupní velikost je poloční oproti vstupní
    
    %Inicializace výstupu:
    maxpoolout = zeros(F2,convout2x/2,convout2y/2);
    
    %Cyklus pro jednotlivé filtry této vrstvy:
    for f=1:F2
        for i=1:convout2x/2
            for ii=1:convout2y/2
                maxpoolout(f,i,ii)=....;
            end
        end        
    end
    
    % Kontrola: maxpoolout(1,10,5) = 5.91
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %IV. Výpočet skryté vrstvy MLP  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % PARAMETRY
    % ___________________________________________________
    % W1...matice vah skryté vrstvy
    % b1...vektor biasů
    % rozměr: DxNH = 2048x32
    %   D = 2048...8*16*16 = počet hodnot na výstupu přechozí max-pool
    %   vrstvy
    %   NH = 32...zvolený počet neuronů skryté vrstvy MLP sítě                
    % VSTUP
    % ___________________________________________________
    % výstup z předchozí max-pool vrstvy
    %   rozměry: D = 8*16*16    
    
    % VÝSTUP
    % ___________________________________________________
    % 32 hodnot
    
    %Převedeme matici 8x16x16 po řádcích na vektor 1x2048, maxpoolout(:) nelze použít, převoded je takto prováděn po sloupcích !!
    %Po řádcích převádíme proto, protože stejně převáděl i trénovací software !!    
    tmp = permute(...);
    tmp = reshape(...);
    
    %Násobení vahami a přičtení biasu
    mlpout1 = ...
    
    %ReLU:
    ...
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %V. Výpočet výstupní vrstvy  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % PARAMETRY
    % ___________________________________________________
    % W2...matice vah výstupní vrstvy
    % b2...vektor biasů výstupní vrstvy
    % rozměr: NHxC = 32x10
    %   NH = 32...zvolený počet neuronů skryté vrstvy MLP sítě        
    %   C = 10...počet tříd
    % VSTUP
    % ___________________________________________________
    % výstup z předchozí skryté vrstvy
    %   rozměr: NH = 32    
    % VÝSTUP
    % ___________________________________________________
    %   rozměr: C = 10 ... počet tříd
    
    %Násobení vahami a přičtení biasu
    mlpout2 = ...;
    
    %Pro výběr maxima zde již není potřeba aplikovat ReLU!   
    %Pokud ji aplikujeme, doje k oříznutí všech hodnot < 0 na 0 a tím
    %pádem dostaneme pro některý obrázek špatný výsledek klasifikace
    
    %%%%%%%%%%%%%%%%%%
    %V. KLASIFIKACE  %
    %%%%%%%%%%%%%%%%%%
    [maxvalue, predict] = max(mlpout2);        
    if (predict == y_test(n))
        accuracy = accuracy+1;
    end            
    if mod(n,10) == 0
        fprintf('n: %i, přesnost : %f\n', n,100*accuracy/n);
    end
    
        
end   
fprintf('Přesnost : %f\n', 100*accuracy/N);
toc 