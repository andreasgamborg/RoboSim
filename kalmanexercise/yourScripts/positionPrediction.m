function [ poseOut, covOut ] = positionPrediction( poseIn,covIn,delSr,delSl)
%[poseOut, covOut] = POSITIONPREDICTION(poseIn,covIn,delSr,delSl) perform
%one step of robot pose prediction from a set of wheel displacements
%   poseIn = old robot pose
%   covIn = uncertainty on the old robot pose
%   delSr = right wheel linear displacement
%   delSl = left wheel linear displacement


%% Constants
% The robot parameters are read globally, odoB is the wheel separation, kR
% and kL are the odometry uncertainty parameters
global odoB kR kL 

%% pose update

theta = poseIn(3);
b = odoB;

delS = (delSr + delSl)/2;
delTheta = (delSr - delSl)/b;

poseOut = poseIn + [delS*cos(theta + delTheta/2);
                    delS*sin(theta + delTheta/2)
                    delTheta];
                
poseOut(3) = wrapToPi(poseOut(3));

%% Covariance update

dT = theta + delTheta/2;

Fu = [cos(dT)/2 - delS/(2*b)*sin(dT), cos(dT)/2 + delS/(2*b)*sin(dT);
      sin(dT)/2 + delS/(2*b)*cos(dT), sin(dT)/2 - delS/(2*b)*cos(dT);
      1/b, -1/b];
                                                                                             
Qt = [kR*abs(delSr) 0; 0 kL*abs(delSl)];

Fp = [1 0 -delS*sin(theta + delTheta/2);
      0 1 delS*cos(theta + delTheta/2) ;
      0 0                1             ];
                                                         
covOut = Fp*covIn*Fp' + Fu*Qt*Fu';

end
