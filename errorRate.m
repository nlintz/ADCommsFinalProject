function res = errorRate(expectedSignal, receivedSignal)
    errors = 0;
    for i=1:min([length(expectedSignal), length(receivedSignal)])
        if (expectedSignal(i) ~= receivedSignal(i))
            errors = errors + 1;
        end
    end
    res = errors;
end