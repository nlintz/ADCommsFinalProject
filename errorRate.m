function res = errorRate(expectedSignal, receivedSignal)
    res = (sum(expectedSignal) - sum(threshold(receivedSignal))) / length(receivedSignal);

end