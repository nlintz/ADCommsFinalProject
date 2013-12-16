function [real_message, imag_message] = ReceiveAndDecodeMain(user, packetLength, trainingPacketLength)
    [raw_Z, processed_Z] = Receiver_Main(packetLength, trainingPacketLength);
    header = processed_Z(1:trainingPacketLength);
    raw_message = processed_Z(trainingPacketLength:length(processed_Z));
    raw_message_encoded_real = threshold(real(raw_message));
    raw_message_encoded_imag = threshold(imag(raw_message));
    
    real_message = Decoder(user, raw_message_encoded_real);
    imag_message = Decoder(user, raw_message_encoded_imag);

end