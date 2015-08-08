function [ swingForce ] = readHighScoreSwing( num, txt )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[value, index] = max(num(:,3));
swingForce = [txt(index,:), value];

end

