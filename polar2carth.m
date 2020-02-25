function carth = polar2carth(polar)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    r = polar(2,:);
    theta = polar(1,:);
    
    x = cos(theta).*r;
    y = sin(theta).*r;
    
    carth = [x; y];

end

