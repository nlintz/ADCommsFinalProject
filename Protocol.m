function res = Protocol()
    protocol = getProtocol();
    res = protocol;
end

function protocol = getProtocol()
    code = [1, -1];

    protocol = containers.Map;
    protocol('user1') = code;
    protocol('user2') = -1.*code;
end