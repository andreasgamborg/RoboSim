function kincon(inputpose)
global Ts ROBPAR
    targetpose = inputpose + ROBPAR.pos;
    R = [   cos(targetpose(3)) sin(targetpose(3));
        -sin(targetpose(3)) cos(targetpose(3))
        ];
    %% Tuning
    k = [0.3,0.8,-0.15]; % k_rho k_alpha k_beta Use these to tune the controller
    max_error = [0.01, 0.02]; % distance and angle to target pose
    max_time = 120; % seconds
    %%
    for n = 1:(max_time/Ts)

        direction = targetpose - ROBPAR.pos;
        theta = -direction(3);

        %Transformation
        d = R*(direction(1:2)');
        dx = d(1);
        dy = d(2);
        
        alpha = -theta + atan2(dy, dx);
        beta = -theta-alpha;
        rho = sqrt(dx^2+dy^2);
        
        alpha = wrapToPi(alpha);
                
        velo = k(1)*rho;
        omega = k(2)*alpha+k(3)*beta;
        
        ang_velo1 = (velo - (ROBPAR.par(1)*omega)/2)/ROBPAR.par(2);
        ang_velo2 = (velo + (ROBPAR.par(1)*omega)/2)/ROBPAR.par(3);

        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo1,ang_velo2]);
        update();

        if abs(rho) < max_error(1) && abs(beta) < max_error(2)
            disp("Reached distination (x,y,theta)")
            disp(ROBPAR.pos)
            return;
        end
    end
    warning("Did not reach distination")
end