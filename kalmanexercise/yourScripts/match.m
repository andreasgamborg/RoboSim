function [ matchResult ] = match( pose, poseCov, worldLines, laserLines )
% [matchResult] = MATCH(pose,poseCov,worldLines,laserLines)
%   This function matches the predicted lines to the extracted lines. The
%   criterion for a match is the mahalanobis distance between the (alpha,
%   r) parameters of the predicted and the extracted lines. The arguments
%   are:
%       pose: The estimated robot pose given as [x,y,theta]
%       poseCov: The estimated covariance matrix of the robot pose
%       worldLines: Known world lines in world coordinates, given as
%       [alpha;r] for each line. Number of rows = number of lines
%       laserLines: Lines extracted from the laser scan. Given as [alpha;r]
%       for each line. Number of rows = number of lines
%
%       matchResult: A (5xnoOfWorldLines) matrix whose columns are 
%       individual pairs of line matches. It is structured as follows:
%       matchResult = [ worldLine(1,1) , worldLine(1,2) ...  ]
%                     [ worldLine(2,1) , worldLine(2,2)      ]
%                     [ innovation1(1) , innovation2(1)      ]
%                     [ innovation1(2) , innovation2(2)      ]
%                     [ matchIndex1    , matchIndex2    ...  ]
%           Note that the worldLines are in the world coordinates!

    % The varAlpha and varR are the assumed variances of the parameters of
    % the extracted lines, they are read globally.
    global varAlpha varR
    [~,NW] = size(worldLines);
    [~,NL] = size(laserLines);
    
    matchDist = 2;
    matchResult = [worldLines; zeros(3,NW)];
    
    
    for ii = 1:NW
        [projLine, projCov] = projectToLaser(worldLines(:,ii), pose, poseCov);
        INcov = projCov + [varAlpha 0; 0 varR];
        
        for jj = 1:NL

            innovation = laserLines(:,jj)-projLine;
            mahalanobiDist = sqrt(innovation'/INcov*innovation);
            
            if mahalanobiDist <= matchDist
                matchResult(3:5,ii) = [innovation(1); innovation(2); jj];
            end
        end  
    end
end
