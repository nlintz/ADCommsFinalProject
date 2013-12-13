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
        
        function obj=receieveData(obj, packetLength)
            addpath USRP_Tools\;
            [I Q] = USRP_RxPacket(packetLength, 50, 15, 100);
            obj.I = I;
            obj.Q = Q;
            obj.Z = I + 1i.*Q;
        end
        
        function showFFT(obj)
            clf
            plot(linspace(-pi,pi,length(obj.I)),abs(fftshift(fft(obj.I))))
        end
        
    end
    
    methods(Static)
        function peak = findPeak(signal)
            x = linspace(-pi, pi, length(signal));
            fft_result = abs(fftshift(fft(signal)));
            [M index] = max(fft_result);
            peak = x(index);
        end
    end
    methods(Static)
        function filteredZ = filterPeak(unfilteredZ, fd)
            filtered_z = transpose(unfilteredZ).*exp(-1i*fd*linspace(1,length(unfilteredZ),length(unfilteredZ)));
            subplot(3, 1, 1)
            plot(real(filtered_z))
            xlabel('I channel')
            subplot(3, 1, 2)
            plot(imag(filtered_z))
            xlabel('Q channel')
            subplot(3, 1, 3)
            plot(real(filtered_z), imag(filtered_z));
            filteredZ = transpose(filtered_z);
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
   
    
end