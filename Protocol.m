%input user, output code

function res = Protocol()
%generate protocol object
    protocol = getProtocol();
    res = protocol;
end

function protocol = getProtocol()
%generate protocol map simple
    code = [1, -1,1];

    protocol = containers.Map;
    protocol('user1') = code;
    protocol('user2') = -1.*code;
end

% function protocol = getProtocol2()
% %generate protocol map pseudorandom code
%     lengthCode = 100
%     %numberUsers = 10
% 
%     protocol = containers.Map;
%     
%     protocol('user1') = randi([0 1],1,lengthCode);
%     protocol('user2') = randi([0 1],1,lengthCode);
% end
% 
% %Two ways of doing coding.
% %1st way. pseudolength = translength.
% %2nd way. numdatabits * pseudolength = translength.
% %3rd way. 
% function isOrthogonal = checkOrtho(x,y)
%     isOrthogonal = dot(x,y)== 0;
% end