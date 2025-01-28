/////////////////////////////////////////////
// Speed Bag Swivel
// parameterized from inner ball size
/////////////////////////////////////////////

// ball diameter = 25 mm
ball_diameter = 25;

// outer diameter = 108 mm
outer_diameter = 108;
center_offset = outer_diameter / 2;

// center hole diameter = 26mm
center_hole_diameter = 26;
center = center_hole_diameter / 2;

/*

  y ^
    |
    |            ___
    |           /   \
    |          |     \
    |           \     \
    |             |    |
    |             |    |
    |             |    |
    |             |    |
    |             |    |
    |             |    |
    |             |    |
    |             |    |
    |             |    |__________________________________
    |             |                                       \
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             |                                        |
    |             _________________________________________
-----------------------------------------------------------------------------> x
    |
    |
   center of rotation

*/

// left dimensions (mm)
lh1 = 1;
lh2 = 0.5;
lh3 = 1.5;
lh4 = 17;

// top dimensions (mm)
tw1 = 1;
tw2 = 3;
tw3 = 3;
tw4 = 34;
tw5 = 1;

// right dimensions (mm)
rh1 = 3;
rh2 = 9;
rh3 = 1;
rh4 = 8;

total_h = rh1 + rh2 + rh3 + rh4;

// bottom dimensions (mm)
bw0 = 13;   // distance from rotation center - bw1 (center_hole_diameter/2-bw1)
bw1 = 2;
bw2 = 41;   // (outer_diameter / 2) - (center_hole_diameter / 2)

bw_holes_min = bw0 + 16;
bw_holes_max = bw_holes_min + 9;
bw_holes_mid = (bw_holes_min + bw_holes_max) / 2;
holes_diameter = 6;

// draw polygon
// starts on bottom left x-axis away from rotation center
points =[
    [bw0, 0],
    [bw0 + bw2, 0],
    [bw0 + bw2, rh4],
    [bw0 + bw2 - tw5, rh4 + rh3],
    [bw0 + bw2 - tw5 - tw4, rh4 + rh3],
    [bw0 + bw2 - tw5 - tw4, rh4 + rh3 + rh2],
    [bw0 + bw2 - tw5 - tw4 - tw3, rh4 + rh3 + rh2 + rh1],
    [bw0 + bw2 - tw5 - tw4 - tw3 - tw2, rh4 + rh3 + rh2 + rh1],
    [bw0 + bw2 - tw5 - tw4 - tw3 - tw2 - tw1, rh4 + rh3 + rh2 + rh1 - lh1],
    [bw0 + bw2 - tw5 - tw4 - tw3 - tw2 - tw1, rh4 + rh3 + rh2 + rh1 - lh1 - lh2],
    [bw0 + bw2 - tw5 - tw4 - tw3 - tw2 , rh4 + rh3 + rh2 + rh1 - lh1 - lh2 - lh3],
    // [bw0 + bw2 - tw5 - tw4 - tw3 - tw2 - tw1 + bw1, rh4 + rh3 + rh2 + rh1 - lh1 - lh2 - lh3],
    // [bw0, 0],
];

// fragment_number++ for smooth surfaces
$fn = 1000;

difference(){
// union(){
    // rotate-extrude it into 3d shape
    rotate_extrude()
    polygon(points);

    // mounting hole size
    // mounting hole pattern and distance
    for(coord = [
        [0, bw_holes_min, -total_h],
        [0, -bw_holes_min, -total_h],
        [bw_holes_min, 0, -total_h],
        [-bw_holes_min, 0, -total_h],

        [0, bw_holes_max, -total_h],
        [0, -bw_holes_max, -total_h],
        [bw_holes_max, 0, -total_h],
        [-bw_holes_max, 0, -total_h],
    ])
    color("red")
    translate(coord)
    cylinder(d=holes_diameter, h=3*total_h);

    for(trans_pos = [
        [[-holes_diameter/2, bw_holes_min, -total_h], [holes_diameter, bw_holes_max - bw_holes_min, 3*total_h]],
        [[-holes_diameter/2, -bw_holes_max, -total_h], [holes_diameter, bw_holes_max - bw_holes_min, 3*total_h]],
        [[bw_holes_min, -holes_diameter/2, -total_h], [bw_holes_max - bw_holes_min, holes_diameter, 3*total_h]],
        [[-bw_holes_max, -holes_diameter/2, -total_h], [bw_holes_max - bw_holes_min, holes_diameter, 3*total_h]],
    ])
    color("blue")
    translate(trans_pos[0])
    cube(trans_pos[1], center=false);

}
