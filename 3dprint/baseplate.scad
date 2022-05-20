// Case for Halfsize Electrocookie board

use <knurlpocket.scad>

//Global vars
$fa = 1;
$fs = 0.4;

base_length = 106;
base_width = 70;
base_height = 5;

knurl_radius = 2.5;
knurl_depth = 5;
knurl_wall = 2.5;

corner_screw_distance = 5;



//base plate
difference() {
  cube([base_length,base_width,base_height],center=true);
  translate([base_length/2-corner_screw_distance,
    base_width/2-corner_screw_distance,
    0.001])
    m3knurl_pocket();
  translate([-base_length/2+corner_screw_distance,
    base_width/2-corner_screw_distance,
    0.001])
    m3knurl_pocket();
  translate([base_length/2-corner_screw_distance,
    -base_width/2+corner_screw_distance,
    0.001])
    m3knurl_pocket();
  translate([-base_length/2+corner_screw_distance,
    -base_width/2+corner_screw_distance,
    0.001])
    m3knurl_pocket();

}


//top knurdle holder for PCB standoff
translate([36.85,0,5])
    m3knurl_ring();
translate([- 36.85,0,5])
    m3knurl_ring();







