function encodedMessage = Encoder(message)

    encodedMessage = encodeCDMA(message);

end

function encodedMessage = encodeCDMA(string)
    protocol = Protocol;
    encodedMessage = dec2bin(string)
end