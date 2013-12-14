function res = Transmitter()
    addpath USRP_Tools\
    n = 2000;
    I = ones(n,1).*10;
    Q = ones(n,1).*10;
    
    TransmitI = vertcat(I,I, -1.*I, -1.*I);
    TransmitQ = vertcat(Q,-1.*Q,Q, -1.*Q);

    while 1
        %USRP_SendSamples(I, Q, n)
        USRP_SendSamples(TransmitI, TransmitQ, n*4)
    end
end