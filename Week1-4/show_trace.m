function show_trace()
global ROBPAR
[N,M] = size(ROBPAR.trace.pos);
if N < 2
    error("Not enongh points in trace.pos");
    return;
end

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
    
%   Square
%   x = [-0.01, 0.01, 0.01, -0.01,-0.01]*m*2;
%   y = [-0.01, -0.01, 0.01, 0.01,-0.01]*m*2;
%   plot(x+ROBPAR.pos(1), y+ROBPAR.pos(2), 'r-', 'LineWidth', 3);
    
%   Triangle
    tri = [0.5, -0.5, -0.5, 0.5 ; 0, 0.5, -0.5, 0]*m*0.04;
    triR = [cos(-ROBPAR.pos(3)) sin(-ROBPAR.pos(3));
        -sin(-ROBPAR.pos(3)) cos(-ROBPAR.pos(3))]*tri;
    plot(triR(1,:)+ROBPAR.pos(1), triR(2,:)+ROBPAR.pos(2), 'r-', 'LineWidth', 3);
    
    hold off
    grid
    axis equal
    

% Speed and direction plots
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