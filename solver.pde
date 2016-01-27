
final int[][][] edge_list = {
	{{5, 1, 0}, {0, 1, 2}}, {{5, 2, 1}, {1, 1, 2}}, {{5, 1, 2}, {2, 1, 2}}, {{5, 0, 1}, {3, 1, 2}}, 
	{{0, 2, 1}, {1, 0, 1}}, {{1, 2, 1}, {2, 0, 1}}, {{2, 2, 1}, {3, 0, 1}}, {{3, 2, 1}, {0, 0, 1}}, 
	{{4, 1, 2}, {0, 1, 0}}, {{4, 2, 1}, {1, 1, 0}}, {{4, 1, 0}, {2, 1, 0}}, {{4, 0, 1}, {3, 1, 0}}
};


final int[][][] corner_list = {
	{{5, 0, 0}, {3, 2, 2}, {0, 0, 2}},
	{{5, 2, 0}, {0, 2, 2}, {1, 0, 2}},
	{{5, 2, 2}, {1, 2, 2}, {2, 0, 2}},
	{{5, 0, 2}, {2, 2, 2}, {3, 0, 2}}, 
	{{4, 2, 0}, {2, 0, 0}, {1, 2, 0}},  
	{{4, 2, 2}, {1, 0, 0}, {0, 2, 0}},  
	{{4, 0, 2}, {0, 0, 0}, {3, 2, 0}},  
	{{4, 0, 0}, {3, 0, 0}, {2, 2, 0}}
};

final String[][] c_algorithms = {
	{"", "FdRD"}, {"rdRD", "rf"}, {"bDDBDD", "bdrD"}, {"lDLd", "LF"},
	{"dRD", "f"}, {"ddBdd", "drD"}, {"DLd", "DDbDD"}, {"F", "Dld"},
	{"ff", "fdRD"}, {"dRRD", "uFDld"}, {"ddbbDD", "uufdRD"}, {"DLLd", "UfdRD"}
};

final String[][][][] f_algorithms = {
	{
		{ // 00
			{"", ""}, 
			{"", ""}, 
			{"", ""}, 
			{"", ""}
		},
		{ // 01
			{"", ""}, 
			{"", ""}, 
			{"", ""}, 
			{"", ""}
		},
		{ // 02
			{"", ""}, 
			{"", ""}, 
			{"", ""}, 
			{"", ""}
		}
	}, 
	{
		{ // 10
			{"urURUrURurUR", "FuufuFUf"}, 
			{"rUURUruR", "uFLulfruR"}, 
			{"urUURRfrF", "FLUUlf"}, 
			{"rbUUBR", "UFuuffRFr"}
		},
		{ // 11
			{"Ruurrurrur", "UFuf"}, 
			{"UrURuruR", "rURuuFUf"}, 
			{"ruR", "uFUUfuuFuf"}, 
			{"UruRuruR", "RRbuBUrr"}
		},
		{ // 12
			{"uRfrFuruR", "rURuRfrFrUR"},
			{"urUR", "ufRFrfRFrUruR"},
			{"ffLUluFF", "uFUfUFUf"}, 
			{"rubUUBuR", "FUf"}
		}
	}
};

public class Solver3 {
	private Cube cube;
	public Solver3(Cube othercube) {
		this.cube = new Cube(othercube);
	}

