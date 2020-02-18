function kincon(inputpose)
global Ts ROBPAR
targetpose = inputpose + ROBPAR.pos;
if length(targetpose) ~= 3
    warning("Taget point must be a coordinate (x,y,theta)");
end

k = [0.3,0.8,-0.15]; % k_rho k_alpha k_beta Use these to tune the controller
R = [   cos(targetpose(3)) sin(targetpose(3));
    -sin(targetpose(3)) cos(targetpose(3))
    ];

    for n = 1:10000

        direction = targetpose - ROBPAR.pos;
        theta = -direction(3);

        %Transformation
        d = R*(direction(1:2)');
        dx = d(1);
        dy = d(2);
        
        alpha = -theta + atan2(dy, dx);
        beta = -theta-alpha;
        rho = sqrt(dx^2+dy^2);
        
        alpha = wrapToPi(alpha)
                
        velo = k(1)*rho;
        omega = k(2)*alpha+k(3)*beta;
        
        params = [params;
                  n alpha beta rho omega];
        
        ang_velo1 = (velo - (ROBPAR.par(1)*omega)/2)/ROBPAR.par(2);
        ang_velo2 = (velo + (ROBPAR.par(1)*omega)/2)/ROBPAR.par(3);

        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo1,ang_velo2]);
        update();

        if abs(rho) < 0.01 && abs(beta) < 0.02

            return;
        end
    end
    figure(11)
    hold on
    plot(params(:,1),params(:,2))
    plot(params(:,1),params(:,3))
    plot(params(:,1),params(:,4))
    plot(params(:,1),params(:,5))
    hold off
    legend(["alpha";"beta";"rho";"omega"])
    warning("Did not reach distination")
end