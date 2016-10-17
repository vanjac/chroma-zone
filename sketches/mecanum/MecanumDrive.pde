// DIMENSIONS
final float mecanumWheelWidth = 36.0;
final float mecanumWheelHeight = 96.0;
final float mecanumRollerSpacing = 27.0;
final float mecanumWheelArrowLength = 80.0;

class MecanumDriveTrain implements DriveTrain {
  final float[] forward = {1.0, -1.0, 1.0, -1.0};
  final float[] right = {1.0, 1.0, -1.0, -1.0};
  final float[] turnRight = {1.0, 1.0, 1.0, 1.0};
  
  @Override
  String getDriveTrainName() {
    return "Mecanum Drive";
  }
  
  @Override
  int numWheels() {
    // front left, front right, back left, back right
    return 4;
  }
  
  @Override
  float[] forwardWheelSpins() {
    return forward;
  }
  
  @Override
  float[] rightWheelSpins() {
    return right;
  }
  
  @Override
  float[] turnRightWheelSpins() {
    return turnRight;
  }
  
  @Override
  PVector getRobotTranslation(float[] velocities) {
    float forwardMovement = (velocities[0] + velocities[2] - velocities[1] - velocities[3]) / sqrt(2.0);
    float rightMovement = (velocities[0] + velocities[1] - velocities[2] - velocities[3]) / sqrt(2.0);
    PVector movement = new PVector(rightMovement, -forwardMovement);
    return movement;
  }
  
  @Override
  float getRobotRotation(float[] velocities) {
    return (velocities[0] + velocities[2] + velocities[1] + velocities[3]) * .006;
  }
  
  @Override
  void drawWheels(float[] wheelSpins, float[] velocities) {
    // front left
    pushMatrix();
    translate(-robotWidth / 2, -robotHeight / 2);
    scale(1, -1);
    drawMecanumWheel(-wheelSpins[0], -velocities[0]);
    popMatrix();
    
    // front right
    pushMatrix();
    translate(robotWidth / 2, -robotHeight / 2);
    drawMecanumWheel(-wheelSpins[1], -velocities[1]);
    popMatrix();
    
    // back left
    pushMatrix();
    translate(-robotWidth / 2, robotHeight / 2);
    drawMecanumWheel(wheelSpins[2], velocities[2]);
    popMatrix();
    
    // back right
    pushMatrix();
    translate(robotWidth / 2, robotHeight / 2);
    scale(1, -1);
    drawMecanumWheel(wheelSpins[3], velocities[3]);
    popMatrix();
  }
}


void drawMecanumWheel(float wheelSpin, float wheelVelocity) {
  wheelSpin *= 2;
  
  rectMode(CENTER);
  imageMode(CENTER);
  strokeWeight(3);
  
  // force vector arrow outline
  stroke(191, 191, 191);
  line(-mecanumWheelArrowLength, -mecanumWheelArrowLength, mecanumWheelArrowLength, mecanumWheelArrowLength);
  
  // force vector arrow
  stroke(255, 0, 0);
  line(0, 0, -wheelVelocity * mecanumWheelArrowLength, -wheelVelocity * mecanumWheelArrowLength);
  float arrowOffset = wheelVelocity > 0 ? 16 : -16;
  line(-wheelVelocity * mecanumWheelArrowLength, -wheelVelocity * mecanumWheelArrowLength,
    -wheelVelocity * mecanumWheelArrowLength, -wheelVelocity * mecanumWheelArrowLength + arrowOffset);
  line(-wheelVelocity * mecanumWheelArrowLength, -wheelVelocity * mecanumWheelArrowLength,
    -wheelVelocity * mecanumWheelArrowLength + arrowOffset, -wheelVelocity * mecanumWheelArrowLength);
  stroke(0, 0, 0);
  
  fill(127, 127, 127);
  
  rect(0, 0, mecanumWheelWidth, mecanumWheelHeight);
  clip(0, 0, mecanumWheelWidth, mecanumWheelHeight);
  float diagY = -mecanumWheelHeight / 2 - (wheelSpin % mecanumRollerSpacing);
  while(diagY < mecanumWheelHeight / 2 + mecanumWheelWidth) {
    line(-mecanumWheelWidth / 2, diagY, mecanumWheelWidth / 2, diagY - mecanumWheelWidth);
    diagY += mecanumRollerSpacing;
  }
  
  noClip();
  strokeWeight(1);
  rectMode(CORNER);
  imageMode(CORNER);
}