	int solve() {
		/**
		 * CFOP
		 */
		// C
		for (int i = 0; i < 4; i++) {
			int downColor = this.cube.faces[5][1][1];
			int frontColor = this.cube.faces[0][1][1];
			int[] edge = find_edge(downColor, frontColor);
			//println("Edge state "+edge[0]+" "+edge[1]);
			//println("Executing "+c_algorithms[edge[0]][edge[1]]);
			make_sequence(c_algorithms[edge[0]][edge[1]]);
			make_sequence("y");
		}
		// F
		for (int i = 0; i < 4; i++) {
			int downColor = this.cube.faces[5][1][1];
			int frontColor = this.cube.faces[0][1][1];
			int rightColor = this.cube.faces[1][1][1];
			
			int[] corner = find_corner(downColor, frontColor, rightColor);
			// println("Corner state "+corner[0]+" "+corner[1]);
			switch(corner[0]) {
			case 0:
				make_sequence("druRDU");
				break;
			case 1:
				make_sequence("ruRU");
				break;
			case 2:
				make_sequence("DruRdU");
				break;
			case 3:
				make_sequence("ddruRddU");
				break;
			case 4:
				make_sequence("u");
				break;
			case 5:
				make_sequence("");
				break;
			case 6:
				make_sequence("U");
				break;
			case 7:
				make_sequence("uu");
				break;
			}
			
			int[] edge = find_edge(frontColor, rightColor);
			// println("Edge state "+edge[0]+" "+edge[1]);
			switch(edge[0]) {
			case 4:
				make_sequence("Fufuu"); // Lol
				break;
			case 5:
				make_sequence("buBU");
				break;
			case 6:
				make_sequence("BubU");
				break;
			case 7:
				make_sequence("LUlu"); // Lol
				break;
			}
			corner = find_corner(downColor, frontColor, rightColor);
			edge = find_edge(frontColor, rightColor);
			//println("Corner state "+(corner[0]-4)+" "+corner[1]);
			//println("Edge state "+(edge[0]-8)+" "+edge[1]);
			make_sequence(f_algorithms[corner[0]-4][corner[1]][edge[0]-8][edge[1]]);
			make_sequence("y");
		}
		// O
		for (int i = 0; i < 1; i++) {
			int topColor = this.cube.faces[4][1][1];
			int top = 0;
			if (this.cube.faces[4][1][2] == topColor) {
				top += 1;
			}
			if (this.cube.faces[4][2][1] == topColor) {
				top += 10;
			}
			if (this.cube.faces[4][1][0] == topColor) {
				top += 100;
			}
			if (this.cube.faces[4][0][1] == topColor) {
				top += 1000;
			}
			if (top == 1010) {
				make_sequence("fruRUF");
			} else if (top == 101) {
				make_sequence("yfruRUF");
			} else if (top == 1100) {
				make_sequence("furURF");
			} else if (top == 110) {
				make_sequence("yfurURF");
			} else if (top == 11) {
				make_sequence("yyfurURF");
			} else if (top == 1001) {
				make_sequence("YfurURF");
			} else if (top == 0) {
				make_sequence("furURFyfruRUF");
			}
		}
		// O part 2
		for (int i = 0; i < 1; i++) {
			int topColor = this.cube.faces[4][1][1];
			int top = 0;
			if (this.cube.faces[4][0][2] == topColor) {
				top += 1;
			}
			if (this.cube.faces[4][2][2] == topColor) {
				top += 10;
			}
			if (this.cube.faces[4][2][0] == topColor) {
				top += 100;
			}
			if (this.cube.faces[4][0][0] == topColor) {
				top += 1000;
			}
			if (top == 0000) {
				int headlight_face = -1;
				boolean doubleHeadlights = false;
				for (int j = 0; j < 4; j++) {
					if (this.cube.faces[j][0][0] == topColor &&
						this.cube.faces[j][2][0] == topColor) {
						if (headlight_face != -1) {
							doubleHeadlights = true;
						}
						headlight_face = j;
					}
				}
				if (!doubleHeadlights) {
					switch(headlight_face) {
					case 0:
						make_sequence("Y");
						break;
					case 1:
						make_sequence("yy");
						break;
					case 2:
						make_sequence("y");
						break;
					case 3:
						make_sequence("");
						break;
					}
					make_sequence("ruRuruuR");
					make_sequence("UruRuruuR");
				} else {
					switch(headlight_face) {
					case 0:
						make_sequence("Y");
						break;
					case 1:
						make_sequence("");
						break;
					case 2:
						make_sequence("y");
						break;
					case 3:
						make_sequence("");
						break;
					}
					make_sequence("ruRurURurUUR");
				}
			} else if (top == 1) {
				make_sequence("U");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("LUlULUUl");
				} else {
					make_sequence("uruRuruuR");
				}
			} else if (top == 10) {
				make_sequence("");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("LUlULUUl");
				} else {
					make_sequence("uruRuruuR");
				}
			} else if (top == 100) {
				make_sequence("u");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("LUlULUUl");
				} else {
					make_sequence("uruRuruuR");
				}
			} else if (top == 1000) {
				make_sequence("uu");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("LUlULUUl");
				} else {
					make_sequence("uruRuruuR");
				}
			} else if (top == 101) {
				if (this.cube.faces[0][2][0] == topColor) {
					make_sequence("u");
				} else  {
					make_sequence("U");	
				}
				make_sequence("RFLfrFlf");
			} else if (top == 1010) {
				make_sequence("u");
				if (this.cube.faces[0][2][0] == topColor) {
					make_sequence("u");
				} else  {
					make_sequence("U");	
				}
				make_sequence("RFLfrFlf");
			} else if (top == 1100) {
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("uurrDruuRdruur");
				} else {
					make_sequence("urURfruRURFrrURuurUR");
				}
			} else if (top == 110) {
				make_sequence("U");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("uurrDruuRdruur");
				} else {
					make_sequence("urURfruRURFrrURuurUR");
				}
			} else if (top == 11) {
				make_sequence("uu");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("uurrDruuRdruur");
				} else {
					make_sequence("urURfruRURFrrURuurUR");
				}
			} else if (top == 1001) {
				make_sequence("u");
				if (this.cube.faces[0][0][0] == topColor) {
					make_sequence("uurrDruuRdruur");
				} else {
					make_sequence("urURfruRURFrrURuurUR");
				}
			}
		}
		// P
		for (int i = 0; i < 1; i++) {
			int frontColor = this.cube.faces[0][1][1];
			int upColor = this.cube.faces[4][1][1];
			int rightColor = this.cube.faces[1][1][1];
			int backColor = this.cube.faces[2][1][1];
			int leftColor = this.cube.faces[3][1][1];
			
			int[] corner1 = find_corner(frontColor, upColor, rightColor);
			corner1[0] -= 4;
			//println("Corner 1 "+corner1[0]);
			switch(corner1[0]) {
			case 0:
				make_sequence("u");
				break;
			case 1:
				make_sequence("u");
			case 2:
				make_sequence("U");
				break;
			case 3:
				make_sequence("uu");
				break;
			}

			int[] corner2 = find_corner(leftColor, upColor, frontColor);
			int[] corner0 = find_corner(rightColor, upColor, backColor);
			int[] corner3 = find_corner(backColor, upColor, leftColor);
			corner0[0] -= 4;
			corner2[0] -= 4;
			corner3[0] -= 4;
			//println("Corners 0 2 3 "+corner0[0]+" "+corner2[0]+" "+corner3[0]);
			if (corner0[0] == 0) {
				if (corner2[0] == 2) {
					//println("Ready for part 2");
				} else {
					//println("Ja Permutation 1");
					make_sequence("BuFuubUBuufbU");
				}
			} else {
				if (corner2[0] == 2) {
					//println("Ja Permutation 2");
					make_sequence("UBuFuubUBuufb");
				} else {
					if (corner3[0] == 3) {
						//println("Na Permutation");
						make_sequence("lUruuLuRlUruuLuRU");
					} else {
						if (corner0[0] == 2) {
							//println("Gc Permutation");
							make_sequence("UrruRuRUrUrrdURurD");
							//make_sequence("uuLUlulUFLULulfUluuLuu");
						} else {
							//println("Ga Permutation");
							make_sequence("UrruRuRUrUrrdURurD");
							make_sequence("URUrbbdLulUlDbbu");
						}
					}
				}
			}

		}
		// P part 2

		for (int i = 0; i < 2; i++) {
			int upColor = this.cube.faces[4][1][1];
			int frontColor = this.cube.faces[0][1][1];
			int rightColor = this.cube.faces[1][1][1];
			int backColor = this.cube.faces[2][1][1];
			int leftColor = this.cube.faces[3][1][1];
			int[][] edges = {
				find_edge(upColor, frontColor), 
				find_edge(upColor, rightColor),
				find_edge(upColor, backColor),
				find_edge(upColor, leftColor)
			};
			
			edges[0][0] -= 8;
			edges[1][0] -= 8;
			edges[2][0] -= 8;
			edges[3][0] -= 8;

			int num_correct = 0;
			int correct_spot = -1;
			for (int j = 0; j < 4; j++) {
				if (edges[j][0] == j) {
					num_correct += 1;
					correct_spot = j;
				}
			}
			if (num_correct == 0) {
				println("No corners");
				make_sequence("rrURUrururUr");
			} else if (num_correct == 1) {
				println("One corners");
				switch(correct_spot) {
				case 0:
					break;
				case 1:
					make_sequence("u");
					break;
				case 2:
					make_sequence("uu");
					break;
				case 3:
					make_sequence("U");
					break;
				}
				if (this.cube.faces[2][0][0] == 
					this.cube.faces[1][1][0]) {
					println("ccw");
					make_sequence("rrURUrururUr");
				} else {
					println("cw");
					make_sequence("RuRURURururr");
				}
				switch(correct_spot) {
				case 0:
					break;
				case 1:
					make_sequence("U");
					break;
				case 2:
					make_sequence("UU");
					break;
				case 3:
					make_sequence("u");
					break;
				}
			} else {
				return 0;
			}
		}
		return 0;
	}

	int[] find_edge(int x, int y) {
		for (int i = 0; i < 12; i ++) {
			if (
				this.cube.faces[edge_list[i][0][0]][edge_list[i][0][1]][edge_list[i][0][2]] == x &&
				this.cube.faces[edge_list[i][1][0]][edge_list[i][1][1]][edge_list[i][1][2]] == y
				) {
				return new int[] {i, 0};
			} else if (
				this.cube.faces[edge_list[i][0][0]][edge_list[i][0][1]][edge_list[i][0][2]] == y &&
				this.cube.faces[edge_list[i][1][0]][edge_list[i][1][1]][edge_list[i][1][2]] == x
				) {
				return new int[] {i, 1};
			}
		}
		println("Edge state not found");
		return new int[] {0, 0};
	}
	
	int[] find_corner(int x, int y, int z) {
		for (int i = 0; i < 8; i ++) {
			if (
				this.cube.faces[corner_list[i][0][0]][corner_list[i][0][1]][corner_list[i][0][2]] == x &&
				this.cube.faces[corner_list[i][1][0]][corner_list[i][1][1]][corner_list[i][1][2]] == y &&
				this.cube.faces[corner_list[i][2][0]][corner_list[i][2][1]][corner_list[i][2][2]] == z
				) {
				return new int[] {i, 0};
			} else if (
				this.cube.faces[corner_list[i][0][0]][corner_list[i][0][1]][corner_list[i][0][2]] == z &&
				this.cube.faces[corner_list[i][1][0]][corner_list[i][1][1]][corner_list[i][1][2]] == x &&
				this.cube.faces[corner_list[i][2][0]][corner_list[i][2][1]][corner_list[i][2][2]] == y
				) {
				return new int[] {i, 1};
			} else if (
				this.cube.faces[corner_list[i][0][0]][corner_list[i][0][1]][corner_list[i][0][2]] == y &&
				this.cube.faces[corner_list[i][1][0]][corner_list[i][1][1]][corner_list[i][1][2]] == z &&
				this.cube.faces[corner_list[i][2][0]][corner_list[i][2][1]][corner_list[i][2][2]] == x
				) {
				return new int[] {i, 2};
			}
		}
		println("Corner state not found");
		return new int[] {0, 0};
	}

	void make_sequence(String sequence) {
		actionQueue += sequence;
		for (int i = 0; i < sequence.length(); i++) {
			make_move(sequence.charAt(i));
		}
	}

	void make_move(char action) {
		switch(action) {
		case 'f':
			this.cube.rotate(0, true, 0, true);
			break;
		case 'r':
			this.cube.rotate(1, true, 0, true);
			break;
		case 'b':
			this.cube.rotate(2, true, 0, true);
			break;
		case 'l':
			this.cube.rotate(3, true, 0, true);
			break;
		case 'u':
			this.cube.rotate(4, true, 0, true);
			break;
		case 'd':
			this.cube.rotate(5, true, 0, true);
			break;
		case 'F':
			this.cube.rotate(0, false, 0, true);
			break;
		case 'R':
			this.cube.rotate(1, false, 0, true);
			break;
		case 'B':
			this.cube.rotate(2, false, 0, true);
			break;
		case 'L':
			this.cube.rotate(3, false, 0, true);
			break;
		case 'U':
			this.cube.rotate(4, false, 0, true);
			break;
		case 'D':
			this.cube.rotate(5, false, 0, true);
			break;

		case 'x':
			this.cube.reorient(0, false);
			break;
		case 'y':
			this.cube.reorient(1, false);
			break;
		case 'z':
			this.cube.reorient(2, false);
			break;
		case 'X':
			this.cube.reorient(0, true);
			break;
		case 'Y':
			this.cube.reorient(1, true);
			break;
		case 'Z':
			this.cube.reorient(2, true);
			break;
		}
	}


}

