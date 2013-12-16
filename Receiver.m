classdef Receiver < handle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    properties (SetAccess = private)
        I = []
        Q = []
        Z = []
        data = [];
        peakFrequency;
    end
    
    methods
        
        function obj=receiveData(obj, packetLength)
            addpath USRP_Tools\;
            [I Q] = USRP_RxPacket(packetLength, 100, 25, 50);
            obj.I = I;
            obj.Q = Q;
            obj.Z = I + 1i.*Q;
        end
        
        function showFFT(obj)
            clf
            plot(linspace(-pi,pi,length(obj.I)),abs(fftshift(fft(obj.I))));
        end
        
    end
    
    methods(Static)
        function peak = findPeak(signal)
            peak = findPeak(signal);
        end
    end
    methods(Static)
        function filteredZ = filterPeak(unfilteredZ, fd)
            filtered_z = transpose(unfilteredZ).*exp(-1i*fd*linspace(1,length(unfilteredZ),length(unfilteredZ)));
%             subplot(3, 1, 1)
%             plot(real(filtered_z))
%             xlabel('I channel')
%             subplot(3, 1, 2)
%             plot(imag(filtered_z))
%             xlabel('Q channel')
%             subplot(3, 1, 3)
%             plot(real(filtered_z), imag(filtered_z));
            filteredZ = transpose(filtered_z);
        end
    end
    
    methods(Static)
        function filteredZ = filterSignal(unfilteredZ, trainingPacketLength)
            z = unfilteredZ;
            for i=1:1
                z = filterPeak(z, findPeak(z(1:trainingPacketLength)));
            end
            filteredZ = z;
        end
    end
    
    methods(Static)
        function plotFFT(signal)
            plot(linspace(-pi,pi,length(signal)),abs(fftshift(fft(signal))));
        end
    end
    
    methods(Static)
        function signalFFT = getFFT(signal)
            signalFFT = abs(fftshift(fft(signal)));
        end
    end
    
    methods(Static)
        function shiftedZ = correctPhaseShift(signal, trainingPacketLength)
            avg = mean(real(signal(1:trainingPacketLength))) + 1i.*mean(imag(signal(1:trainingPacketLength)));
            phase_shift_angle = angle(avg) - pi/4;
            shiftedZ = signal .* exp(-i*phase_shift_angle);
        end
    end
    
    methods(Static)
        function processedSignal = removeNoise(signal)
            noiselessSignal = removeNoise(signal);
            processedSignal = signal(findFirstPoint(noiselessSignal): findLastPoint(noiselessSignal));
        end
    end
    
    methods(Static)
        function processedSignal = processSignal(signal, trainingPacketLength)
            noiselessSignal = removeNoise(signal);
            resampledSignal = signal(findFirstPoint(noiselessSignal): findLastPoint(noiselessSignal));
            trainingHeader = resampledSignal(1:trainingPacketLength);
            frequencyOffset = findPeak(resampledSignal);
            filteredSignal = filterPeak(resampledSignal, frequencyOffset);
            phaseCorrectedSignal = correctPhaseShift(filteredSignal, trainingPacketLength);
            processedSignal = phaseCorrectedSignal;
        end
    end
end
function peak = findPeak(signal)
    x = linspace(-pi, pi, length(signal));
    fft_result = abs(fftshift(fft(signal.^4)));
    [M index] = max(fft_result);
    peak = x(index)/4;
end
function filteredZ = filterPeak(unfilteredZ, fd)
    filtered_z = transpose(unfilteredZ).*exp(-1i*fd*linspace(1,length(unfilteredZ),length(unfilteredZ)));
    filteredZ = transpose(filtered_z);
end
function res = findFirstPoint(signal)
    for i=1:length(signal)
        if (signal(i) ~= 0)
            res = i;
            break
        end
    end
end
function res = findLastPoint(signal)
    for i=1:length(signal)
        if (signal(i) ~= 0)
            res = i;
        end
    end
end
function filteredZ = filterSignal(unfilteredZ, trainingPacketLength)
    z = unfilteredZ;
    for i=1:1
        z = filterPeak(z, findPeak(z(1:trainingPacketLength)));
    end
    filteredZ = z;
end
function res = removeNoise(signal)
    maxAmplitude = max(abs(signal));
    for i=1:length(signal)
        if abs(signal(i)) < .5*maxAmplitude
            signal(i) = 0;
        end
    end
    res = signal;
end
function shiftedZ = correctPhaseShift(signal, trainingPacketLength)
    avg = mean(real(signal(1:trainingPacketLength))) + 1i.*mean(imag(signal(1:trainingPacketLength)));
    phase_shift_angle = angle(avg) - pi/4;
    shiftedZ = signal .* exp(-i*phase_shift_angle);
end

