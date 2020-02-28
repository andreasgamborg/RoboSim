function line = lsqline(points)

    x = points(1,:);
    y = points(2,:);

    sigma_x = sum(x);
    sigma_y = sum(y);
    sigma_x2 = x*x';
    sigma_y2 = y*y';
    sigma_xy = x*y';

    n = length(points);

    mu_x = sigma_x/n;
    mu_y = sigma_y/n;
    
    num = 2*sigma_x*sigma_y - 2*n*sigma_xy;
    den = sigma_x^2 - sigma_y^2 - n*sigma_x2 + n*sigma_y2;

    alpha = atan2(num,den)/2;
        
    r = mu_x*cos(alpha) + mu_y*sin(alpha);
    
    if r < 0
        r = abs(r)
        if alpha < 0
            alpha = alpha + pi
        else
            alpha = alpha - pi
        end
    end
    
    line = [alpha,r];

end

