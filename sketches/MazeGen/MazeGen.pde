void setup() {
   size(640, 640);
   background(0,0,0);
   strokeWeight(2);
   makeMaze();
}

void draw() {
   for(int i = 0; i < 1000; i++)
      mazeStep();
}

int mazeXLen = 53;
int mazeYLen = 53;
boolean[][] spaces = new boolean[mazeXLen][mazeYLen];
int filledSpaces = 0;
float mazeWallLen = 12;


void makeMaze() {
   for(int y = 0; y < mazeYLen; y++) {
      for(int x = 0; x < mazeXLen; x++) {
         spaces[x][y] = false;
      }
   }
   
   for(int x = 0; x < mazeXLen; x++) {
      spaces[x][0] = true;
      spaces[x][mazeYLen-1] = true;
      filledSpaces+=2;
   }
   for(int y = 1; y < mazeYLen-1; y++) {
      spaces[0][y] = true;
      spaces[mazeXLen-1][y] = true;
      filledSpaces+=2;
   }
   float xWallLoc = (mazeXLen-1)*mazeWallLen;
   float yWallLoc = (mazeYLen-1)*mazeWallLen;
   addWall(0,0,xWallLoc,0);
   addWall(0,0,0,yWallLoc);
   addWall(xWallLoc,yWallLoc,xWallLoc,0);
   addWall(xWallLoc,yWallLoc,0,yWallLoc);
}

void mazeStep() { 
   if(filledSpaces == mazeXLen*mazeYLen)
   return;
   int x;
   int y;
   while(true) {
      x = floor(random(mazeXLen));
      y = floor(random(mazeYLen));
      if(spaces[x][y])
      break;
   }
   
   int direction = floor(random(4));
   int xMove = 0, yMove = 0;
   if(direction == 0) {
      xMove = 1;
      yMove = 0;
   }
   if(direction == 1) {
      xMove = 0;
      yMove = 1;
   }
   if(direction == 2) {
      xMove = -1;
      yMove = 0;
   }
   if(direction == 3) {
      xMove = 0;
      yMove = -1;
   }
   if(x+xMove >= mazeXLen || y+yMove >= mazeYLen || x+xMove < 0 || y+yMove < 0)
   return;
   if(!spaces[x+xMove][y+yMove]) {
      spaces[x+xMove][y+yMove] = true;
      filledSpaces++;
      addWall(x*mazeWallLen,y*mazeWallLen,(x+xMove)*mazeWallLen,(y+yMove)*mazeWallLen);
   }
   
}

void addWall(float x1, float y1, float x2, float y2) {
   colorMode(HSB, 2.0);
   stroke(x1 / width + y1 / height, 2.0, 2.0);
   line(x1,y1,x2,y2);
}