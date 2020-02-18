%% Refresh
clear
clc
close all
%% Specifications
wheel_dist= 0.26;
wheel_r_left = 0.035;
wheel_r_right = 0.035;
start_position = [0,0,0];

%% Initialyze
global Ts ROBPAR
Ts = 0.01;
ROBPAR = robinit(wheel_dist, wheel_r_left, wheel_r_right, start_position);

%% Simulation




%% Show trace of robot
show_trace();