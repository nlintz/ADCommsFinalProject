function res = Transmitter(user, message)
    addpath USRP_Tools\
    
    encodedMessage = Encoder(user, message);
    
    n = length(encodedMessage);
%     I = [];
%     Q = [];
%     for i = 1: n
%         if rem(i,2) == 1
%             I = cat(I,encodedMessage(i));
%         else
%             Q = cat(Q,encodedMessage(i));
%         end
%     end
    
    %TransmitI = vertcat(I,I, -1.*I, -1.*I);
    %TransmitQ = vertcat(Q,-1.*Q,Q, -1.*Q);
    
    TransmitI = vertcat(ones(2000,1),I);
    size(TransmitI)
    TransmitQ = vertcat(ones(2000,1),Q);

    while 1
        %USRP_SendSamples(I, Q, n)
        USRP_SendSamples(TransmitI, TransmitQ, n*4)
    end
end