function res = padzeros(signal)
    res = zeros(length(signal)*2,1);
    for i=1:length(signal)*2
        if mod(i,2) == 1
            res(i) = signal(ceil(i/2));
        end
    end
end