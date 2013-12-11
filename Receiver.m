function res = Receiver(packetLength)
    addpath USRP_Tools\;
    [I Q] = USRP_RxPacket(packetLength, 50, 10, 50);
    res = [I Q];
end

% function res = plotFFT(signal, Fs)
% Fs = 1000;                    % Sampling frequency
% T = 1/Fs;                     % Sample time
% L = 1000;                     % Length of signal
% t = (0:L-1)*T;                % Time vector
% % Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
% x = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t); 
% plot(Fs*t(1:50),y(1:50))
% title('Signal Corrupted with Zero-Mean Random Noise')
% xlabel('time (milliseconds)')
% 
% end