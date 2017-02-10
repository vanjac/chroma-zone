final boolean LOGGING_ENABLED = false;

final float PAN_STROKE = 4;
final float RENDER_STROKE = 2;

final float FILE_LIST_SIZE = 48;

int[][] points;
float minValue, maxValue;
float centerValue, valueRange;

boolean hsbMode;

// sequence:
String uiChosenFile;
String path;
boolean loadingMessageDraw;
boolean startedLoading;
PImage img;
boolean fileRead;

boolean mouseWasReleased;
float mouseRotateX, mouseRotateY;

boolean animate = false;
int animateStep = 0;

boolean drawImage;

String[] files = {
  "Numbered.bmp",
  "574016.bmp",
  "BREADTH.bmp",
  "BREADTH_top.bmp",
  "BREADTH_middle.bmp",
  "BREADTH_bottom.bmp",
  "BRILL.bmp",
  "BRILL_49999.bmp",
  "BRILL_N.bmp",
  "BRINE.bmp",
  "FEND.bmp",
  "FOND.bmp",
  "HARVEST_bottom.bmp",
  "HARVEST_top-left.bmp",
  "JALVINSACH.bmp",
  "LEE.bmp",
  "LOCUS.bmp",
  "MUL.bmp",
  "POINT.bmp"
};


void setup() {
  size(1024, 768, P3D);
  
  reset();
}

void keyPressed() {
  if(key == 'r' || key == 'q' || keyCode == ESC)
    reset();
  if(key == 'h') {
    hsbMode = !hsbMode;
    chooseFile(path);
  }
  if(key == 'i' && img != null)
    drawImage = true;
  if(key == 'f')
    selectInput("Choose an image file", "chooseFileJava");
  if(key == 'a') {
    animate = true;
    animateStep = 0;
  }
}

void chooseFileJava(File f) {
  if(f == null)
    return;
  uiChosenFile = f.toString();
}

void chooseFile(String filePath) {
  if(path != null)
    reset();
  path = filePath;
}

void reset() {
  points = null;
  
  minValue = 127;
  maxValue = 127;
  centerValue = 127;
  valueRange = 0;
  
  uiChosenFile = null;
  path = null;
  loadingMessageDraw = false;
  startedLoading = false;
  img = null;
  fileRead = false;
  
  mouseWasReleased = true;
  
  mouseRotateX = 0;
  mouseRotateY = 0;
  
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
    if(hsbMode) {
      pointPos[0] = int(hue(pixel));
      pointPos[1] = int(saturation(pixel));
      pointPos[2] = int(brightness(pixel));
    } else {
      pointPos[0] = int(red(pixel));
      pointPos[1] = int(green(pixel));
      pointPos[2] = int(blue(pixel));
    }
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
  centerValue = (minValue + maxValue) / 2;
  valueRange = maxValue - minValue;
  if(LOGGING_ENABLED) {
    println("Max:", maxValue);
    println("Min:", minValue);
    println("Center:", centerValue);
    println("Range:", valueRange);
  }
}

void mouseDragged() {
  mouseRotateX += radians(mouseX - pmouseX) / 2;
  mouseRotateY += radians(mouseY - pmouseY) / 3;
}

void mouseReleased() {
  mouseWasReleased = true;
}

void draw() {
  if(uiChosenFile != null) {
    println("Chose a file...");
    chooseFile(uiChosenFile);
    uiChosenFile = null;
  }
  
  if(path == null) {
    fill(0,0,0);
    textSize(32);
    textLeading(32);
    textAlign(LEFT, TOP);
    background(255,255,255);
    text("Choose a file... (mode: "
         + (hsbMode ? "HSB" : "RGB") + ", press H to switch)\n",
         16, 0);
    
    textSize(24);
    textLeading(24);
    textAlign(LEFT, CENTER);
    noFill();
    strokeWeight(4);
    float leftX = 0;
    float top = FILE_LIST_SIZE * 1.5;
    for(int i = 0; i < files.length; i++) {
      String filePath = files[i];
      stroke(0);
      rect(leftX, top, width/2, FILE_LIST_SIZE);
      noStroke();
      text(filePath.substring(0, filePath.length() - 4), leftX + 16, top + FILE_LIST_SIZE/2);
      
      if(mousePressed
         && mouseY > top && mouseY < top + FILE_LIST_SIZE
         && mouseX > leftX && mouseX < leftX + width/2)
        chooseFile(filePath);
      
      top += FILE_LIST_SIZE;
      if(top + FILE_LIST_SIZE > height) {
        top = FILE_LIST_SIZE * 1.5;
        leftX += width/2;
      }
    }
  } else if (!loadingMessageDraw) {
    loadingMessageDraw = true;
    
    background(255,255,255);
    textAlign(CENTER, CENTER);
    text("Loading!\n(click and drag to rotate)\n(A to enable Animate Mode)\n(R to go to main menu)",width/2,height/2);
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
      if(animate)
        drawTime = 100;
      else
        drawTime = 150;
    }
    
    if(mouseWasReleased) {
      mouseWasReleased = false;
      background(255,255,255);
      if(animate)
        animateStep = 0;
      else
        drawTime = 300;
    }
    
    float fov = radians(60);
    float aspect = float(width)/float(height);
    perspective(fov, aspect, 1, width*2);
    
    translate(width/2, height/2, width/2 - valueRange - 50);
    rotateX(-mouseRotateY);
    rotateY(mouseRotateX);
    
    if(hsbMode) {
      colorMode(HSB);
    }
    while(millis() - startTime < drawTime) {
      int[] pointPos;
      if(animate && !mousePressed)
        pointPos = points[animateStep];
      else
        pointPos = points[int(random(points.length))];
      if(pointPos != null) {
        stroke(pointPos[0], pointPos[1], pointPos[2]);
        point(pointPos[0] - centerValue, pointPos[1] - centerValue, pointPos[2] - centerValue);
      }
      if(animate && !mousePressed) {
        animateStep++;
        if(animateStep >= points.length)
          animateStep = points.length - 1;
      }
    }
    colorMode(RGB);
    
    noFill();
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    float translateAmount = 127 - centerValue;
    translate(translateAmount, translateAmount, translateAmount);
    box(256);
    popMatrix();
  }
}
