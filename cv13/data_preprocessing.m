function x_out = data_preprocessing(x_in,x_tren_in)
    % x_in...vstupní testovaci data data, rozměr: 1000x32x32 = Ntest x 32 x 32
    % x_tren_in...vstupní trenovací data, rozměr: 9000x32x32 = Ntren x 32 x 32
    % x_out...výstupní testovací data

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Provedení normalizace pomocí cyklu %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Nejprve střední hodnota jednotlivých pixelů trénovacích obrázků pomocí příkazu
    % mean:
    norm_factor = mean(x_tren_in,1);
    % Poté normalizace jednotlivých obrázků odečtením vypočtených 32 středních
    % hodnot:
    % Cyklus pro všechna testovací data:
    % ========================== VÁŠ KÓD ZDE ======================
    N = size(x_in,1);
    for i=1:N  
        x_out_tmp(i,:,:) = x_in(i,:,:) - norm_factor;
    end
    % Kontrola: x_out_tmp(10,10,10) = 4.83
    % =============================================================
        
    % Matici x_out_tmp o rozměrech Nx32x32 dále převedeme na matici o rozměrech
    % Nx1024, přičemž budeme postupovat po řádcích a pak po sloupcích:

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RESHAPE matice pomocí cyklu %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:N  
        %Nejprve řádek
        index = 1;
        % ========================== VÁŠ KÓD ZDE ======================
        for a=1:32
            %Poté sloupec
            for b=1:32
                x_out(i,index) = x_out_tmp(i,a,b);
                index = index + 1;
            end
        end
        % =============================================================
    end
    % Kontrola: x_out(666,666) = 0.3272
    % =============================================================    

    % Zbývá jen doplnit každý vektor testovacích dat o hodnotu 1, aby šlo násobení s vektorem vah
    % provádět jako skalární součin:
    x_out = [x_out ones(N,1)];
    % x_out má nyní rozměr N*1025

end