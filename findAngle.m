function [ angleB ] = findAngle( gy, xOrZ )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sideB = gy;
sideA = xOrZ;
sideC = sqrt(sideA^2 + sideB^2);

angleB = acosd((sideA^2 - sideB^2 + sideC^2)/(2*sideA*sideB + .001));

end

