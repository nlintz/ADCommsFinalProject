%input user, and message (perhaps just binary for now)

%functions to create: stringToSbinary, encodeBinary,binaryToVolt

function encodedMessage = Encoder(user,message)
%user is string, message is string
    encodedMessage = encodeCDMA(user,message);

end

function encodedMessage = encodeCDMA(user,message)
%user is string, message is string ('hello'), expanded elements by n = 20 
    protocol = Protocol();
    lm = length(message)
    sbinaryMessage = messageToBinary(message);
    ls = length(sbinaryMessage)
    vbinaryMessage = stringToVoltBinary(sbinaryMessage);
    lv = length(vbinaryMessage)
    userCode = protocol(user);
    
    encodedMessage = zeros(1,length(vbinaryMessage)*length(userCode));
    bitPlace = 0;
    
    for i = 1: length(vbinaryMessage)
        for j = 1:length(userCode)
            bitPlace = bitPlace + 1;
            encodedMessage(bitPlace) = vbinaryMessage(i)*userCode(j);
        end
    end
    length(encodedMessage)
    encodedMessage = expandMessage(encodedMessage, 20);
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
    %pulse expanded by n.
    %message padded with zeros of length n.
    expandedMessage = [];
    for i = 1:length(message)
        pulse = zeros(1, n) + message(i);
        expandedMessage = cat(2, expandedMessage, pulse);
        %expandedMessage = cat(2, expandedMessage, zeros(1,n));
    end
end
