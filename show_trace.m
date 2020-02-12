function show_trace()
    global ROBPAR
    figure('Renderer', 'painters', 'Position', [10 10 600 600])
        plot(ROBPAR.trace.pos(:,1),ROBPAR.trace.pos(:,2),"b--")
        title("Trace of movement")
        xlabel("X [m]")
        ylabel("Y [m]")
        hold on;

        scale = [   min(ROBPAR.trace.pos(:,1))  max(ROBPAR.trace.pos(:,1));
                    min(ROBPAR.trace.pos(:,2))  max(ROBPAR.trace.pos(:,2))
                ];
        m = max(max(abs(scale)));
        xlim(scale(1,:)+[-0.05,0.05]*m);
        ylim(scale(2,:)+[-0.05,0.05]*m);
        max(abs(scale))
        x = [-0.01, 0.01, 0.01, -0.01,-0.01]*m*2;
        y = [-0.01, -0.01, 0.01, 0.01,-0.01]*m*2;
        plot(x+ROBPAR.pos(1), y+ROBPAR.pos(2), 'r-', 'LineWidth', 3);
        hold off
        grid
        axis equal
    
    figure('Renderer', 'painters', 'Position', [620 10 900 600])
        subplot(2,1,1)
        plot(ROBPAR.trace.time, mod(ROBPAR.trace.pos(:,3),2*pi))
        ylabel("theta [rad]")
        xlabel("time [s]")
        yticks([0 pi/2 pi 3*pi/2 2*pi])
        yticklabels({'0','1/2*/pi', '/pi', '3/2*/pi', '2/pi'})
        grid
        
        subplot(2,1,2)
        plot(ROBPAR.trace.time, ROBPAR.trace.velo)
        ylabel("velocity [m/s]")
        xlabel("time [s]")
        grid
end