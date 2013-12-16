function errorRate = ErrorRateCalculator(user1, message1, user2, message2, encodedCDMA)
    %get expected encodedBits
    encodedBits = [messageToBinary(message1),messageToBinary(message2)];
    
    
    %get expected decodedBits
    protocol = Protocol();
    userCode1 = protocol(user1);
    userCode2 = protocol(user2);
    
    vbinaryMessage = contractMessage(encodedCDMA,20);
    
    
    originalMessage = zeros(1, length(vbinaryMessage)/length(userCode1));
    for i = 1:length(vbinaryMessage)/length(userCode1)
        symbolBin = vbinaryMessage(1:length(userCode1));
        vbinaryMessage = vbinaryMessage((1+length(userCode1)):end);
        originalMessage(i) = dot(symbolBin, userCode1)/length(userCode1);
    end
    decodedBits = voltToStringBinary(originalMessage);
    length(decodedBits)
    
    originalMessage = zeros(1, length(vbinaryMessage)/length(userCode2));
    for i = 1:length(vbinaryMessage)/length(userCode2)
        symbolBin = vbinaryMessage(1:length(userCode2));
        vbinaryMessage = vbinaryMessage((1+length(userCode2)):end);
        originalMessage(i) = dot(symbolBin, userCode2)/length(userCode2);
    end
    decodedBits = [decodedBits,voltToStringBinary(originalMessage)];
    
    
    %error calculation
    errorCount = 0.0;
    
    for i = 1: length(encodedBits) 
        if encodedBits(i) ~= decodedBits(i)
            errorCount = errorCount +1;
        end
    end
    errorRate = errorCount/length(encodedBits);
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
            [bincounts, ind] = histc([average], [-1,0,1]);
            if bincounts(1) == 1
                contractedMessage = cat(2, contractedMessage, -1);
            elseif bincounts(3) == 1
                contractedMessage = cat(2, contractedMessage, 1);
            end  
            if length(message)~= n
                message = message((n+1):end);
            end
        end
end