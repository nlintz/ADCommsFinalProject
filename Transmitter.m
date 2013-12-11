function res = Transmitter()
    addpath USRP_Tools\
    n = 5000;
    I = ones(n,1);
    Q = ones(n,1);
    USRP_SendSamples(I, Q, n)
    
end