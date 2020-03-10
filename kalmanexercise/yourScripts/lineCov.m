function lCov = lineCov(projectedLine, poseIn, covIn)

aw = projectedLine(1);
H = [0 0 -1; -cos(aw) -sin(aw) 0];

lCov = H*covIn*H';

end

