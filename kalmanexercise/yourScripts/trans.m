function odoTargetPose = trans(transform,targetPose)
% odoTargetPose = trans(transform,targetPose)
% Transform a given pose in world coordinates (targetPose) to odometry
% coordinates, using the origo of the odometry coordinates in world
% coordinates (transform).

theta_o = targetPose(3) + transform(3);

x_o = (cos(transform(3)) - sin(transform(3))) * targetPose(1) + transform(1);
y_o = (sin(transform(3)) + cos(transform(3))) * targetPose(2) + transform(2);



    odoTargetPose = [x_o;y_o;theta_o];
end