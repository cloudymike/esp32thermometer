// Case for Electrocookie board
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


// display hole if exist
    if (!is_undef(display_pin1_row)) {
        // Assume it is in column J
        oled_center_from_top = first_column+(oled_height/2-oled_pin_from_top);
        oled_top_space = oled_height - oled_display_height - oled_bottom_space;
        y_offset = oled_bottom_space - oled_top_space;
        display_center_from_top = oled_center_from_top - y_offset;
        oled_center_y = - (board_width/2 - display_center_from_top);
        // Use display_row
        oled_pin1_from_left = first_row + (display_pin1_row-1)*row_spacing;
        oled_center_from_pin1 = oled_width/2 - oled_pin1;
        oled_center_x = (oled_pin1_from_left + oled_center_from_pin1) - board_length/2;
        echo("OLED center",oled_center_x, oled_center_y);
        echo("OLED left edge from box edge",box_length/2 + oled_center_x - oled_display_width/2);
        echo("OLED bottom edge from box edge",box_width/2 - oled_center_y - oled_display_height/2);
        translate([oled_center_x, oled_center_y, 0])
            cube([oled_display_width,oled_display_height,top_height+1],center=true);                
    }
}

//Size of electrocookie board for testing
//Do not include in design
//roundedBox(size=[board_length,board_width,1],radius=5.1,sidesonly=true);

