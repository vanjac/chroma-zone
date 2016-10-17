// DIMENSIONS
final float tankTreadWidth = 36.0;
final float tankTreadHeight = 256.0;
final float tankTreadLineSpacing = 27.0;

class TankDriveTrain implements DriveTrain {
  final float[] forward = {1.0, -1.0};
  final float[] right = {0.0, 0.0};
  final float[] turnRight = {1.0, 1.0};
  
  
  String getDriveTrainName() {
    return "Tank Drive";
  }
  
  
  int numWheels() {
    // left, right
    return 2;
  }
  
  
  float[] forwardWheelSpins() {
    return forward;
  }
  
  
  float[] rightWheelSpins() {
    return right;
  }
  
  
  float[] turnRightWheelSpins() {
    return turnRight;
  }
  
  
  PVector getRobotTranslation(float[] velocities) {
    float forwardMovement = (velocities[0] - velocities[1]) * 2;
    PVector movement = new PVector(0.0, -forwardMovement);
    return movement;
  }
  
  
  float getRobotRotation(float[] velocities) {
    return (velocities[0] + velocities[1]) * .012;
  }
  
  
  void drawWheels(float[] wheelSpins, float[] velocities) {
    // left
    pushMatrix();
    translate(-robotWidth / 2, 0.0);
    scale(1, -1);
    drawTankTread(-wheelSpins[0]);
    popMatrix();
    
    // right
    pushMatrix();
    translate(robotWidth / 2, 0.0);
    drawTankTread(-wheelSpins[1]);
    popMatrix();
  }
}

void drawTankTread(float spin) {
  spin *= 2;
  
  rectMode(CENTER);
  imageMode(CENTER);
  strokeWeight(3);
  
  fill(127, 127, 127);
  
  rect(0, 0, tankTreadWidth, tankTreadHeight);
  clip(0, 0, tankTreadWidth, tankTreadHeight);
  float diagY = -tankTreadHeight / 2 - (spin % tankTreadLineSpacing);
  while(diagY < tankTreadHeight / 2 + tankTreadWidth) {
    line(-tankTreadWidth / 2, diagY, tankTreadWidth / 2, diagY - tankTreadWidth);
    diagY += tankTreadLineSpacing;
  }
  
  noClip();
  strokeWeight(1);
  rectMode(CORNER);
  imageMode(CORNER);
}