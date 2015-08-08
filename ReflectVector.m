function [ ReflectedVector ] = ReflectVector( Velocity,Normal )
%Outputs the reflected vector of an input vector
   
    d = 2*(Velocity(1,1) * Normal(1,1) + Velocity(1,2) * Normal(1,2)...
        + Velocity(1,3) * Normal(1,3));
    ReflectedVector = Velocity - Normal*d;
    
end

