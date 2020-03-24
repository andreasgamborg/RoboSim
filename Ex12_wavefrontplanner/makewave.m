function wavemap = makewave(map,goal,start)
    
    queue = [goal(1) goal(2)];
    wavemap = map;
    wavemap(goal(1),goal(2)) = 2;
    
    while (size(queue,1) > 0)
        cp = [0,0];
        [queue,cp(1), cp(2)] = retrieve(queue);
        for x = cp(1)-1:cp(1)+1
            for y = cp(2)-1:cp(2)+1
                if (x > 0 && x <= size(wavemap,1) && y > 0 && y <= size(wavemap,2))
                    d = wavemap(cp(1),cp(2)) + sqrt((x-cp(1))^2+(y-cp(2))^2);
                    if wavemap(x,y) == 0
                        wavemap(x,y) = d;
                        queue = insert(queue,x,y);
                    elseif (wavemap(x,y) > d)
                        wavemap(x,y) = d;
                    end
                end
            end
        end
    end
end

