
clear
clc
close
%%
wheel_dist= 0.26;
wheel_r_left = 0.035;
wheel_r_right = 0.035;
start_position = [0,0,0];

global Ts ROBPAR

Ts = 0.01;

ROBPAR.par = [wheel_dist, wheel_r_left, wheel_r_right];
ROBPAR.pos = start_position;
ROBPAR.sim_step = 0;
ROBPAR.trace.pos = [start_position];
ROBPAR.trace.time = [0];
ROBPAR.trace.velo = [0];

%%


kincon([0.5,0.5,-pi])
show_trace();