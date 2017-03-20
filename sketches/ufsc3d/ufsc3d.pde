final String[] files = {
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
  "BROTHER.bmp",
  "CLEAN.bmp",
  "DIAGONAL.bmp",
  "DUAL.bmp",
  "FEND.bmp",
  "FOND.bmp",
  "HARVEST_bottom.bmp",
  "HARVEST_top-left.bmp",
  "JALVINSACH.bmp",
  "LEE.bmp",
  "LOCUS.bmp",
  "MOTH_1.bmp",
  "MOTH_2.bmp",
  "MOTH_3.bmp",
  "MOTH_4.bmp",
  "MUL.bmp",
  "POINT.bmp"
};

final boolean LOGGING_ENABLED = false;

final float PAN_STROKE = 4;
final float RENDER_STROKE = 2;
final float FOV = radians(60);

final float FILE_LIST_SIZE = 48;

final String INSTRUCTIONS = "Q to return to main menu\nsee below for controls";

/* STATE */

// settings that are never reset
boolean hsbMode = false;
boolean differenceMode = false;

// image load process
String uiChosenFile;
String path;
boolean loadingMessageDraw;
boolean startedLoading;
PImage img;

// points load process
boolean fileRead;
int pixelRead;
int[][] points;
float minValue, maxValue;
float centerValue, valueRange;

// graph state
boolean mouseWasReleased;
boolean animate;
boolean render;
int animateStep;
float mouseRotateX, mouseRotateY;

void reset() {
  resetPoints();
  
  uiChosenFile = null;
  path = null;
  loadingMessageDraw = false;
  startedLoading = false;
  img = null;
}

void resetPoints() {
  resetGraph();
  
  fileRead = false;
  pixelRead = 0;
  points = null;
  minValue = 127;
  maxValue = 127;
  centerValue = 127;
  valueRange = 0;
}

void resetGraph() {
  clearGraph();
  
  mouseRotateX = 0;
  mouseRotateY = 0;
}

void clearGraph() {
  mouseWasReleased = true;
  animate = false;
  render = false;
  animateStep = 0;
}


void setup() {
  size(1024, 768, P3D);
  
  reset();
}

void keyPressed() {
  if(key == 'r' || key == 'q' || keyCode == ESC)
    reset();
  if(key == 'h') {
    hsbMode = !hsbMode;
    resetPoints();
  }
  if(key == 'd') {
    differenceMode = !differenceMode;
    clearGraph();
  }
  if(key == 'f')
    selectInput("Choose an image file", "chooseFileJava");
  if(key == 'a') {
    if(path != null) {
      clearGraph();
      animate = true;
    }
  }
  if(key == 'z') {
    if(path != null) {
      clearGraph();
      render = true;
      animateStep = -1;
    }
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

void loadFile(String path) {
  img = requestImage(path);
}

boolean fileReady() {
  if(img == null)
    return false;
  return img.width != 0;
}

void readFile() {
  if(pixelRead == 0) {
    img.loadPixels();
    points = new int[img.pixels.length][];
    if(LOGGING_ENABLED)
      println(img.pixels.length, "points");
    
    minValue = 255;
    maxValue = 0;
  }
  int startTime = millis();
  while(millis() - startTime < 100) {
    color pixel = img.pixels[pixelRead];
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
    points[pixelRead] = pointPos;
    
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
    
    pixelRead ++;
    if(pixelRead >= img.pixels.length) {
      //finished
      centerValue = (minValue + maxValue) / 2;
      valueRange = maxValue - minValue;
      if(LOGGING_ENABLED) {
        println("Max:", maxValue);
        println("Min:", minValue);
        println("Center:", centerValue);
        println("Range:", valueRange);
      }
      fileRead = true;
      return;
    }
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
    textSize(24);
    textLeading(24);
    textAlign(LEFT, TOP);
    background(255,255,255);
    text("Choose a file... ("
         + (hsbMode ? "HSB" : "RGB") + " mode, H to switch; "
         + (differenceMode ? "difference" : "absolute") + " mode, D to switch)",
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
    text("Loading composite image...\n(" + INSTRUCTIONS + ")",width/2,height/2);
  } else if(!startedLoading) {
    startedLoading = true;
    loadFile(path);
  } else if(!fileReady()) {
    // wait...
  } else if(!fileRead) {
    readFile();
    
    background(255,255,255);
    textAlign(CENTER, CENTER);
    text("Getting points... (" + int(float(pixelRead)/float(img.pixels.length) * 100.0)
         + "%)\n(" + INSTRUCTIONS + ")",width/2,height/2);
  } else {
    float startTime = millis();
    
    if(render && animateStep == -1) {
      animateStep = 0;
      background(255,255,255);
      fill(0,0,0);
      textAlign(CENTER, CENTER);
      text("Rendering...", width/2, height/2);
      return;
    } else if(render && animateStep == 0) {
      background(255,255,255);
    }
    
    int drawTime;
    
    if(mousePressed) {
      strokeWeight(PAN_STROKE);
      background(255,255,255);
      drawTime = 100;
      animate = false;
      render = false;
    } else {
      strokeWeight(RENDER_STROKE);
      drawTime = 150;
    }
    
    if(mouseWasReleased) {
      mouseWasReleased = false;
      background(255,255,255);
      drawTime = 300;
    }
    
    float aspect = float(width)/float(height);
    perspective(FOV, aspect, 1, width*2);
    
    if(differenceMode)
      translate(width/2, height/2, width/2 - 2*valueRange - 50);
    else
      translate(width/2, height/2, width/2 - valueRange - 50);
    rotateX(-mouseRotateY);
    rotateY(mouseRotateX);
    
    if(hsbMode || animate) {
      colorMode(HSB);
    }
    int i = 0;
    while(true) {
      int pointI;
      if(animate || render)
        pointI = animateStep;
      else
        pointI = int(random(points.length));
      int[] pointPos = points[pointI];
      if(pointPos != null) {
        if(animate)
          stroke(pointI % 255, 255,255);
        else
          stroke(pointPos[0], pointPos[1], pointPos[2]);
        if(!differenceMode) {
          point(pointPos[0] - centerValue, pointPos[1] - centerValue, pointPos[2] - centerValue);
        } else {
          if(pointI != 0) {
            int[] lastPoint = points[pointI - 1];
            if(lastPoint != null)
              point(pointPos[0] - lastPoint[0], pointPos[1] - lastPoint[1], pointPos[2] - lastPoint[2]);
          }
        }
      }
      if(animate || render) {
        animateStep++;
        if(animateStep >= points.length)
          animateStep = points.length - 1;
        if(render) {
          if(animateStep == points.length - 1)
            break;
        } else {
          if(i > points.length/120)
            break;
        }
      } else {
        if(millis() - startTime > drawTime)
          break;
      }
      i++;
    }
    colorMode(RGB);
    
    noFill();
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    if(differenceMode) {
      line(-256,0,0,256,0,0);
      line(0,-256,0,0,256,0);
      line(0,0,-256,0,0,256);
    } else {
      float translateAmount = 127 - centerValue;
      translate(translateAmount, translateAmount, translateAmount);
      box(256);
    }
    popMatrix();
  }
}