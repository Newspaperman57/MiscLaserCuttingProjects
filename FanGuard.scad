module _fin(dia, thickness) {
	difference() {
		circle(d=dia+thickness*2);
		circle(d=dia);
		translate([-dia, -dia*2])
			square(dia*2);
	}
}

module fanGuard(materialThickness, fanRadius, centerRadius, finRadius, finThickness, fins) {
	difference() {
		circle(d=fanRadius+finThickness*2);
		circle(d=fanRadius);
	}
	circle(d=centerRadius);
	intersection() {
		circle(d=fanRadius);
		for (i=[0:360/fins:360]) {
			rotate(i)
				translate([-finRadius/2-finThickness/2, 0])
					_fin(finRadius, finThickness);
		}
	}
}

fanGuard(3, fanRadius=40, centerRadius=20, finRadius=20, finThickness=2, fins=12);