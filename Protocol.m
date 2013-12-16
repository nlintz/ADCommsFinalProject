%input user, output code

function res = Protocol()
%generate protocol object
    protocol = getProtocol();
    res = protocol;
end

function protocol = getProtocol()
%generate protocol map simple

    protocol = containers.Map;
    protocol('user1') = [1,-1,1,-1];
    protocol('user2') = [1,1,1,1];
    protocol('user3') = [1,1,-1,-1];
    protocol('user4') = [1,-1,-1,1];
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