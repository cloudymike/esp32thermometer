// Case for Halfsize Electrocookie board
// Top and actual box

include <parameters.scad>
use <knurlpocket.scad>
use <MCAD/boxes.scad>

board_height = 18;
top_height = wall_depth + board_height + knurl_depth;
top_length = box_length;
top_width = box_width;
screw_radius = 1.75;
echo("topbox size:",top_length,top_width,top_height);


difference() {
union() {
difference() {
//top box walls
  //cube([top_length,top_width,top_height],center=true);
  roundedBox(size=[top_length,top_width,top_height],radius=corner_radius,sidesonly=true);
  translate([0,0,wall_depth])
  cube([top_length-wall_depth,top_width-wall_depth,top_height-wall_depth],center=true);
}

// screw columns
  translate([(top_length/2-corner_screw_distance),
    (top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius + wall_depth/2,h=top_height, center=true);
  translate([(top_length/2-corner_screw_distance),
    -(top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius + wall_depth/2,h=top_height, center=true);
  translate([-(top_length/2-corner_screw_distance),
    (top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius + wall_depth/2,h=top_height, center=true);
  translate([-(top_length/2-corner_screw_distance),
    -(top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius + wall_depth/2,h=top_height, center=true);
}

//screw holes
  translate([top_length/2-corner_screw_distance,
    top_width/2-corner_screw_distance,
    0])
    cylinder(r=screw_radius,h=top_height+0.01, center=true);
  translate([- (top_length/2-corner_screw_distance),
    top_width/2-corner_screw_distance,
    0])
    cylinder(r=screw_radius,h=2*top_height+0.01, center=true);
  translate([(top_length/2-corner_screw_distance),
    -(top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius,h=top_height+0.01, center=true);
  translate([-(top_length/2-corner_screw_distance),
    -(top_width/2-corner_screw_distance),
    0])
    cylinder(r=screw_radius,h=top_height+0.01, center=true);
}

//Size of electrocookie board for testing
//Do not include in design
//roundedBox(size=[board_length,board_width,1],radius=5.1,sidesonly=true);

