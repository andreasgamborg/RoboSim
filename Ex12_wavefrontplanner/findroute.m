function route = findroute(map,start)
 
    route = start;
    x = start(1); % current pose
    y = start(2);
    while(map(x,y) ~= 2)
        d = map(x,y);
        for xn = x-1:x+1
           for yn = y-1:y+1
                if (xn > 0 && xn <= size(map,1) && yn > 0 && yn <= size(map,2))
                    if (map(xn,yn) < d && map(xn,yn) > 1)
                        d = map(xn,yn);
                        nextindex = [xn,yn];
                    end
                end
           end
        end
        route = [route;nextindex];
        x = nextindex(1);
        y = nextindex(2);
    end
    
end

