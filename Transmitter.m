function res = Transmitter(user, message)
    addpath USRP_Tools\
    
    encodedMessage = transpose(Encoder(user, message));
    
    %TransmitI = vertcat(I,I, -1.*I, -1.*I);
    %TransmitQ = vertcat(Q,-1.*Q,Q, -1.*Q);
    
    I = encodedMessage;
    Q = encodedMessage;
%     encodedMessage
%     ones(2000,1)
%     TransmitI = vertcat(ones(2000,1),I)
    I = ones(2000,1)
    TransmitI = vertcat(I, -1.*I,I, -1.*I);
    TransmitQ = TransmitI;
    size(encodedMessage)
%     TransmitQ = vertcat(ones(2000,1),Q);

    while 1
        %USRP_SendSamples(I, Q, n)
        USRP_SendSamples(TransmitI, TransmitQ, length(TransmitI))
    end
end