function Z = Receiver_Main(packetLength)
    receiver = Receiver;
    receiver.receiveData(packetLength);
    Z = receiver.Z;
end