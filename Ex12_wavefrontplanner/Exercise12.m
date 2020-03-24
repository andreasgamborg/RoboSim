map = zeros(10,10);
map(1:7,3)=ones(7,1);
map(3:10)=ones(8,1) ;
goal=[2,2] ;
start=[9,9];


map = makewave(map,goal,start);

route = findroute(map,start);

