
public class Cube {
	private int size;

	public int[][][] faces;

	public Cube(int size) {
		this.size = size;

		faces = new int[6][size][size];
		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < size; j++) {
				for (int k = 0; k < size; k++) {
					faces[i][j][k] = i;
				}
			}
		}
	}
	
	public Cube(Cube other) {
		this.size = other.size;

		faces = new int[6][size][size];
		for (int i = 0; i < 6; i++) {
			for (int j = 0; j < size; j++) {
				for (int k = 0; k < size; k++) {
					faces[i][j][k] = other.faces[i][j][k];
				}
			}
		}
	}

	public void renderFlat(int x, int y, int rendersize) {
		pushMatrix();
		translate(x, y);
		noStroke();
		float squareSize = (rendersize/4)/size;
		for (int i = 0; i < 6; i++) {
			pushMatrix();
			switch(i) {
				case 0:
					translate(0, 3*rendersize/8);
					break;
				case 1:
					translate(rendersize/4, 3*rendersize/8);
					break;
				case 2:
					translate(2*rendersize/4, 3*rendersize/8);
					break;
				case 3:
					translate(3*rendersize/4, 3*rendersize/8);
					break;
				case 4:
					translate(0, 1*rendersize/8);
					break;
				case 5:
					translate(0, 5*rendersize/8);
					break;
			}
			for (int j = 0; j < size; j++) {
				for (int k = 0; k < size; k++) {
					colorSwitch(faces[i][j][k]);
					rect(j*squareSize + 3, k*squareSize + 3, squareSize - 6, squareSize - 6);

				}
			}
			popMatrix();
		}
		popMatrix();
	}

	public void render3D(int x, int y, int rendersize) {
		pushMatrix();
		translate(x, y);
		noStroke();
		float squaresize = (rendersize/(2*size));
		pushMatrix();
		translate(0, rendersize/4);
		for (int j = 0; j < size; j++) {
			for (int k = 0; k < size; k++) {
				colorSwitch(faces[0][j][k]);
				quad(
					j*squaresize, 				k*squaresize + j*(squaresize/2),
					j*squaresize + squaresize, 	k*squaresize + squaresize/2 + j*(squaresize/2),
					j*squaresize + squaresize, 	k*squaresize + 3*squaresize/2 + j*(squaresize/2),
					j*squaresize, 				k*squaresize + squaresize + j*(squaresize/2));
			}
		}
		popMatrix();

		pushMatrix();
		translate(rendersize/2, rendersize/2);
		for (int j = 0; j < size; j++) {
			for (int k = 0; k < size; k++) {
				colorSwitch(faces[1][j][k]);
				quad(
					j*squaresize, 				k*squaresize - j*(squaresize/2),
					j*squaresize + squaresize, 	k*squaresize - squaresize/2 - j*(squaresize/2),
					j*squaresize + squaresize, 	k*squaresize + squaresize/2 - j*(squaresize/2),
					j*squaresize, 				k*squaresize + squaresize - j*(squaresize/2));
			}
		}
		popMatrix();

		pushMatrix();
		translate(0, rendersize/4);
		for (int j = 0; j < size; j++) {
			for (int k = 0; k < size; k++) {
				colorSwitch(faces[4][j][size-1-k]);
				quad(
					j*squaresize + k*squaresize, 				-k*squaresize/2 + j*(squaresize/2), 
					j*squaresize + k*squaresize + squaresize, 	-k*squaresize/2 - squaresize/2 + j*(squaresize/2),
					j*squaresize + k*squaresize + 2*squaresize, -k*squaresize/2 + j*(squaresize/2),
					j*squaresize + k*squaresize + squaresize, 	-k*squaresize/2 + squaresize/2 + j*(squaresize/2));
			}
		}
		popMatrix();

		popMatrix();
	}

	public void rotateFace(int side, boolean clockwise) {
		int[][] temp = new int[size][size];
		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				temp[i][j] = faces[side][i][j];
			}
		}
		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				if (!clockwise) {
					faces[side][i][j] = temp[size-1-j][i]; 
				} else {
					faces[side][i][j] = temp[j][size-1-i];
				}
			}
		}
	}

	public void rotate(int side, boolean clockwise, int layer, boolean all) {
		// Rotate the face
		if (layer == 0 || all) {
			rotateFace(side, clockwise);
		}
		/**
		 *  4 4
		 *  4 4
		 *  0 0 1 1 2 2 3 3
		 *  0 0 1 1 2 2 3 3
		 *  5 5
		 *  5 5
		 */
		int[] order;
		int[] layer_orient;
		// if side is on top, order[n] is in front
		// The front-top-right contains [order[n]][0][0]
		// Then layer_orient is 0
		switch(side) {
			case 0:
				order = new int[] {1, 5, 3, 4};
				layer_orient = new int[] {0, 3, 2, 1};
				break;
			case 1:
				order = new int[] {2, 5, 0, 4};
				layer_orient = new int[] {0, 2, 2, 2};
				break;
			case 2:
				order = new int[] {3, 5, 1, 4};
				layer_orient = new int[] {0, 1, 2, 3};
				break;
			case 3:
				order = new int[] {0, 5, 2, 4};
				layer_orient = new int[] {0, 0, 2, 0};
				break;
			case 4:
				order = new int[] {1, 0, 3, 2};
				layer_orient = new int[] {3, 3, 3, 3};
				break;
			case 5:
			default:
				order = new int[] {1, 2, 3, 0};
				layer_orient = new int[] {1, 1, 1, 1};
				break;
		}

		int[][] temp = new int[size][size];
			for (int i = 0; i < size; i++) {
				for (int j = 0; j < size; j++) {
					temp[i][j] = faces[order[clockwise ? 3 : 0]][i][j];
				}
			}
		for (int i = 3; i >= 0; i --) {
			if (i == 2) {
				//break;
			}
			int[][] temp2;
			int home_layer = clockwise ? i : 3-i;
			int target_layer = clockwise ? (home_layer+3)%4 : (home_layer+1)%4;
			if (home_layer == (clockwise ? 0 : 3)) {
				temp2 = temp;
			} else {
				temp2 = faces[order[target_layer]];
			}
			for (int j = all ? 0 : layer; j < layer+1; j++) {
				// println("Rotating layer on home face "+order[home_layer]+" to layer on face "+order[target_layer]);
				for (int k = 0; k < size; k++) {
					int home_x, home_y, target_x, target_y;
					switch(layer_orient[home_layer]) {
						case 0:
							home_x = j;
							home_y = k;
							break;
						case 1:
							home_x = k;
							home_y = size-1-j;
							break;
						case 2:
							home_x = size-1-j;
							home_y = size-1-k;
							break;
						case 3:
						default:
							home_x = size-1-k;
							home_y = j;
							break;
					}
					switch(layer_orient[target_layer]) {
						case 0:
							target_x = j;
							target_y = k;
							break;
						case 1:
							target_x = k;
							target_y = size-1-j;
							break;
						case 2:
							target_x = size-1-j;
							target_y = size-1-k;
							break;
						case 3:
						default:
							target_x = size-1-k;
							target_y = j;
							break;
					}
					faces[order[home_layer]][home_x][home_y] = temp2[target_x][target_y];
				}
			}
		}
	}
	public void reorient(int axis, boolean clockwise) {
		switch(axis) {
			case 0:
				rotate(1, clockwise, 0, true);
				rotate(3, !clockwise, size-2, true);
				break;
			case 1:
				rotate(4, clockwise, 0, true);
				rotate(5, !clockwise, size-2, true);
				break;
			case 2:
				rotate(0, clockwise, 0, true);
				rotate(2, !clockwise, size-2, true);
				break;
		}
	}

	void make_move(char action) {
		switch(action) {
		case 'f':
			this.rotate(0, true, 0, true);
			break;
		case 'r':
			this.rotate(1, true, 0, true);
			break;
		case 'b':
			this.rotate(2, true, 0, true);
			break;
		case 'l':
			this.rotate(3, true, 0, true);
			break;
		case 'u':
			this.rotate(4, true, 0, true);
			break;
		case 'd':
			this.rotate(5, true, 0, true);
			break;
		case 'F':
			this.rotate(0, false, 0, true);
			break;
		case 'R':
			this.rotate(1, false, 0, true);
			break;
		case 'B':
			this.rotate(2, false, 0, true);
			break;
		case 'L':
			this.rotate(3, false, 0, true);
			break;
		case 'U':
			this.rotate(4, false, 0, true);
			break;
		case 'D':
			this.rotate(5, false, 0, true);
			break;

		case 'x':
			this.reorient(0, false);
			break;
		case 'y':
			this.reorient(1, false);
			break;
		case 'z':
			this.reorient(2, false);
			break;
		case 'X':
			this.reorient(0, true);
			break;
		case 'Y':
			this.reorient(1, true);
			break;
		case 'Z':
			this.reorient(2, true);
			break;
		}
	}
}

void colorSwitch(int i) {
	switch(i) {
	case 0:
		fill(255, 0, 0);
		break; 
	case 1:
		fill(255, 255, 0);
		break; 
	case 2:
		fill(255, 128, 0);
		break; 
	case 3:
		fill(255, 255, 255);
		break; 
	case 4:
		fill(0, 0, 255);
		break; 
	case 5:
		fill(0, 255, 0);
		break; 
	}
}
