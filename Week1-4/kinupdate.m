function newpose=kinupdate(pose,robotpar,ts, wheelspeed)

% This function calculates the next pose taking the current pose,
% the robot parameters, the wheel speeds and the sampletime as input

% pose:         current pose [x , y, theta]
% robotpar:     [ wheelseparation, radius right wheel,radius left wheel]
% ts:           sampletime
% wheelspeed:   [angular velocity left wheel, angular velocity right wheel]

w = robotpar(1);
r_right = robotpar(2);
r_left = robotpar(3);

A= [    1 0 -w/2;
        1 0 w/2;
        0 1 0
    ];

J = [   r_left*wheelspeed(1);
        r_right*wheelspeed(2);
        0
    ];
theta = pose(3);
R = [   cos(theta) sin(theta) 0;
        -sin(theta) cos(theta) 0;
        0 0 1
    ];
xi_dot = inv(R)*inv(A)*J;
newpose = pose+xi_dot'*ts;

end