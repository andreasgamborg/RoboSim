function carth = polar2carth(polar)
% Converts the polar coordinates in polar
% to carthesian coordinates x,y.
% The output should be an array of the same size as pol containing
% the carthesian coordinates.

% polar: [theta,rho] // polar coordinates
% carth: [x,y] // cartesian coordinates

    r = polar(2,:);
    theta = polar(1,:);
    
    x = cos(theta).*r;
    y = sin(theta).*r;
    
    carth = [x; y];

end

