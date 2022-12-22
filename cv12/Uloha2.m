clc; clear all; close all;

load ('digits_tren.mat'); load ('digits_test.mat');
N = 1000; M = 9000; pocet_pokusu = 0; pocet_spravnych = 0;
for i = 1:N
    x = test_data (i,:,:);
    x_trida = test_trida(i); 
    for j = 1:M
        v = tren_data (j,:,:);
        v_trida = tren_trida(j);
        tridy_vzoru(j) = v_trida;
        dist(j)=sum(sum(abs(x-v)));
    end
    [min_dist, index] = min(dist); 
     nejblizsi_trida = tridy_vzoru(index); 
    if x_trida == nejblizsi_trida 
        pocet_spravnych = pocet_spravnych + 1;
    end
    pocet_pokusu = pocet_pokusu + 1; 
    if mod(i,10) == 0
        uspesnost = pocet_spravnych/pocet_pokusu * 100; 
        disp(['Průchod: ', num2str(i), ' Úspěšnost: ', num2str(uspesnost), '%']);
    end
end
 uspesnost = pocet_spravnych/pocet_pokusu * 100; 
        disp(['Úspěšnost: ', num2str(uspesnost), '%']);

        %Udělá 1000*9000*1024*3 výpočtů
