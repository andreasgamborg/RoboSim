function update()
    global ROBPAR Ts
    ROBPAR.sim_step = ROBPAR.sim_step + 1;
    ROBPAR.trace.pos = [ROBPAR.trace.pos; ROBPAR.pos];
    ROBPAR.trace.time = [ROBPAR.trace.time; ROBPAR.sim_step*Ts];
    
    dx = ROBPAR.trace.pos(end,1) - ROBPAR.trace.pos(end-1,1);
    dy = ROBPAR.trace.pos(end,2) - ROBPAR.trace.pos(end-1,2);

    velo = sqrt(dx^2+dy^2)/Ts;

    ROBPAR.trace.velo = [ROBPAR.trace.velo; velo];
end