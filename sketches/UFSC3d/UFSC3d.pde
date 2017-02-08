final boolean CHOOSE_FILE = false;

final float PAN_STROKE = 4;
final float RENDER_STROKE = 2;

int[][] points = null;

boolean firstDraw = true;
String path = null;
boolean startedLoading = false;
boolean doneLoading = false;

boolean mouseWasReleased = true;

float mouseRotateX, mouseRotateY;

float maxValue;

void setup() {
  size(1024, 768, P3D);
  
  background(255,255,255);
  strokeWeight(RENDER_STROKE);
  fill(0,0,0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("Loading!\n(click and drag to pan)",width/2,height/2);
  
  loadPoints();
}

void loadPoints() {
  if(CHOOSE_FILE)
    selectInput("Choose a CSV file", "fileChosen");
  else
    path = "breadthcsv.csv";
}

void fileChosen(File f) {
  if(f != null) {
    path = f.toString();
  }
}

void readFile(String path) {
  String[] lines = loadStrings(path);
  points = new int[lines.length][];
  //println(lines.length, "points");
  
  for(int i = 0; i < lines.length; i++) {
    String line = lines[i];
    String values[] = line.split(",");
    if(values.length < 3) {
      //println(i, "Error:", line);
      continue;
    }
    int[] pointPos = new int[3];
    pointPos[0] = int(values[0]) - 64;
    pointPos[1] = int(values[1]) - 64;
    pointPos[2] = int(values[2]) - 64;
    points[i] = pointPos;
    
    if(pointPos[0] > maxValue)
      maxValue = pointPos[0];
    if(pointPos[1] > maxValue)
      maxValue = pointPos[1];
    if(pointPos[2] > maxValue)
      maxValue = pointPos[2];
  }
  doneLoading = true;
  //println("Max:", maxValue);
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
  }
  if(path != null && !startedLoading) {
    startedLoading = true;
    readFile(path);
  }
  if(doneLoading) {
    float startTime = millis();
    
    int drawTime = 50;
    
    if(mouseWasReleased) {
      mouseWasReleased = false;
      background(255,255,255);
      strokeWeight(RENDER_STROKE);
      drawTime = 150;
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