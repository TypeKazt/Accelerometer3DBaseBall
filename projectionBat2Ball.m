function [ projectionVector ] = projectionBat2Ball(ballpos,rotx,roty,rotz,batLen )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%{
 x = batLen * cosd(rotx) * (1 - sind(rotz));
y = batLen * sind(roty) * (1 - sind(rotz));
z = batLen * sind(rotz);

%}
x = batLen * cosd(rotz) * (1 - cosd(rotx));
y = batLen * sind(rotz) * (1 - cosd(roty));
z = batLen * cosd(roty) ;
batVector = [x, y, z];

scalar = dot(batVector,ballpos) / (VectorMag(ballpos)^2);
projectionVector = scalar * ballPos;

end

