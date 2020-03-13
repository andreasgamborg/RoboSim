function [ projectedLine, lCov ] = projectToLaser( worldLine,poseIn, covIn)
    %[projectedLine, lineCov] = PROJECTTOLASER(worldLine,poseIn,covIn) 
    %Project a word line to the laser scanner frame given the
    %world line, the robot pose and robot pose covariance. Note that the laser
    %scanner pose in the robot frame is read globally
    %   worldLine: The line in world coordinates
    %   poseIn: The robot pose
    %   covIn: The robot pose covariance
    %
    %   projectedLine: The line parameters in the laser scanner frame
    %   lineCov: The covariance of the line parameters

    %% Constants
    global lsrRelPose % The laser scanner pose in the robot frame is read globally

    %% Calculation
    R = [cos(-poseIn(3)) sin(-poseIn(3)) 0;
        -sin(-poseIn(3)) cos(-poseIn(3)) 0;
        0 0 1];
    scanpose = poseIn + R*lsrRelPose';

    aw = worldLine(1);

    al = aw - scanpose(3);
    rl = worldLine(2) - scanpose(1)*cos(aw) - scanpose(2)*sin(aw);

    projectedLine = [al,rl];

    lCov = lineCov(projectedLine, poseIn, covIn);
end