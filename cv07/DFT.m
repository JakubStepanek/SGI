function [X] = DFT(x, N)
m = size(x);
X = zeros(N,1);
    for k = 0:N-1
    sum = 0;
        for n = 0 :N-1
            sum = sum + x(n+1)*exp(-1i*2*pi*n*k*1/N);
        end
        X(k+1) = 1/N*sum;
    end
end


