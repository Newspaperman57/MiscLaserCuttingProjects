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
module lampShadePart(radius, width, fingerDepth, materialThickness, leafsPrShade, i) {
    innerRadius = radius - materialThickness*2;
    translate([radius, radius]) {
        difference() {
            circle(r=radius);
            translate([width , 0])
                circle(r=innerRadius);
            translate([0, -radius])
                square(radius*2);

            translate([-fingerDepth, radius-materialThickness*2])
                square([9000, materialThickness]);
            translate([-fingerDepth, -radius+materialThickness])
                square([9000, materialThickness]);
            offset=(i%2==1?-(180/leafsPrShade)/2:0)+5;
            for(j = [1:leafsPrShade-2]) {
                degrees = j*(180/leafsPrShade)+offset;
                leafRadius = radius-8;
                translate([-leafRadius*sin(degrees)-materialThickness, -leafRadius*cos(degrees)])
                    rotate(-degrees+90)
                        translate([-materialThickness, 0])
                        square([materialThickness, 100]);
            }
        }
    }
}

module lampShade2D(shades, radius, leafsPrShade, centerRadius, materialThickness, wireHole) {
    totalWidth = 40;
    fingerDepth = materialThickness;
    for(i = [0:shades-1]) {
        translate([totalWidth*i, 0])
            lampShadePart(radius , 20, fingerDepth, materialThickness, leafsPrShade, i);
    }
    translate([totalWidth*(shades-1)+centerRadius+20, radius-centerRadius*1.5]) {
        lampShadeCenter(centerRadius , shades, materialThickness, fingerDepth);
    }
    translate([totalWidth*(shades-1)+centerRadius+20, radius+centerRadius*0.5]) {
        lampShadeCenter(centerRadius , shades, materialThickness, fingerDepth, wireHole);
    }
    for(i = [0:shades-1]) {
        for(j = [0:leafsPrShade-1]) {
            translate([i*leafSize*10.1, j*leafSize*1.2*12.5])
                leaf(leafSize);
        }
    }
}

module leaf(scale) {
    translate([0, -12*scale]) {
        scale([1*scale, 1.2*scale]) {
            intersection() {
                translate([0, 5]) {
                    circle(r=5);
                    translate([-50, -100])
                        square([100, 100]);
                }
                translate([-3, 5])
                    circle(r=8);
                translate([3, 5])
                    circle(r=8);
            }
        }
    }
}

module lampShade3D(shades, leafsPrShade, leafMarginStart, leafMarginEnd, radius, centerRadius, materialThickness, wireHole) {
    fingerDepth = materialThickness;
    translate([0, 0, radius*2]) {
        for(i = [1:shades]) {
            rotate([90, 0, i*(360/shades)]) {
                translate([radius+centerRadius-fingerDepth*2, 0, -materialThickness/2]) {
                    rotate(180) {
                        linear_extrude(materialThickness) {
                            lampShadePart(radius, 20, fingerDepth, materialThickness, leafsPrShade, i);
                        }
                    }
                }
                // (radius)*cos(j*(180/(leafsPrShade)+offset))-radius
                offset=(i%2==0?(180/leafsPrShade)/2:0)+5;
                for(j = [leafMarginStart:leafsPrShade-1-leafMarginEnd]) {
                    degrees = j*(180/leafsPrShade)+offset;
                    leafRadius = radius-8;
                    translate([leafRadius*sin(degrees)+centerRadius-materialThickness, leafRadius*cos(degrees)-radius, 0]) {
                        rotate([-90+degrees,90, 0]) {
                            linear_extrude(materialThickness) {
                                leaf(leafSize);
                            }
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

$fn = 128;

color([150/255, 255/255, 51/255]) {
    lampShade2D(shades = 16, leafsPrShade=6, leafMarginStart = 0.5, leafMarginEnd = 1.5, leafSize=6, radius = 100, centerRadius = 18, materialThickness = 3, wireHole = 4);
}
color([0.9765, 0.8431, 0.4941])
    translate([0, 0, 80])
        cylinder(h=90, d=35);