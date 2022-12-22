function x_out = data_preprocessing_fast(x_in,x_tren_in)
    % x_in...vstupní testovaci data data, rozměr: 1000x32x32 = Ntest x 32 x 32
    % x_tren_in...vstupní trenovací data, rozměr: 9000x32x32 = Ntren x 32 x 32
    % x_out...výstupní testovací data

     % ========================== VÁŠ KÓD ZDE ======================
    % Nejprve střední hodnota jednotlivých pixelů trénovacích obrázků pomocí příkazu mean:
    norm_factor = mean(x_tren_in,1);    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Provedení normalizace bez cyklu %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Normalizaci x_in odečtením vypočtených 32 středních hodnot lze zapsat i bez použití cyklu for jako maticovou operaci pomocí příkazu
    % REPMAT s parametrem N:
    N = size(x_in,1);
    % ========================== VÁŠ KÓD ZDE ======================
    x_out = x_in - norm_factor;
    % Kontrola: x_out(10,10,10) = 4.83
    % =============================================================    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RESHAPE matice efektivně %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Matici x_out o rozměrech Nx32x32 dále převedeme na matici o rozměrech Nx1024 příkazem RESHAPE.
    % Ten v Matlabu ovšem funguje po sloupcích, kdežto v trénovacím software obdoba příkazu reshape
    % zpracovávala během trénování matice po řádcích, jako cykly for v předchozí implementaci => před použitím příkazu RESHAPE je třeba prohodit
    % sloupce a řádky obrázků příkazem PERMUTE:
    % ========================== VÁŠ KÓD ZDE ======================
    x_out = permute(x_out, [1 3 2]);
    % Nyní je možné použít RESHAPE a výsledek bude stejný, jako v trénovacím
    % software (numpy+python) a jako byl při použití vnořených cyklů:    
    x_out = reshape(x_out, [N,1024]);
    % Kontrola: x_out(666,666) = 0.3272
    % =============================================================  
    % Pokud bychom PERMUTE neprovedli, naučené váhy by se aplikovaly na
    % přehozené vstupní hodnoty a přesnost rozpoznávání by byla 12.4%, tedy přibližně 1/C = 1/10!!!
    
    % Zbývá jen doplnit každý vektor testovacích dat o hodnotu 1, aby šlo násobení s vektorem vah    
    % provádět jako skalární součin:
    x_out = [x_out ones(N, 1)];
    % pause;
    % x_out má nyní rozměr N*1025 !!!!    
   
end