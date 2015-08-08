function [ mag ] = VectorMag( vector )
%returns magnitude of vector
mag = 0;
for i = 1:numel(vector)
    mag = mag + vector(1,i)^2;
end
mag = sqrt(mag);
end

