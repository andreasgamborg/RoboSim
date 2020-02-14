function point2point(pose, vel_fwd, vel_turn)
    global Ts ROBPAR
    
    targetpose = ROBPAR.pos + pose;
    % Distance from vehicle to target point
    rho = sqrt((ROBPAR.pos(1)-targetpose(1))^2 + (ROBPAR.pos(2)-targetpose(2))^2); 
    
    %Difference between starting angle and angle to target
    alpha = -ROBPAR.pos(3) + atan2(targetpose(2)-ROBPAR.pos(2),targetpose(1)-ROBPAR.pos(1));
    
    % negative angle of target pose 
    beta = -ROBPAR.pos(3) - alpha 
   
    turn(alpha,vel_turn);
    
    forward(rho,vel_fwd);
    turn(targetpose(3) + beta,vel_turn);
    
end