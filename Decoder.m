%functions to create voltToBinary, binaryToString, decodeBinary,
%rawToBinary

function decodedMessage = Decoder(user, message)
    decodedMessage = decodeCDMA(user, message);
end

function decodedMessage = decodeCDMA(user, message)
    protocol = Protocol();
    userCode = protocol(user);
    decodedMessage = zeros(1, length(message)/length(userCode));
    symbol = zeros(1, length(userCode));
    bitPlace = 1;
    pmbitPlace = 1;
    for i = 1: length(message)
        symbol(bitPlace) = message(i);
        bitPlace = bitPlace + 1;
        if bitPlace > length(userCode)
            bitPlace = 1;
            decodedMessage(pmbitPlace) = dot(symbol, userCode)/2;
            pmbitPlace = pmbitPlace + 1;
            symbol = zeros(1, length(userCode));
        end
    end
end