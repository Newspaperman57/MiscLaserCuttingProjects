module cantor(width, height, margin, depth) {
	square([width, height]);
	if(depth > 0) {
		translate([0, -margin-height]) {
			cantor(width/3, height, margin, depth-1);
		}
		translate([(width/3)*2, -margin-height]) {
			cantor(width/3, height, margin, depth-1);
		}
	}
}