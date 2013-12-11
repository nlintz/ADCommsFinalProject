function res = Transmitter()
    addpath USRP_Tools\
    n = 5000;
    I = ones(n,1)*10;
    Q = zeros(n,1)*10;
    
    TransmitI = vertcat(I, -1.*I);
    TransmitQ = vertcat(Q, -1.*Q);
    while 1
        USRP_SendSamples(I, Q, 5000)
    end
end