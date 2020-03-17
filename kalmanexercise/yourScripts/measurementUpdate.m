function [ poseOut, poseCovOut ] = measurementUpdate( poseIn, poseCovIn, matchResult )
%[ poseOut, poseCovOut ] =MEASUREMENTUPDATE ( poseIn, poseCovIn,
%matchResult ) perform extended Kalman filter measurement update on the
%estimated robot pose poseIn with covariance poseCovIn using a set of
%matched predicted and extracted laser scanner lines given in matchResult.
%The arguments are defined as:
%       poseIn: The estimated robot pose given as [x,y,theta]
%       poseCovIn: The estimated covariance matrix of the robot pose
%       matchResult: A (5xnoOfWorldLines) matrix whose columns are 
%       individual pairs of line matches. It is structured as follows:
%       matchResult = [ worldLine(1,1) , worldLine(1,2) ...  ]
%                     [ worldLine(2,1) , worldLine(2,2)      ]
%                     [ innovation1(1) , innovation2(1)      ]
%                     [ innovation1(2) , innovation2(2)      ]
%                     [ matchIndex1    , matchIndex2    ...  ]
%           Note that the worldLines are in the world coordinates!
%       
%       poseOut: The updated robot pose estimate
%       poseCovOut: The updated estimate of the robot pose covariance 
%       matrix 

    % Constants
    % The laser scanner pose in the robot frame is read globally(lsrRelpose)
    % The varAlpha and varR are the assumed variances of the parameters of
    % the extracted lines, they are also read globally
    global lsrRelPose varAlpha varR
    
    nl = size(matchResult,2);
    
    pose = poseIn;
    poseCov = poseCovIn;
    
    nm = nnz(matchResult(end,:));
    
    for i = 1:nl
        if(matchResult(end,i) ~= 0)
            
            H = [0 0 -1; -cos(matchResult(1,i)) -sin(matchResult(1,i)) 0];
             
            Sigma_in = H*poseCovIn*H' + diag([varAlpha varR]);
             
            Kt = poseCovIn*H'*inv(Sigma_in);
            
            pose = pose + Kt*matchResult(3:4,i)/nm;
            poseCov = poseCov - (Kt*Sigma_in*Kt')/nm;
            
            %break
            
        end
    end

    poseOut = pose;
    poseCovOut = poseCov;

end
