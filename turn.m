function forward(angle,velo)
    global Ts ROBPAR

    if ROBPAR.par(2) ~= ROBPAR.par(3)
        warning("Wheel radius of different sizes");
    end
    ang_velo = velo/ROBPAR.par(2);
    omega = 2*velo/ROBPAR.par(1);
    time = angle/omega;
    step = time/Ts;

    for n = 1:step
        ROBPAR.pos = kinupdate(ROBPAR.pos, ROBPAR.par, Ts, [ang_velo,-ang_velo]);
        update();
    end
end