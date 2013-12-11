%input user, and message (perhaps just binary for now)

%functions: stringToBinary, encodeBinary,binaryToVolt

function encodedMessage = Encoder(user,message)
%user is string, message is double
    
    encodedMessage = encodeCDMA(user,message);

end

function encodedMessage = encodeCDMA(user,string)
    protocol = Protocol();
    binaryMessage = dec2bin(string);
    binaryMessage = binaryToVolt(binaryMessage);
    userCode = protocol(user);
    encodedMessage = zeros(1,length(binaryMessage)*length(userCode));
    bitPlace = 0;
    for i = 1: length(binaryMessage)
        for j = 1:length(userCode)
            bitPlace = bitPlace + 1;
            encodedMessage(bitPlace) = binaryMessage(i)*userCode(j)
        end
    end
end

function binaryMessage = binaryToVolt(trueBinary)
    binaryMessage = zeros(1, length(trueBinary))
    for i = 1:length(trueBinary)
        if str2double(trueBinary(i)) == 0
            binaryMessage(i) = -1
        else
            binaryMessage(i) = 1
        end
    end
end
