
function [Data] = main_game(hObject, handles,gravity,ballSpeed)
%run,gravity,ball_size,wind_speed,ball_velocity, 
%% initialize


function DrawBat( anglex,angley,anglez)
%draws cylinder which represents bat

R_az= [cosd(anglez),-sind(anglez),0 ; ...
    sind(anglez),cosd(anglez),0 ;...
    0 0 1];
R_ax = [1 0 0;0 cosd(anglex) -sind(anglex);0 sind(anglex) cosd(anglex)];


R2 = R_az*R_ax;




[cyx, cyy, cyz] = cylinder(1,36);

cyz = cyz * 6;
cyx = cyx * .5;
cyy = cyy * .5;
cyx = cyx + .5;
cyy = cyy + .5;

XYZ = R2*[cyx(:).'; cyy(:).' ; cyz(:).'];

cyx=reshape( XYZ(1,:), size(cyx));
cyy=reshape( XYZ(2,:), size(cyy));
cyz=reshape( XYZ(3,:), size(cyz));


surf(cyx,cyy,cyz);

end


%% vars
fence = imread('fence.jpg');
grass = imread('turf.jpg');

hitsound = audioread('HitSound.wav');
hitsound = audioplayer(hitsound,9600*5);

countdown = audioread('count.wav');
countdown = audioplayer(countdown,9600*5);

cheering = audioread('Cheering.wav');
cheering = audioplayer(cheering,9600*5);

bouncesound = audioread('bounce.wav');
bouncesound = audioplayer(bouncesound,9600*5);

[x,y,z] = sphere(20);
radius = .5; % radius of ball
real_size = .5; %used to scale radius
anglex = 0;
angley = 0;
anglez = -20;

vel = [-sqrt(ballSpeed),-sqrt(ballSpeed),0];%velocity of ball
accel = [0, 0, -gravity/100];% gravitational force on ball
pos = [radius+20,radius+16,radius]; %position of ball
reflected_ball_speed = [0 0 0];

axis_scale = [0 21 0 21 0 21];
ax = axes('Xlim',axis_scale(1:2),'Ylim',axis_scale(3:4),...
    'Zlim',axis_scale(5:6));

swing_occured = 0; %boolean for if swing happens
SwingMag = 0;%magnitude of bat force
SwingMagHold = 0; %returned value
batDir = [0,0,0];



%% Field graphics

grassx = [axis_scale(1,1),axis_scale(1,2);axis_scale(1,1),axis_scale(1,2)];
grassy = [axis_scale(1,4),axis_scale(1,4);axis_scale(1,3),axis_scale(1,3)];
grassz = [.001,.001;.001,.001];

fenceLeftx = grassx;
fenceLefty = [axis_scale(1,4),axis_scale(1,4)...
    ;axis_scale(1,4),axis_scale(1,4)];
fenceLeftz = [0 0; 7,7];

fenceRightx = [axis_scale(1,2),axis_scale(1,2);...
    axis_scale(1,2),axis_scale(1,2)];
fenceRighty = [axis_scale(1,3),axis_scale(1,4);...
    axis_scale(1,3),axis_scale(1,4)];
fenceRightz = fenceLeftz;

%% low graphics settings
%{
grass_field = [axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) ...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,4); axis_scale(1,3) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,3) axis_scale(1,3) axis_scale(1,3)]; %grass field

fenceLeft = [axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,1)...
    axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,2) ; axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
    ; 0 8 8 8 8 4 4 4 4 0 0 0 0 4]; %left fence

%fenceRight = [fenceLeft(2,:);fenceLeft(1,:);fenceLeft(3,:)];
fenceRight = [ axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    ; axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,3)...
    axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4);0 8 8 8 8 4 4 4 4 0 0 0 0 4]; %right fence
%}

%% run game

