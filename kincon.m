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
    while done == 0

        direction = targetpoint - ROBPAR.pos;
        theta = - direction(3);

        %Tranformation
        d = R*(-direction(1:2)');

        dx = d(1);
        dy = d(2);
        
        alpha = -theta + atan2(dx, dy);
        beta = -theta-alpha;
        rho = sqrt(dx^2+dy^2);

        velo = k(1)*rho;

        omega = k(2)*alpha+k(3)*beta;
        
        r = ROBPAR.par(2);
        l = ROBPAR.par(1);
        A = (r/2)*[1 1;
                    1/l 1/l];
                
        ang_velo = inv(A)*[velo;omega];
            
        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo(1),ang_velo(2)]);
        update();
        step = step+1;
        if (rho < 0.01 && beta < 0.02) || step > 100000
            done = 1;
        end
    end
end