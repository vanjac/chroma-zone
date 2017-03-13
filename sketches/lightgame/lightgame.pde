int numSquares = 10;
int squareSize = 30;
boolean flipSelf = false;
color litSquare = color(255, 255, 0);
color cBackground = color(0, 0, 0);
color cStroke = color(255, 255, 255);
LightSquare[][] grid = new LightSquare[squareSize][squareSize];

void setup() {
  size (300, 300);
  background (cBackground);
  for (int x = 0; x < numSquares; x++) {
    for (int y = 0; y < numSquares; y++) {
      grid[x][y] = new LightSquare(x, y);
    }
  }
}

void offSquare(int x, int y) { 
  fill (cBackground);
  stroke (cStroke);
  rect (x * squareSize, y * squareSize, squareSize, squareSize);
}

void onSquare(int x, int y) { 
  fill (litSquare);
  stroke (cStroke);
  ellipseMode (CORNER);
  ellipse (x * squareSize, y * squareSize, squareSize, squareSize);
}

void mouseClicked() {
  grid[int(mouseX / squareSize)][int(mouseY / squareSize)].clicked();
}

void draw() {
}

void keyPressed() {
  if (key == 'r') {
    for (int x = 0; x < numSquares; x++) {
      for (int y = 0; y < numSquares; y++) {
        (grid[x][y]).reset();
      }
    }
  }
}