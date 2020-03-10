function transform = findTransform(odoPose, pose)
% transform = FINDTRANSFORM(odoPose,pose)
% Find the transformation from the world coordinates to the odometry
% coordinates given a pose in the odometry coordinates (odoPose) and the
% same point in the world coordinates (pose). The output (transform) is
% simply the origo of the odometry coordinates in the world coordinates
    theta_T = odoPose(3) - pose(3);
    
    x_T = odopose(1) - (cos(theta_T) - sin(theta_T))*pose(1);
    y_T = odopose(2) - (sin(theta_T) + cos(theta_T))*pose(2);
    
    
    transform = [x_T;y_T;theta_T];
end