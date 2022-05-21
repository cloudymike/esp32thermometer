// Case for Halfsize Electrocookie board

include <parameters.scad>
use <knurlpocket.scad>
use <MCAD/boxes.scad>

base_height = wall_depth;
base_length = box_length;
base_width = box_width;
echo("baseplate size:",base_length,base_width,base_height);

//base plate
difference() {
  //cube([base_length,base_width,base_height],center=true);
  roundedBox(size=[base_length,base_width,base_height],radius=corner_radius,sidesonly=true);
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


