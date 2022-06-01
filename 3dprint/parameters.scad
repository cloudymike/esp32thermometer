// Case for Halfsize Electrocookie board
// Parameters for include to keep them same for top and bottom.
// Provide parameters for different electrocookie boards
// Default to halfsize.

//Global vars
$fa = 1;
$fs = 0.4;

board_version = "half";

// board_length
board_length =
(board_version == "full") ? 172.7:
(board_version == "half") ? 88.9:
(board_version == "mini") ? 50.8:88.9;

// board_length
board_width =
(board_version == "full") ? 52.1:
(board_version == "half") ? 52.1:
(board_version == "mini") ? 38.1:52.1;

//m3_hole_distance
m3_hole_distance = 
(board_version == "full") ? 78.7:
(board_version == "half") ? 73.7:
(board_version == "mini") ? 40.6:73.7;

//row_count
row_count =
(board_version == "full") ? 63:
(board_version == "half") ? 30:
(board_version == "mini") ? 17:30;


board_buffer = 3;
wall_depth = 5;

box_length = board_length +2*wall_depth + 2*board_buffer;
box_width = board_width + 2*wall_depth + 2*board_buffer;
corner_radius=5;

knurl_depth = 5;

corner_screw_distance = 5;
