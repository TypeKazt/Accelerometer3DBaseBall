function [ distance ] = ball2batDistance( ballPosition, batPosition, ballRadius, batRadius,velocity )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



distance = sqrt((ballPosition(1,1) - batPosition(1,1) + velocity(1,1))^2 ...
    + (ballPosition(1,2) - batPosition(1,2) + velocity(1,2))^2 ...
    + (ballPosition(1,3) - batPosition(1,3) - velocity(1,3))^2)...
    - (ballRadius + batRadius);

end

