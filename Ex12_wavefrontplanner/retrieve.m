function [queue,x,y] = retrieve(queue)
x = queue(1,1)
y = queue(1,2)
queue = queue(2:end,:)
end

