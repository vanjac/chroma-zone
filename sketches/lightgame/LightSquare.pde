class LightSquare {
  int xPos;
  int yPos;
  boolean litState;
  LightSquare (int x, int y) {
    xPos = x;
    yPos = y;
    litState = false;
    offSquare (xPos, yPos);
  }
  
  void clicked() {
    if (xPos != 0) {
      (grid[xPos - 1][yPos]).flip();
    }
    if (yPos != 0) {
      (grid[xPos][yPos - 1]).flip();
    }
    if (xPos != numSquares - 1) {
      (grid[xPos + 1][yPos]).flip();
    }
    if (yPos != numSquares - 1) {
      (grid[xPos][yPos + 1]).flip();
    }
    if (flipSelf) {
      this.flip();
    }
  }
  
  void flip() {
    if (litState) {
      litState = false;
      offSquare (xPos, yPos);
    } else {
      litState = true;
      onSquare (xPos, yPos);
    }
  }
  
  void reset() {
    litState = false;
    offSquare (xPos, yPos);
  }
}