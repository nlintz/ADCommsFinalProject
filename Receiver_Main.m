function [raw_Z, processed_Z] = Receiver_Main(packetLength, trainingPacketLength)
    clear Classes
    receiver = Receiver;
    receiver.receiveData(packetLength);
    raw_Z = receiver.Z;
    processed_Z = Receiver.processSignal(receiver.Z, trainingPacketLength);
end