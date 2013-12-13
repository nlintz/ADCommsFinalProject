%input user, and message (perhaps just binary for now)

%functions to create: stringToSbinary, encodeBinary,binaryToVolt

function encodedMessage = Encoder(user,message)
%user is string, message is string
    encodedMessage = encodeCDMA(user,message);

end

function encodedMessage = encodeCDMA(user,message)
%user is string, message is string, expanded elements by n = 3
    protocol = Protocol();
    sbinaryMessage = messageToBinary(message);
    vbinaryMessage = stringToVoltBinary(sbinaryMessage);
    expandedVMessage = expandMessage(vbinaryMessage, 3);
    userCode = protocol(user);
    
    encodedMessage = zeros(1,length(expandedVMessage)*length(userCode));
    bitPlace = 0;
    
    for i = 1: length(expandedVMessage)
        for j = 1:length(userCode)
            bitPlace = bitPlace + 1;
            encodedMessage(bitPlace) = expandedVMessage(i)*userCode(j);
        end
    end
end

function sbinary = messageToBinary(message)
    sbinary = '';
    for i = 1:length(message)
        strLetter = message(i);
        decLetter = double(strLetter);
        sbinary = strcat(sbinary, dec2bin(decLetter,7));
    end
end

function vbinaryMessage = stringToVoltBinary(sbinaryMessage)
    vbinaryMessage = zeros(1, length(sbinaryMessage));
    
    for i = 1:length(sbinaryMessage)
        if str2double(sbinaryMessage(i)) == 0
            vbinaryMessage(i) = -1;
        else
            vbinaryMessage(i) = 1;
        end
    end
end

function expandedMessage = expandMessage(message, n)
    %n is number by which each element is expanded by
    expandedMessage = [];
    for i = 1:length(message)
        expandedElement = zeros(1, n) + message(i);
        expandedMessage = cat(1, expandedMessage, expandedElement);
        expandedMessage = cat(1, expandedMessage, zeros(1,n));
    end
end
