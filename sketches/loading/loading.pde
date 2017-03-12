final float STROKE_WIDTH = 6;
final float NORMAL_RADIUS = 128;
float CIRCLE_RADIUS = 0;
final float ZOOM_TIME = 256;
final float WAIT_TIME = 1000;

float loadAmount = 0;

float stopMillis = -1;

boolean firstDraw = true;

void setup() {
  size(192, 192);
}

void draw() {
  if(firstDraw) {
    firstDraw = false;
    text("Test text", 0, 0);
  }
  
  if(millis() - WAIT_TIME < ZOOM_TIME) {
    CIRCLE_RADIUS = ((float)millis() - WAIT_TIME) / ZOOM_TIME * NORMAL_RADIUS;
  } else {
    CIRCLE_RADIUS = NORMAL_RADIUS;
  }
  
  if(stopMillis == -1) {
    if(loadAmount >= 1) {
      stopMillis = millis();
    }
  } else {
    if(millis() - stopMillis < ZOOM_TIME) {
      CIRCLE_RADIUS = NORMAL_RADIUS - (((float)millis() - stopMillis) / ZOOM_TIME * NORMAL_RADIUS);
    } else {
      CIRCLE_RADIUS = 0;
    }
  }
  
  background(255);
  colorMode(HSB);
  color loadingColor = color(((float)millis() / 96.0) % 256.0, 255, 223);
  loadAmount = ((float)millis() - WAIT_TIME) / 10000.0;
  
  stroke(loadingColor);
  strokeWeight(STROKE_WIDTH);
  noFill();
  arcCircle(width/2, height/2, CIRCLE_RADIUS, (float)millis() / 512.0, (float)millis() / 128.0);
  
  fill(loadingColor);
  noStroke();
  drawLoading(width/2, height/2, CIRCLE_RADIUS - (STROKE_WIDTH / 2), loadAmount);
}

void arcCircle(float xPos, float yPos, float radius, float start, float end) {
  if(radius <= 0)
    return;
  
  float arcLength = (end - start) % (2*TAU);
  
  end = ((end - start) % TAU) + start; //Is this necessary?
  
  if(arcLength <= TAU) {
    arc(xPos, yPos, radius, radius, start, end);
  } else {
    arc(xPos, yPos, radius, radius, end, start + TAU);
  }
}

void drawLoading(float xPos, float yPos, float radius, float amount) { //1 is completely loaded
  if(amount > 1)
    amount = 1;
  if(amount < 0)
    amount = 0;
  
  if(radius > 0)
    arc(xPos, yPos, radius, radius, -HALF_PI, -HALF_PI + (amount * TAU));
  
  if(radius >= 16) {
    fill(0);
    textAlign(CENTER, CENTER);
    text((int)(amount * 100) + "%", xPos, yPos);
  }
}