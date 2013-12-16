function errorRate = ErrorRateCalculator(user1, message1, user2, message2, encodedCDMA)
    %get expected encodedBits
    encodedBits = [messageToBinary(message1),messageToBinary(message2)];
    length(encodedBits)

    %get expected decodedBits
    protocol = Protocol();
    userCode1 = protocol(user1);
    userCode2 = protocol(user2);
    
    vbinaryMessage1 = contractMessage(encodedCDMA,40);
    vbinaryMessage2 = contractMessage(encodedCDMA,40);
    
    originalMessage = zeros(1, length(vbinaryMessage1)/length(userCode1));
    for i = 1:length(vbinaryMessage1)/length(userCode1)
        symbolBin = vbinaryMessage1(1:length(userCode1));
        vbinaryMessage1 = vbinaryMessage1((1+length(userCode1)):end);
        originalMessage(i) = dot(symbolBin, userCode1)/length(userCode1);
    end
    decodedBits1 = voltToStringBinary(originalMessage);
    length(decodedBits1)
    
    originalMessage = zeros(1, length(vbinaryMessage2)/length(userCode2));
    for i = 1:length(vbinaryMessage2)/length(userCode2)
        symbolBin = vbinaryMessage2(1:length(userCode2));
        vbinaryMessage2 = vbinaryMessage2((1+length(userCode2)):end);
        originalMessage(i) = dot(symbolBin, userCode2)/length(userCode2);
    end
    decodedBits2 = voltToStringBinary(originalMessage);
    length(decodedBits2)
    
    decodedBits = [decodedBits1,decodedBits2];
    length(decodedBits)
    
    %error calculation
    errorCount = 0.0;
    
    for i = 1: length(encodedBits) 
        if encodedBits(i) ~= decodedBits(i)
            errorCount = errorCount +1;
        end
    end
    errorRate = errorCount/double(length(encodedBits));
end

function sbinary = messageToBinary(message)
    sbinary = '';
    for i = 1:length(message)
        strLetter = message(i);
        decLetter = double(strLetter);
        sbinary = strcat(sbinary, dec2bin(decLetter,7));
    end
end

function sbinaryMessage = voltToStringBinary(vbinaryMessage)
    sbinaryMessage = blanks(length(vbinaryMessage));
    for i = 1:length(vbinaryMessage)
        if vbinaryMessage(i) == -1
            sbinaryMessage(i) = '0';
        else
            sbinaryMessage(i) = '1';
        end
    end
end

function contractedMessage = contractMessage(message, n)
    %contract message by taking every block of n, finding average, and
    %based on whether or not average is < or > 0
    contractedMessage = [];
        for i = 1:(length(message)/n)
            pulse = message(1:n);
            average = mean(pulse);
            if average >= 1
                contractedMessage = cat(2, contractedMessage, 2);
            elseif average <= -1
                contractedMessage = cat(2, contractedMessage, -2);
            else
                contractedMessage = cat(2, contractedMessage, 0);
            end
            if length(message)~= n
                message = message((n+1):end);
            end
        end
end