function res = threshold(data)
datath = zeros(1,length(data));
for i=1:length(data)
    if data(i) < 0
        datath(i) = -2;
    end
    if data(i) == 0
        datath(i) = 0;
    end
    if data(i) > 0
        datath(i) = 2;
    end
    
end
res = datath;
end