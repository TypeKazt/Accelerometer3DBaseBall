function [ normal ] = normalize(BallPos,BatPos)
    %returns the normal vector between bat and ball with respect to ball
    normalize = BallPos-BatPos;
    m = VectorMag(normalize);
    normal = zeros(1,3);
    if m > 0
        normal = normalize / m;
    end
end

