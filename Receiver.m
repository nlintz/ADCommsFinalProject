function res = Receiver(packetLength)
    addpath USRP_Tools\
    [I Q] = USRP_RxPacket(packetLength, 50, 10, 50);
    res = [I Q];
end