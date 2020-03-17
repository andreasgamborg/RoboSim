% Get a laser scan
success = 0;
while(~success)
    [scan success] = getLaser(lsrSck,simulation);
end

%scan is in polar coordinates, convert it to cartesian coordinates
scanCar = [(cos(scan(1,:)).*scan(2,:));(sin(scan(1,:)).*scan(2,:))];

%Extract lines from the scan data
laserLines = ransacLines(scanCar, [maxNoOfLines noOfRandomCouples distThreshold minLineSupport minNoOfPoints]);

%Perform line matching
matchResult = match(pose, poseCov,worldLines, laserLines);
matchPose = pose; %Recording the pose during mathing for plotting purposes

%Update the pose estimate using the measured lines
[pose, poseCov] = measurementUpdate(pose,poseCov, matchResult);

% Move a bit
% Find the next waypoint in world coordinates and put it in targetPose
%Corners = [[0.5 0.5 pi]' [0 0 0]' [-0.5 0.5 pi/2]' [0 0 0]' [-0.5 -0.5 0]' [0 0 0]' [0.5 -0.5 pi/2]' [0 0 0]' [0.5 0.5 pi]' [0 0 0]'];
Roundtrip = [[0.5 0.5 pi]' [-0.5 0.5 pi/2]' [-0.5 -0.5 0]' [0.5 -0.5 pi/2]'];

targetPose = Roundtrip(:,mod(currentWaypoint,4)+1);

dist = sqrt(sum((targetPose(1:2)-pose(1:2)).^2));

if dist < 0.1
    currentWaypoint = currentWaypoint+1;
end

%Find the transformation from the estimated world coordinates to the 
%odometry coordinates
transform = findTransform(odoPose, pose);

%Find the target pose in the odometry coordinates
odoTargetPose = trans(transform,targetPose);

%Drive to the waypoint while updating the pose estimation
[pose, poseCov, odoPose] = driveToWaypoint(mrcSck, pose, poseCov, odoPose, odoTargetPose,simulation);