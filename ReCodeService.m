function [I_message, Q_message] = ReCodeService(signal, trainingPacketLength, dataLength)
    processed_Z = Receiver.processSignal(signal, trainingPacketLength);
    
    raw_message = processed_Z(trainingPacketLength:length(processed_Z));
    real_message = threshold(real(raw_message));
    imag_message = threshold(imag(raw_message));
    I_message = real_message(1:dataLength);
    Q_message = imag_message(1:dataLength);
        
    Decoder('user1', I_message)
    Decoder('user2', Q_message)

end