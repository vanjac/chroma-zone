final boolean LOGGING_ENABLED = false;

final float PAN_STROKE = 4;
final float RENDER_STROKE = 2;

int[][] points;
float minValue, maxValue;
float centerValue, valueRange;

// sequence:
boolean firstDraw;
String path;
boolean loadingMessageDraw;
boolean startedLoading;
PImage img;
boolean fileRead;

boolean mouseWasReleased;
float mouseRotateX, mouseRotateY;

boolean drawImage;


void setup() {
  size(1024, 768, P3D);
  
  reset();
}

void keyPressed() {
  if(key == 'r')
    reset();
  if(key == 'i' && img != null)
    drawImage = true;
  if(key == '1')
    chooseFile("BREADTH_composite.bmp");
  if(key == '2')
    chooseFile("JALVINSACH_composite.bmp");
  if(key == '3')
    chooseFile("LOCUS0_1080.bmp");
  if(key == '4')
    chooseFile("BRILLN_composite.bmp");
  if(key == '5')
    chooseFile("574016_composite.bmp");
  if(key == '6')
    chooseFile("HARVEST_composite_tl.bmp");
  if(key == '7')
    chooseFile("HARVEST_composite_b.bmp");
  if(key == '8')
    chooseFile("MUL_composite.bmp");
  if(key == '9')
    chooseFile("LEE_composite.bmp");
  if(key == '0')
    chooseFile("POINT_composite.bmp");
  if(key == '-')
    chooseFile("MOTH_composite.bmp");
}

void chooseFile(String filePath) {
  if(path != null)
    reset();
  path = filePath;
}

void reset() {
  points = null;
  
  firstDraw = false;
  path = null;
  loadingMessageDraw = false;
  startedLoading = false;
  img = null;
  fileRead = false;
  
  mouseWasReleased = true;
  
  mouseRotateX = 0;
  mouseRotateY = 0;
  
  minValue = 0;
  maxValue = 0;
  
  drawImage = false;
}

void loadFile(String path) {
  img = requestImage(path);
}

boolean fileReady() {
  if(img == null)
    return false;
  return img.width != 0;
}

void readFile() {
  img.loadPixels();
  points = new int[img.pixels.length][];
  if(LOGGING_ENABLED)
    println(img.pixels.length, "points");
  
  minValue = 255;
  maxValue = 0;
  for(int i = 0; i < img.pixels.length; i++) {
    color pixel = img.pixels[i];
    int[] pointPos = new int[3];
    pointPos[0] = int(red(pixel));
    pointPos[1] = int(green(pixel));
    pointPos[2] = int(blue(pixel));
    points[i] = pointPos;
    
    if(pointPos[0] > maxValue)
      maxValue = pointPos[0];
    if(pointPos[1] > maxValue)
      maxValue = pointPos[1];
    if(pointPos[2] > maxValue)
      maxValue = pointPos[2];
    if(pointPos[0] < minValue)
      minValue = pointPos[0];
    if(pointPos[1] < minValue)
      minValue = pointPos[1];
    if(pointPos[2] < minValue)
      minValue = pointPos[2];
  }
  if(LOGGING_ENABLED) {
    println("Max:", maxValue);
    println("Min:", minValue);
  }
  centerValue = (minValue + maxValue) / 2;
  valueRange = maxValue - minValue;
}

void mouseDragged() {
  mouseRotateX += radians(mouseX - pmouseX) / 2;
  mouseRotateY += radians(mouseY - pmouseY) / 3;
}

void mouseReleased() {
  mouseWasReleased = true;
}

void draw() {
  if(!firstDraw) {
    firstDraw = true;
    
    strokeWeight(RENDER_STROKE);
    fill(0,0,0);
    textSize(48);
    
    textAlign(LEFT, CENTER);
    background(255,255,255);
    text("Type a number...\n" +
         "1: BREADTH\n" +
         "2: JALVINSACH\n" +
         "3: LOCUS\n" +
         "4: N* BRILL\n" +
         "5: 574016\n" +
         "6: HARVEST (top left frame)\n" +
         "7: HARVEST (bottom frame)\n" +
         "8: MUL\n" +
         "9: LEE\n" +
         "0: POINT (still in progress)\n" +
         "-: MOTH (still in progress)",
         32,height/2);
  } else if(path == null) {
    // wait...
  } else if (!loadingMessageDraw) {
    loadingMessageDraw = true;
    
    background(255,255,255);
    textAlign(CENTER, CENTER);
    text("Loading!\n(click and drag to rotate)\n(R to go to main menu)",width/2,height/2);
  } else if(!startedLoading) {
    startedLoading = true;
    loadFile(path);
  } else if(!fileReady()) {
    // wait...
  } else if(!fileRead) {
    fileRead = true;
    readFile();
  } else {
    float startTime = millis();
    
    if(drawImage) {
      background(255,255,255);
      image(img, 0, 0);
      if(mousePressed)
        drawImage = false;
      return;
    }
    
    int drawTime;
    
    if(mousePressed) {
      strokeWeight(PAN_STROKE);
      background(255,255,255);
      drawTime = 100;
    } else {
      strokeWeight(RENDER_STROKE);
      drawTime = 150;
    }
    
    if(mouseWasReleased) {
      mouseWasReleased = false;
      background(255,255,255);
      drawTime = 300;
    }
    
    float fov = radians(60);
    float aspect = float(width)/float(height);
    perspective(fov, aspect, 1, width*2);
    
    translate(width/2, height/2, width/2 - valueRange - 50);
    rotateX(-mouseRotateY);
    rotateY(mouseRotateX);
    
    int i = 0;
    while(millis() - startTime < drawTime) {
      int[] pointPos = points[int(random(points.length))];
      if(pointPos != null) {
        stroke(pointPos[0], pointPos[1], pointPos[2]);
        point(pointPos[0] - centerValue, pointPos[1] - centerValue, pointPos[2] - centerValue);
      }
      i++;
    }
    
    noFill();
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(centerValue - 127, centerValue - 127, centerValue - 127);
    box(256);
    popMatrix();
  }
}