axis(axis_scale);
play(countdown);
pause(3);
  % while VectorMag(vel) > .1
  for i = 1:150
  
    radius = real_size*(0.01+(VectorMag(axis_scale) - VectorMag(pos))/...
        VectorMag(axis_scale)); % scales ball relative to camera position and axis size
    
    %draws ball    
    surf(x*radius + pos(1,1),y*radius+pos(1,2),z*radius+pos(1,3)) 
    
    hold on
   
    % senses bat swing, draws bat, and detects collisions
    
   if(axis_scale(1,2) == 21 && axis_scale(1,4) == 21)
       
       if(swing_occured == 0)
           %force of swing
            batDir = batDirection(hObject, handles);
            SwingMag = VectorMag(batDir);
            if(SwingMag > 3)
                swing_occured = 1;
            end
       end
       if(swing_occured == 1)
     
          if(anglex == 90)
                if(anglez < 140)
                  anglez = anglez + 20;
                else
                    swing_occured = 2;
                    SwingMagHold = SwingMag;
                    SwingMag = 0;
                end
          else
              angley = 0;
              anglex = 90;
          end
          
          
       end
    
        DrawBat(anglex,angley,anglez);
        
        if(VectorMag(pos)-VectorMag(vel) <= 5)
            projection = projectionBall2Bat(pos,anglex,angley,anglez,5);
            BallBatDis = ball2batDistance(pos,projection,radius,2,vel);
        else
            BallBatDis = 1;
        end
     
        
    if(BallBatDis < .1 ) % if distance between bat and ball is small
        collide_vectors =...
        CollisionDetection(BallBatDis,vel,[batDir(1,1)*SwingMag/10,...
        batDir(1,2)*SwingMag/10,batDir(1,3)*SwingMag/10],pos,...
        projection,radius,5);
        
        vel = collide_vectors(1:3);
        reflected_ball_speed = vel;
        pos = collide_vectors(4:6);
        
        play(hitsound);
    end
   end

   %{
    
    if(axis_scale(1,2) == 21 && axis_scale(1,4) == 21)
        
        batDir = batDirection(hObject, handles);%bat direction vector
    
        anglex = findAngle(batDir(1,2),batDir(1,1));%*(batDir(1,1)/sqrt(batDir(1,1)^2));
        angley = findAngle(batDir(1,2),batDir(1,3));
        
        projection = projectionBall2Bat(pos,anglex,angley,anglez,10);
        
        BallBatDis =...
        ball2batDistance(pos,projection);
    
        collide_vectors =...
        CollisionDetection(BallBatDis,vel,BatVel,...
        projection,radius,BatRadius);
        
        vel = collide_vectors(1,1);
        pos = collide_vectors(1,2);
    
        DrawBat(anglex,angley);
    end
    %}
    
    %{
    grass_field = [axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) ...
    axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
    axis_scale(1,2) axis_scale(1,4); axis_scale(1,3) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,4)...
    axis_scale(1,4) axis_scale(1,3) axis_scale(1,3) axis_scale(1,3)];%define grass
    %}
    grassx = [axis_scale(1,1),axis_scale(1,2);axis_scale(1,1),axis_scale(1,2)];
    grassy = [axis_scale(1,4),axis_scale(1,4);axis_scale(1,3),axis_scale(1,3)];
    grassz = [.001,.001;.001,.001];
    
    surf(grassx,grassy,grassz,'CData',grass,'FaceColor','texturemap') %draws grass
    surf(fenceLeftx,fenceLefty,fenceLeftz,...
        'CData',fence,'FaceColor','texturemap') %draws fence
    surf(fenceRightx,fenceRighty,fenceRightz,'CData',fence,'FaceColor','texturemap')
    
   
    axis(axis_scale);
   
    axis off
    
    hold off
    
    vel = vel + accel;
    vel = vel - .01.*vel;
    pos = pos + vel;
    
    if(pos(1,3)  <= radius )
        pos(1,3) = radius ;
         vel(1,3) = vel(1,3)*-.7;
         vel = vel - vel*.1;
   
    end
    if(pos(1,2) >= axis_scale(1,4) - radius && pos(1,3) <= fenceLeftz(2,1)-radius )
        pos(1,2) = axis_scale(1,4) - radius ;
         vel(1,2) = vel(1,2)*-.4;
         play(bouncesound);
    end
    if(pos(1,1) >= axis_scale(1,2) - radius && pos(1,3) <= fenceLeftz(2,1)-radius )
        pos(1,1) = axis_scale(1,2) - radius ;
         vel(1,1) = vel(1,1)*-.4;
         play(bouncesound);
    end
    if(pos(1,1) <= axis_scale(1,1)+radius)
        pos(1,1) = axis_scale(1,1) + radius ;
         vel(1,1) = vel(1,1)*-.4;
         play(bouncesound);
    end
    if(pos(1,2) <= axis_scale(1,3) + radius)
        pos(1,2) = axis_scale(1,3) + radius ;
         vel(1,2) = vel(1,2)*-.4;
         play(bouncesound);
    end
    if(pos(1,1) >= axis_scale(1,2)) 
        %adjusts x axis scale based on position as well as fence
        axis_scale(1,1) = pos(1,1);
        axis_scale(1,2) = pos(1,1) + 21;
        fenceLeftx = [axis_scale(1,1),axis_scale(1,2);axis_scale(1,1),axis_scale(1,2)];
        fenceLefty = [axis_scale(1,4),axis_scale(1,4)...
        ;axis_scale(1,4),axis_scale(1,4)];
        

        fenceRightx = [axis_scale(1,2),axis_scale(1,2);...
        axis_scale(1,2),axis_scale(1,2)];
        fenceRighty = [axis_scale(1,3),axis_scale(1,4);axis_scale(1,3),axis_scale(1,4)];
        
        play(cheering);
        
    end
    
    if(pos(1,2) >= axis_scale(1,4))
        %adjusts x axis scale based on position as well as fence
        axis_scale(1,3) = pos(1,2);
        axis_scale(1,4) = pos(1,2) + 21;
        fenceLeftx = [axis_scale(1,1),axis_scale(1,2);axis_scale(1,1),axis_scale(1,2)];
        fenceLefty = [axis_scale(1,4),axis_scale(1,4)...
        ;axis_scale(1,4),axis_scale(1,4)];
        

        fenceRightx = [axis_scale(1,2),axis_scale(1,2);...
        axis_scale(1,2),axis_scale(1,2)];
        fenceRighty = [axis_scale(1,3),axis_scale(1,4);axis_scale(1,3),axis_scale(1,4)];
        
        play(cheering);
    end
    %{
    if(mod(pos(1,1),21) <= 1) %adjusts fences
        %{
        fenceLeft = [axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,1)...
        axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) ; axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        ; 0 8 8 8 8 4 4 4 4 0 0 0 0 4];


        fenceRight = [ axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        ; axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,3)...
        axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4);0 8 8 8 8 4 4 4 4 0 0 0 0 4];
        %}
        
    end
    
    if(mod(pos(1,2),21) <= 1) % adjusts fencs
        %{
        fenceLeft = [axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,1)...
        axis_scale(1,1) axis_scale(1,1) axis_scale(1,1) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) ; axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4)...
        ; 0 8 8 8 8 4 4 4 4 0 0 0 0 4];


        fenceRight = [ axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        axis_scale(1,2) axis_scale(1,2) axis_scale(1,2)...
        ; axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4) axis_scale(1,4) axis_scale(1,3)...
        axis_scale(1,3) axis_scale(1,3) axis_scale(1,3) axis_scale(1,4)...
        axis_scale(1,4) axis_scale(1,4);0 8 8 8 8 4 4 4 4 0 0 0 0 4];
        %}
        
    end
    %}
   % axis_scale = [pos(1,1)-10,pos(1,1)+15,pos(1,2)-10,pos(1,2)+15,0,21];
  %{  
   if(pos(1,1) + vel(1,1) >= 21-radius)
        pos(1,1) = 21-radius-.1;
        vel(1,1) = vel(1,1)*-1;
        
    end
    if (pos(1,1) - vel(1,1) <= radius)
        pos(1,1) = radius + .1;
        vel(1,1) = vel(1,1)*-1;
       
        
    end
    if(pos(1,2) + vel(1,2) + accel(1,2) >= 21-radius)
        pos(1,2) = 21-radius-.1;
         vel(1,2) = vel(1,2)*-1;
       
         
    end
    if(pos(1,2) - vel(1,2) + accel(1,2) <= radius)
        pos(1,2) = radius + .1;
         vel(1,2) = vel(1,2)*-1;
         
         
    end
    %}
    
    
   
    %{
    if(pos(1,3) + vel(1,3) + accel(1,3) >= 21-radius)
        pos(1,3) = 21-radius-.1;
         vel(1,3) = vel(1,3)*-1;
    end
    %}
     
     pause(0.008);
   
    
  
  end
  
   Data = [VectorMag(pos), VectorMag(reflected_ball_speed),SwingMagHold];
end