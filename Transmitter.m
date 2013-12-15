function res = Transmitter(user1, message1, user2, message2, user3, message3)
    addpath USRP_Tools\
    
    encodedMessage1 = transpose(CDMA(user1, message1, user2, message2));
    encodedMessage2 = transpose(Encoder(user3, message3));
    
    I = encodedMessage1;
    Q = encodedMessage2;
    
    ones(2000,1);
    TransmitI = vertcat(ones(2000,1),I);
    TransmitQ = vertcat(ones(2000,1),Q);
    
    length(TransmitI)
    while 1
        %USRP_SendSamples(I, Q, n)
        USRP_SendSamples(TransmitI, TransmitQ, length(TransmitI))
        
    end
end