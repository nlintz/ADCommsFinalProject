classdef Receiver<handle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        I = []
        Q = []
    end
    
    methods
        function obj=receieveData(obj, packetLength)
            addpath USRP_Tools\;
            [I Q] = USRP_RxPacket(packetLength, 50, 10, 100);
            obj.I = I;
            obj.Q = Q;
        end
    end
    
end

