function ROBPAR = robinit(wheel_dist, wheel_r_left, wheel_r_right, start_position)
%ROBINT initialize ROB object for simulation
%   Detailed explanation goes here... no

ROBPAR.par = [wheel_dist, wheel_r_left, wheel_r_right];
ROBPAR.pos = start_position;
ROBPAR.sim_step = 0;
ROBPAR.trace.pos = [start_position];
ROBPAR.trace.time = [0];
ROBPAR.trace.velo = [0];

end

