//Module to create a knurl pocket suitable for Heat-set inserts

// Article about knurl insert
//https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/

//Global vars
$fa = 1;
$fs = 0.2;
knurl_radius = 2.5;
knurl_wall = 2.5;


module m3knurl_ring(knurl_depth = 5)
{

    difference() {   
        cylinder(h=knurl_depth, r=knurl_radius+knurl_wall,center=true);
        m3knurl_pocket(knurl_depth = 5);
    }
    
}

module m3knurl_pocket(knurl_depth = 5)
{
 cylinder(h=knurl_depth+0.001, r=knurl_radius,center=true);
}

m3knurl_ring();
translate([20,0,0]) m3knurl_pocket();