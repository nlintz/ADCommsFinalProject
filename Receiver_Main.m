function [raw_Z, processed_Z] = Receiver_Main(packetLength)
    clear Classes
    receiver = Receiver;
    receiver.receiveData(packetLength);
    raw_Z = receiver.Z;
    processed_Z = Receiver.processSignal(receiver.Z);
end