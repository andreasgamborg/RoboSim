function T = findTransform(odoPose, pose)
% transform = FINDTRANSFORM(odoPose,pose)
% Find the transformation from the world coordinates to the odometry
% coordinates given a pose in the odometry coordinates (odoPose) and the
% same point in the world coordinates (pose). The output (transform) is
% simply the origo of the odometry coordinates in the world coordinates
    T = [0;0;0];
    
    T(3) = odoPose(3) - pose(3);
        
    R = [cos(theta_T) -sin(theta_T); sin(theta_T) cos(theta_T)];
    T(1:2) = odoPose(1:2)-R*pose(1:2);
end