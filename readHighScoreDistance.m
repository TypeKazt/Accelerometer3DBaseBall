function [ ballDistance ] = readHighScoreDistance( num, txt )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[value, index] = max(num(:,2));
ballDistance = [txt(index,:), value];

end

