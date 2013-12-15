%functions to create voltToBinary, binaryToString, decodeBinary,
%rawToBinary

function decodedMessage = Decoder(user, encodedMessage)
    decodedMessage = decodeCDMA(user, encodedMessage);
end

function decodedMessage = decodeCDMA(user, encodedMessage)
%user is string, data is array of [-1,-1,-1, 1,1,1]. data length mult of n.
%n even
    protocol = Protocol();
    userCode = protocol(user);
    vbinaryMessage = contractMessage(encodedMessage,20);
    
    originalMessage = zeros(1, length(vbinaryMessage)/length(userCode));
    
    for i = 1:length(vbinaryMessage)/length(userCode)
        symbolBin = vbinaryMessage(1:length(userCode));
        vbinaryMessage = vbinaryMessage((1+length(userCode)):end);
        originalMessage(i) = dot(symbolBin, userCode)/length(userCode);
    end
    sbinaryMessage = voltToStringBinary(originalMessage);
    decodedMessage = binaryToMessage(sbinaryMessage);
end

function message = binaryToMessage(sbinary)
    message = blanks(length(sbinary)/7);
    for i = 1:(length(sbinary)/7);
        decLetter = bin2dec(sbinary(1:7));
        strLetter = char(decLetter);
        message(i) = strLetter;
        if length(sbinary)~= 7
            sbinary = sbinary(8:end);
        end
    end
end

function binary = rawToVoltBinary(raw)
    average = mean(raw);
    binary = raw;
    for i = 1:length(raw)
        if raw(i)<= average
            binary(i) = -1;
        else
            binary(i) = 1;
        end
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
%         (length(message)/n)
%         n
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