// UNTESTED

use <lasercutDrawer/dotted.scad>

materialThickness = 3;
bottomDepth = 50;
bottomWidth = 150;
topDepth = 30;
topWidth = 50;
height = 200;
marginbetween = 1;

module base(materialThickness, baseWidth, baseDepth) {
    difference() {
        square([baseWidth, baseDepth]);
        translate([materialThickness,0,0]) {
            rotate(90) {
                dotted(baseDepth, materialThickness);
            }
        }
        translate([0, (baseDepth-materialThickness)/2])
            dotted(baseWidth/2, materialThickness);
    }
}

function rotatePoint(p, angle) = [p.x * cos(-angle) - p.y * sin(-angle), p.x * sin(-angle) + p.y * cos(-angle)];

module sides(materialThickness, baseWidth, baseDepth, platformWidth, platformDepth, height) {
    side = [
        [0, 0],
        [baseDepth, 0],
        [(baseDepth-platformDepth)/2+platformDepth, height],
        [(baseDepth-platformDepth)/2, height]
    ];
    difference() {
        polygon(side);
        reverseDotted(baseDepth, materialThickness);
        translate([(baseDepth-platformDepth)/2, height-materialThickness])
            reverseDotted(platformDepth, materialThickness);
        translate([(baseDepth-materialThickness)/2+materialThickness, materialThickness])
            rotate(90)
                dotted(baseWidth/2, materialThickness);
        translate([(platformWidth-materialThickness)/2+materialThickness, height-materialThickness-platformWidth/2])
            rotate(90)
                dotted(platformWidth/2, materialThickness);
    }
}
module platform(materialThickness, platformWidth, platformDepth) {
    base(materialThickness, platformWidth, platformDepth);
}

module supports(materialThickness, depth, length, angle) {
    difference() {
        translate([0, materialThickness])
            polygon([[0,0], rotatePoint([0, length], angle), [depth, 0]]);
    }
    translate([-materialThickness, 0])
        dotted(depth, materialThickness);
    translate([0.05, materialThickness]) // 0.05 to ensure dots connect to object
        rotate(90-angle)
            dotted(length, materialThickness);
}

base(materialThickness, bottomWidth, bottomDepth);
offset1 = bottomWidth+marginbetween;
translate([offset1,0])
    platform(materialThickness, topWidth, topDepth);
offset2 = bottomDepth+marginbetween+offset1;
translate([offset2,0])
    sides(materialThickness, bottomWidth, bottomDepth, topWidth, topDepth, height );
offset3 = offset2;
//+bottomDepth+marginbetween;
//translate([offset3,0])
//    sides(materialThickness, bottomWidth, bottomDepth, topWidth, topDepth, height );
angle = atan2(((bottomWidth-topWidth)/2), height);
echo (angle);
offset4 = offset3 + bottomDepth + marginbetween;
translate([offset4, 0])
    supports(materialThickness, bottomWidth/2, bottomWidth/2, angle);
offset5 = offset4 + bottomWidth/2 + marginbetween;
translate([offset5, 0])
    supports(materialThickness, topWidth/2, topWidth/2, angle);
