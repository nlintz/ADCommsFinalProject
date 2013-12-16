function [real_message imag_message] = fftImprove(signal, trainingPacketLength, dataLength)
    processed_Z = Receiver.processSignal(signal, trainingPacketLength);
    
    raw_message = processed_Z(trainingPacketLength:length(processed_Z));
    real_message = threshold(real(raw_message));
    imag_message = threshold(imag(raw_message));
    
    real_message = real_message(1:dataLength);
    imag_message = imag_message(1:dataLength);
        
    Decoder('user1', real_message)
%     Decoder('user2', raw_message_encoded_real)
    Decoder('user1', imag_message)
%     Decoder('user2', raw_message_encoded_imag)

end