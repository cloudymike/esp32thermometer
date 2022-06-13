#!/bin/bash
set -e
openscad -o baseplate.stl baseplate.scad | tee baseplate.tmp
diff baseplate.ref baseplate.tmp

openscad -o topbox.stl topbox.scad | tee topbox.tmp
diff topbox.ref topbox.tmp

 
