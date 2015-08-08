function [VelAndPos] = CollisionDetection...
    ( Distance,BallVel,BatVel,BallPos,BatPos,BallRadius,BatRadius )
%Determines whether bat and ball collide
%Outputs new velocity vector for ball and position in one vector

   % Velocity = zeros(1,3);
   
        normal = normalize(BallPos,BatPos);
        Position = BallPos + normal*(BallRadius + BatRadius); 
        Velocity = ReflectVector(BallVel,normal) - ReflectVector(BatVel,normal);
        VelAndPos = [Velocity Position];
      %  Velocity = ReflectVector(BallVel,normal);
    
    

end

