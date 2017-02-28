byte OTHER = 0;
byte HORIZ = 1;
byte VERT = 2;


float wallHeight = 256;
//player pos is negative
float playerX = -100;
float playerY = -100;
float xVel, yVel;
float playerRot = PI;

float walkSpeed = 100;
float playerWidth = 24;

boolean mouseWasPressed = false;
boolean gameStarted = false;


int mazeXLen = 12;
int mazeYLen = 12;
boolean[][] spaces = new boolean[mazeXLen][mazeYLen];
int filledSpaces = 0;
float mazeWallLen = 256;

PImage floorTexture;

class Wall {
   float x1, y1, x2, y2;
   byte direction;
   color c;
   Wall(float x1, float y1, float x2, float y2, color c) {
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      direction = OTHER;
      if(x1 == x2)
      direction = VERT;
      if(y1 == y2)
      direction = HORIZ;
      this.c = c;
   }
   
   Wall(float x1, float y1, float x2, float y2) {
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      direction = OTHER;
      if(x1 == x2)
      direction = VERT;
      if(y1 == y2)
      direction = HORIZ;
      c = color(255,255,255);
   }
   
   boolean collision(float x, float y) {
      x = -x;
      y = -y;
      if(direction == HORIZ) {
         return abs(y - y1) < playerWidth && inRange(x, x1, x2, playerWidth);
      }
      if(direction == VERT) {
         return abs(x - x1) < playerWidth && inRange(y, y1, y2, playerWidth);
      }
      return false;
   }
   
}

ArrayList<Wall> walls;


void setup() {
   size(960, 640, P3D);
   smooth();
   walls = new ArrayList<Wall>();
   makeMaze();
   floorTexture = makeCheckerboard(32,32,color(0),color(255));
}

void draw() {
   background(95, 191, 255 );
   for(int i = 0; i < 1000; i++)
      mazeStep();
   
   if(mousePressed) {
      gameStarted = true;
      if(mouseWasPressed) {
         playerRot -= radians(mouseX-pmouseX) / 2;
      }
      else {
         mouseWasPressed = true;
      }
      xVel = 0;
      yVel = 0;
   }
   else {
      mouseWasPressed = false;
      xVel = cos(playerRot)*walkSpeed/frameRate;
      yVel = sin(playerRot)*walkSpeed/frameRate;
   }
   
   if(gameStarted) {
      playerX += xVel;
      playerY += yVel;
      
      for(int i = 0; i < walls.size(); i++) {
         Wall w = walls.get(i);
         if(w.collision(playerX, playerY)) {
            playerX -= xVel;
            playerY -= yVel;
            break;
         }
      }
   }
   
   cameraPoint(playerX, playerY, playerRot);
   for(int i = 0; i < walls.size(); i++) {
      Wall w = walls.get(i);
      wall(w.x1, w.y1, w.x2, w.y2, w.c); 
   }
   
   fill(255,127,0);
   float xMax = mazeWallLen*mazeXLen;
   float yMax = mazeWallLen*mazeYLen;
   beginShape(QUADS);
   //textureWrap(REPEAT);
   //if(floorTexture!=null)
   //texture(floorTexture);
   vertex(0,wallHeight/2,0,0,0);
   vertex(xMax,wallHeight/2,0,xMax,0);
   vertex(xMax,wallHeight/2,yMax,xMax,yMax);
   vertex(0,wallHeight/2,yMax,0,yMax);
   endShape();
}


void cameraPoint(float x, float y, float rotation) {
   float cameraY = height/2.0;
   float fov = radians(95);
   float cameraZ = cameraY / tan(fov / 2.0);
   float aspect = float(width) / float(height);
   resetMatrix();
   beginCamera();
   perspective(fov, aspect, cameraZ/50.0, cameraZ*100);
   translate(-x,0,-y);
   rotateY(-rotation + PI/2);
   endCamera();
}

void wall(float x1, float y1, float x2, float y2, color c) {
   strokeWeight(2);
   stroke(0);
   fill(c);
   beginShape(QUADS);
   vertex(x1, -wallHeight/2, y1);
   vertex(x1, wallHeight/2, y1);
   vertex(x2, wallHeight/2, y2);
   vertex(x2, -wallHeight/2, y2);
   endShape();
}

void addWall(float x1, float y1, float x2, float y2) {
   walls.add(new Wall(x1, y1, x2, y2));
}

void addWall(float x1, float y1, float x2, float y2, color c) {
   walls.add(new Wall(x1, y1, x2, y2, c));
}

boolean inRange(float n, float r1, float r2, float maxDist) {
   if(r1 > r2) {
      float temp = r1;
      r1 = r2;
      r2 = temp;
   }
   return n > r1-maxDist && n < r2+maxDist;
}



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
   addWall(0,0,xWallLoc,0,color(255,0,0));
   addWall(0,0,0,yWallLoc,color(255,255,0));
   addWall(xWallLoc,yWallLoc,xWallLoc,0,color(0,255,0));
   addWall(xWallLoc,yWallLoc,0,yWallLoc,color(0,0,255));
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
   int xMove=0, yMove=0;
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



PImage makeCheckerboard(int w, int h, color c1, color c2) {
   PGraphics image = createGraphics(w, h);
   image.beginDraw();
   image.loadPixels();
   for(int i = 0; i < w*h; i++) {
      boolean filled = (i % w) < (w / 2);
      if(i >= (w*h/2))
      filled = !filled;
      image.pixels[i] = filled ? c1 : c2; 
   }
   image.updatePixels();
   image.endDraw();
   return image;
}
