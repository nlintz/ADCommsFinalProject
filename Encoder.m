%input user, and message (perhaps just binary for now)

%functions to create: stringToSbinary, encodeBinary,binaryToVolt

function encodedMessage = Encoder(user,message)
%user is string, message is string
    encodedMessage = encodeCDMA(user,message);

end

function encodedMessage = encodeCDMA(user,message)
%user is string, message is string
    protocol = Protocol();
    sbinaryMessage = messageToBinary(message);
    sbinaryMessage = stringToVoltBinary(sbinaryMessage);
    userCode = protocol(user);
    
    vbinaryMessage = zeros(1,length(sbinaryMessage)*length(userCode));
    bitPlace = 0;
    
    for i = 1: length(sbinaryMessage)
        for j = 1:length(userCode)
            bitPlace = bitPlace + 1;
            vbinaryMessage(bitPlace) = sbinaryMessage(i)*userCode(j);
        end
    end
    encodedMessage = vbinaryMessage;
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
