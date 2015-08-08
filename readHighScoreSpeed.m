function [ ballSpeed ] = readHighScoreSpeed( num, txt )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[value, index] = max(num(:,1));
ballSpeed = [txt(index,:), value];

end

