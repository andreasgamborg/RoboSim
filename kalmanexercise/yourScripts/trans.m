function odoTargetPose = trans(transform,targetPose)
% odoTargetPose = trans(transform,targetPose)
% Transform a given pose in world coordinates (targetPose) to odometry
% coordinates, using the origo of the odometry coordinates in world
% coordinates (transform).
   
    odoTargetPose = [0;0;0];
    theta_T =  transform(3);
    
    odoTargetPose(3) = targetPose(3) + theta_T;
    
    R = [cos(theta_T) -sin(theta_T); sin(theta_T) cos(theta_T)];
    odoTargetPose(1:2) = R*pose(1:2)+transform(1:2) ;
end