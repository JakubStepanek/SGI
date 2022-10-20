clear all; close all; clc;

for i = 0:6
    figure(i+1); %TODO: , "Name",sprintf("Něco %d", i)
    showGraph("cv04_0"+i+".wav");
end

function showGraph(filename)
    [x,Fs] = audioread(filename);
    subplot(3,1,1);
    %%Plot graph
    plot(x);

    %%Signal energy
    n = 100; %window size 
    element_count = round(length(x)/n);
    for i = 1:1:element_count-1
        vec = x(n*i+1-n:n*i); %1..100, 101..200,201..300,301..400
        E(i) = energy_sum(vec);
    end
    subplot(3,1,2);
    plot(E);

    %%Difference
    subplot(3,1,3);
    plot(backward_difference(E));

    function [diff] = backward_difference(vec)
        diff = zeros(length(vec),1);
        for i = 2:length(vec)
            diff(i) = vec(i)-vec(i-1);
        end
    end

    function [E] = energy_sum(vec)
        E = 0;
        E = sum(abs(vec).^2);
    end
end