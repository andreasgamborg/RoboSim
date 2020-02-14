function kincon(targetpoint, k)
global Ts ROBPAR

if targetpoint ~=3
    warning("Taget point must be a coordinate (x,y,theta)");
end

R = [   cos(targetpoint(3)) sin(targetpoint(3));
    -sin(targetpoint(3)) cos(targetpoint(3))
    ];


done = 0;
step = 0;
    for i = 1:20000

        direction = ROBPAR.pos - targetpoint;
        theta = direction(3);

        %Tranformation
        d = R*(-direction(1:2)');

        dx = d(1);
        dy = d(2);
        
        alpha = -theta + atan2(dy, dx);
        beta = -theta-alpha;
        rho = sqrt(dx^2+dy^2);

        velo = k(1)*rho;

        omega = k(2)*alpha+k(3)*beta;
        
        if(omega ~= 0)
            Radius = velo/omega;
            v1 = omega*(Radius - ROBPAR.par(1)/2);
            v2 = omega*(Radius + ROBPAR.par(1)/2);
        elseif(omega == 0)
            v1 = velo;
            v2 = velo;
        end
        
        ang_velo1 = v1/ROBPAR.par(2);
        ang_velo2 = v2/ROBPAR.par(3);
            
        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo1,ang_velo2]);
        update();
        step = step+1;
        if (rho < 0.01 && beta < 0.02)
            disp('Home run')
            return;
        end
    end
end