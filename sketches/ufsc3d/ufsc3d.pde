final boolean CHOOSE_FILE = false;

final float PAN_STROKE = 4;
final float RENDER_STROKE = 2;

PImage img;
int[][] points = null;

boolean firstDraw = true;
String path = null;
boolean startedLoading = false;
boolean startedReading = false;
boolean doneReading = false;

boolean mouseWasReleased = true;

float mouseRotateX, mouseRotateY;

float minValue, maxValue;

void setup() {
  size(1024, 768, P3D);
  
  background(255,255,255);
  strokeWeight(RENDER_STROKE);
  fill(0,0,0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("Loading!\n(click and drag to rotate)",width/2,height/2);
  
  chooseFile();
}

void chooseFile() {
  if(CHOOSE_FILE)
    selectInput("Choose an image file", "fileChosen");
  else
    path = "BREADTH_composite.png";
}

void fileChosen(File f) {
  if(f != null) {
    path = f.toString();
  }
}

void loadFile(String path) {
  img = loadImage(path);
}

boolean fileReady() {
  if(img == null)
    return false;
  return img.width != 0;
}

void readFile() {
  img.loadPixels();
  points = new int[img.pixels.length][];
  println(img.pixels.length, "points");
  
  for(int i = 0; i < img.pixels.length; i++) {
    color pixel = img.pixels[i];
    int[] pointPos = new int[3];
    pointPos[0] = pixel >> 16 & 0xFF; // red
    pointPos[1] = pixel >> 8 & 0xFF; // green
    pointPos[2] = pixel & 0xFF; // blue
    points[i] = pointPos;
    
    if(pointPos[0] > maxValue)
      maxValue = pointPos[0];
    if(pointPos[1] > maxValue)
      maxValue = pointPos[1];
    if(pointPos[2] > maxValue)
      maxValue = pointPos[2];
  }
  println("Max:", maxValue);
  doneReading = true;
}

void mouseDragged() {
  mouseRotateX += radians(mouseX - pmouseX);
  mouseRotateY += radians(mouseY - pmouseY);
}

void mouseReleased() {
  mouseWasReleased = true;
}

void draw() {
  if(firstDraw) {
    firstDraw = false;
    return;
  } else if(path != null && !startedLoading) {
    startedLoading = true;
    loadFile(path);
  } else if(fileReady() && !startedReading) {
    startedReading = true;
    readFile();
  } else if(doneReading) {
    float startTime = millis();
    
    int drawTime = 50;
    
    if(mouseWasReleased) {
      mouseWasReleased = false;
      background(255,255,255);
      strokeWeight(RENDER_STROKE);
      drawTime = 250;
    } else if(mousePressed) {
      background(255,255,255);
      strokeWeight(PAN_STROKE);
    }
    
    float fov = radians(60);
    float aspect = float(width)/float(height);
    perspective(fov, aspect, 1, width*2);
    
    translate(width/2, height/2, width/2 - maxValue - 50);
    rotateX(-mouseRotateY);
    rotateY(mouseRotateX);
    
    int i = 0;
    while(millis() - startTime < drawTime) {
      int[] pointPos = points[int(random(points.length))];
      if(pointPos != null) {
        stroke(pointPos[0], pointPos[1], pointPos[2]);
        point(pointPos[0] - maxValue/2, pointPos[1] - maxValue/2, pointPos[2] - maxValue/2);
      }
      i++;
    }
  }
}
