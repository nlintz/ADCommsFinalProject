function res = Transmitter(user1, message1, user2, message2)
    addpath USRP_Tools\
    
    encodedMessage1 = transpose(CDMA(user1, message1, user2, message2));
    %encodedMessage2 = transpose(Encoder(user3, message3));
    encodedMessage2 = encodedMessage1;
    
    I = encodedMessage1;
    Q = encodedMessage2;
    
    npacket = 1000;
    
    training = ones(npacket,1);
    
    TransmitI = vertcat(training, I, training);
    TransmitQ = vertcat(training, Q, training);
    
    length(TransmitI)
    
    while 1
        %USRP_SendSamples(I, Q, n)
        USRP_SendSamples(TransmitI.*10, TransmitQ.*10, length(TransmitI))
    end
end