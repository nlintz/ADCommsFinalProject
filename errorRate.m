function [real_errors, imag_errors] = errorRate(message1, message2, signal, trainingPacketLength)
    cdma = CDMA('user1', message1, 'user2', message2);
    
    codeSize = length(Protocol());
    letterSize = 7; %Each letter is represented by 7 ascii bits
    duplicateAmount = 40; %Each bit is repeated 40 times
    char2BitFactor = codeSize * letterSize * duplicateAmount;
    dataLength = max(length(message1)*char2BitFactor, length(message2)*char2BitFactor);
    bitLength = dataLength / 40; %Each bit is the average of a 40 bit window
    
    [real_message, imag_message] = ReCodeService(signal, trainingPacketLength, dataLength);
    [average_real_msg, average_imag_msg, average_cdma_msg] = signalToAveragePowerWindows(real_message, imag_message, cdma, duplicateAmount, bitLength);
    hold on
    stem(thresholdWindow(average_real_msg), 'r')
    [real_errors imag_errors] = computeErrors(average_real_msg, average_imag_msg, average_cdma_msg)
end

function [real_errors, imag_errors] = computeErrors(average_real_msg, average_imag_msg, average_cdma_msg)
    real_errors = sum(abs(average_real_msg - average_cdma_msg))/length(average_real_msg);
    imag_errors = sum(abs(average_imag_msg - average_cdma_msg))/length(average_imag_msg);
end

function [average_real_msg, average_imag_msg, average_cdma_msg] = signalToAveragePowerWindows(real_message, imag_message, cdma, duplicationFactor, bitWindow)
    average_real_msg = zeros(bitWindow,1);
    average_imag_msg = zeros(bitWindow,1);
    average_cdma_msg = zeros(bitWindow,1);
    
    for i=1:bitWindow
        average_real_msg(i) = thresholdWindow(mean(real_message((i-1)*duplicationFactor+1:i*duplicationFactor)));
        average_imag_msg(i) = thresholdWindow(mean(imag_message((i-1)*duplicationFactor+1:i*duplicationFactor)));
        average_cdma_msg(i) = thresholdWindow(mean(cdma((i-1)*duplicationFactor+1:i*duplicationFactor)));
    end
    
end

function res = thresholdWindow(window)
    for i=1:length(window)
        if abs(window(i)) < 1
            window(i) = 0;
        else
            window(i) = sign(window(i))*2;
        end
    end
    res = window;
end