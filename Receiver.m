classdef Receiver<handle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        I = []
        Q = []
        Z = []
        data;
    end
    
    methods
        function obj=receieveData(obj, packetLength)
            addpath USRP_Tools\;
            [I Q] = USRP_RxPacket(packetLength, 50, 10, 100);
            obj.I = I;
            obj.Q = Q;
            obj.Z = I + 1i.*Q;
        end
        
%         function obj=filterPeak(obj, fd)
%             filtered_z = transpose(obj.Z).*exp(-1i*fd*linspace(1,length(obj.Z),length(obj.Z)));
%             subplot(2, 1, 1)
%             plot(real(filtered_z))
%             subplot(2, 1, 2)
%             plot(real(obj.Z))
%             obj.Z = transpose(filtered_z);
%             obj.I = real(obj.Z);
%             obj.Z = imag(obj.Z);
%         end        
        function plotFFT(obj, signal)
            clf
            plot(linspace(-pi,pi,length(signal)),abs(fftshift(fft(signal))))
        end
        
    end
    
    methods(Static)
        function peak = findPeak(signal)
            fft_result = abs(fftshift(fft(signal)));
            [M I] = max(fft_result);
            
            peak = abs(2*pi*(I/8000 - 1/2));
        end
    end
    methods(Static)
        function filteredZ = filterPeak(unfilteredZ, fd)
            filtered_z = transpose(unfilteredZ).*exp(-1i*fd*linspace(1,length(unfilteredZ),length(unfilteredZ)));
            subplot(2, 1, 1)
            plot(real(filtered_z))
            subplot(2, 1, 2)
            plot(real(obj.Z))
            filteredZ = transpose(filtered_z);
        end
    end
    
end

