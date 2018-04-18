module lampShadeCenter(radius, shades, materialThickness, fingerDepth, wireHole=0) {
    translate([radius, radius]) {
        difference() {
            circle(r=radius);
            for(i = [0:shades]) {
                rotate(i*(360/shades)) {
                    translate([-materialThickness/2, radius-fingerDepth]) {
                        square([materialThickness, fingerDepth]);
                    }
                }
            }
            circle(d=wireHole);
        }
    }
}
module lampShadePart(radius, width, fingerDepth, materialThickness) {
    innerRadius = radius - materialThickness*2;
    translate([radius, radius]) {
        difference() {
            circle(r=radius);
            translate([width , 0])
                circle(r=innerRadius);
            translate([0, -radius])
                square(radius*2);
            translate([-fingerDepth, radius-materialThickness*2])
                square([fingerDepth , materialThickness]);
            translate([-fingerDepth, -radius+materialThickness])
                square([fingerDepth , materialThickness]);
        }
    }
}

module lampShade2D(shades, radius, centerRadius, materialThickness, wireHole) {
    shades = 24;
    radius = 80;
    centerRadius = 30;
    materialThickness = 3;
    fingerDepth = materialThickness;
    for(i = [0:shades-1]) {
        translate([40*i, 0])
            lampShadePart(radius , 20, fingerDepth, materialThickness);
    }
    translate([40*(shades-1)+centerRadius, radius-centerRadius]) {
        lampShadeCenter(centerRadius , shades, materialThickness, fingerDepth);
    }
    translate([40*(shades-1)+centerRadius*3+1, radius-centerRadius]) {
        lampShadeCenter(centerRadius , shades, materialThickness, fingerDepth, wireHole);
    }
}

module lampShade3D(shades, radius, centerRadius, materialThickness, wireHole) {
    fingerDepth = materialThickness;
    translate([0, 0, radius*2]) {
        for(i = [0:shades]) {
            rotate([90, 0, i*(360/shades)+2.5]) {
                translate([radius+centerRadius-fingerDepth*2, 0]) {
                    rotate(180) {
                        linear_extrude(materialThickness) {
                            lampShadePart(radius, 20, fingerDepth, materialThickness);
                        }
                    }
                }
            }
        }
        translate([0, 0, materialThickness-radius*2]) {
            linear_extrude(materialThickness) {
                translate([-centerRadius, -centerRadius]) {
                    lampShadeCenter(centerRadius, shades, materialThickness, fingerDepth);
                }
            }
        }
        translate([0, 0, -materialThickness*2]) {
            linear_extrude(materialThickness) {
                translate([-centerRadius, -centerRadius]) {
                    lampShadeCenter(centerRadius, shades, materialThickness, fingerDepth, wireHole);
                }
            }
        }
    }
}

color([150/255, 111/255, 51/255]) {
lampShade2D(shades = 24, radius = 80, centerRadius = 30, materialThickness = 3, wireHole = 4);
}