function kincon(inputpose)
global Ts ROBPAR
targetpoint = ROBPAR.pos + inputpose;
if length(targetpoint) ~= 3
    warning("Taget point must be a coordinate (x,y,theta)");
end

k = [0.3,0.8,-0.15]; % Use these to tune the controller
R = [   cos(targetpoint(3)) sin(targetpoint(3));
    -sin(targetpoint(3)) cos(targetpoint(3))
    ];

    for n = 1:10000

        direction = targetpoint - ROBPAR.pos;
        theta = -direction(3);

        %Transformation
        d = R*(direction(1:2)');
        dx = d(1);
        dy = d(2);
        
        alpha = -theta + atan2(dy, dx);
        beta = -theta-alpha;
        rho = sqrt(dx^2+dy^2);

        velo = k(1)*rho;
        omega = k(2)*alpha+k(3)*beta;

        ang_velo1 = (velo - (ROBPAR.par(1)*omega)/2)/ROBPAR.par(2);
        ang_velo2 = (velo + (ROBPAR.par(1)*omega)/2)/ROBPAR.par(3);

        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo1,ang_velo2]);
        update();
        
        if rho < 0.01 && beta < 0.02
            return;
            disp("Lamborghini!?")
        end
    end
    
    warning("Did not reach distination")
end