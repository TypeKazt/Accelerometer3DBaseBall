function [ projectionVector ] = projectionBall2Bat(ballPosition, rotx, roty, rotz, batLen)
%{
x = batLen * cosd(rotx) * (1 - sind(rotz));
y = batLen * sind(roty) * (1 - sind(rotz));
z = batLen * sind(rotz);
%}
x = batLen * cosd(rotz) * (1 - cosd(rotx));
y = batLen * sind(rotz) * (1 - cosd(roty));
z = batLen * cosd(rotx) ;

batVector = [x, y, z];

scalar = dot(ballPosition, batVector) / (VectorMag(batVector)^2);
projectionVector = scalar * batVector;

end