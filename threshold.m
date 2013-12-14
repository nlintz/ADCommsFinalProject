function res = threshold(data)
%data = 2*rand(50,1)-1;
datath = zeros(1,length(data));
for i=1:length(data)
    if data(i) < 0
        datath(i) = -1;
    else
        datath(i) = 1;
    end
end
res = datath;
end