function carth_global = transform(systempose_w,pos_l)

    carth_global = zeros(2,length(pos_l));
    
    T = [cos(systempose_w(3)) -sin(systempose_w(3));
         sin(systempose_w(3))  cos(systempose_w(3))];

    for i = 1:length(pos_l)
        
        carth_global(1:2,i) = T*pos_l(:,i) + [systempose_w(1);systempose_w(2)];
   
    end

end

