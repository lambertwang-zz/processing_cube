
Cube globalcube;
Solver3 globalsolver;

String actionQueue;

void setup() {
	frameRate(60);
	size(512, 512);
	smooth();

	globalcube = new Cube(3);

	actionQueue = "";
}


void draw() {
	
	background(128);

	if (actionQueue.length() > 0) {
		globalcube.make_move(actionQueue.charAt(0));
		actionQueue = actionQueue.substring(1);
	}

	globalcube.renderFlat(0, 0, width);
	globalcube.render3D(width/4, 0, 3*height/8);

}

int layer;

void keyPressed() {
	switch(key) {
		case 'f':
			globalcube.rotate(0, true, layer, true);
			break;
		case 'r':
			globalcube.rotate(1, true, layer, true);
			break;
		case 'b':
			globalcube.rotate(2, true, layer, true);
			break;
		case 'l':
			globalcube.rotate(3, true, layer, true);
			break;
		case 'u':
			globalcube.rotate(4, true, layer, true);
			break;
		case 'd':
			globalcube.rotate(5, true, layer, true);
			break;
		case 'F':
			globalcube.rotate(0, false, layer, true);
			break;
		case 'R':
			globalcube.rotate(1, false, layer, true);
			break;
		case 'B':
			globalcube.rotate(2, false, layer, true);
			break;
		case 'L':
			globalcube.rotate(3, false, layer, true);
			break;
		case 'U':
			globalcube.rotate(4, false, layer, true);
			break;
		case 'D':
			globalcube.rotate(5, false, layer, true);
			break;
		case 'x':
			globalcube.reorient(0, true);
			break;
		case 'y':
			globalcube.reorient(1, true);
			break;
		case 'z':
			globalcube.reorient(2, true);
			break;
		case 'X':
			globalcube.reorient(0, false);
			break;
		case 'Y':
			globalcube.reorient(1, false);
			break;
		case 'Z':
			globalcube.reorient(2, false);
			break;
		case 's':
			globalsolver = new Solver3(globalcube);
			globalsolver.solve();
			break;
		case 'S':
			String actions = "udlrfbUDLRFBxyz";
			for (int i = 0; i < 60; i++) {
				actionQueue += actions.charAt(int(random(actions.length())));
			}
			break;
	}
}
