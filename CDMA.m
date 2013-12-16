function encodedCDMA = CDMA(user1, message1, user2, message2)
    difference = length(message1)- length(message2);
    space = '';
    for i = 1: abs(difference)
        space = [space,' '];
    end
    
    if difference >= 0
        message2 = [message2,space];
    else
        message1 = [message1,space];
    end
    
    encodedMessage1 = Encoder (user1, message1);
    encodedMessage2 = Encoder (user2, message2);
    
%     decodedMessage1 = Decoder(user1, encodedMessage1);
%     decodedMessage2 = Decoder(user2, encodedMessage2);
 
    encodedCDMA = encodedMessage1 + encodedMessage2;
end