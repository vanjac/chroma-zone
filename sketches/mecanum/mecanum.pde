int lastKeyPressed = 0; // processing.js doesn't like char's
int lastKeyCodePressed = 0;

float[] inputVelocities;
float[] velocities;

boolean targetPosEnabled = false;
float targetX;
float targetY;
float targetRot;

void setup() {
  size(1280, 768);
  setupRobot();
  
  targetPosEnabled = true;
  targetX = width/2;
  targetY = height/2;
  targetRot = 0;
}

void draw() {
  background(255, 255, 255);
  textAlign(CENTER, TOP);
  textSize(64);
  fill(0);
  text(driveTrain.getDriveTrainName(), width/2, 8);
  textAlign(LEFT, BASELINE);
  
  float maxVelocity = 0.0;
  for(int i = 0; i < driveTrain.numWheels(); i++) {
    if(abs(inputVelocities[i]) > maxVelocity)
      maxVelocity = abs(inputVelocities[i]);
  }
  if(maxVelocity < 1.0)
    maxVelocity = 1.0;
  
  for(int i = 0; i < driveTrain.numWheels(); i++) {
    float target = inputVelocities[i] / maxVelocity;
    if(target != 0.0)
      targetPosEnabled = false;
    
    velocities[i] += (target - velocities[i]) / 10.0;
  }
  
  if(targetPosEnabled) {
    robotX += (targetX - robotX) / 5.0;
    robotY += (targetY - robotY) / 5.0;
    robotRot += (targetRot - robotRot) / 5.0;
  }
  
  drawRobot(robotX, robotY, robotRot, wheelSpins, velocities);
  moveWheels( velocities );
  
  if(!keyPressed)
    for(int i = 0; i < driveTrain.numWheels(); i++)
      inputVelocities[i] = 0.0;
      
  
  textAlign(LEFT, BOTTOM);
  fill(0);
  textSize(20);
  text("Arrows to move, A/D to turn, 1-8 to move individual wheels, T to switch drive trains, R to reset.", 8, height - 8);
  textAlign(RIGHT, BOTTOM);
  text("Jacob van't Hoog", width - 8, height - 8);
  textAlign(LEFT, BASELINE);
}

void keyPressed() {
  if(int(key) == CODED) {
    if(keyCode == lastKeyCodePressed)
      return;
    else
      lastKeyCodePressed = keyCode;
  } else {
    if(key == lastKeyPressed)
      return;
    else
      lastKeyPressed = key;
  }
  
  if(int(key) == CODED) {
    switch(keyCode) {
        case UP:
          addVelocities(driveTrain.forwardWheelSpins());
          break;
        case DOWN:
          subtractVelocities(driveTrain.forwardWheelSpins());
          break;
        case LEFT:
          subtractVelocities(driveTrain.rightWheelSpins());
          break;
        case RIGHT:
          addVelocities(driveTrain.rightWheelSpins());
          break;
      }
  } else {
    switch(key) {
      case 'a':
        subtractVelocities(driveTrain.turnRightWheelSpins());
        break;
      case 'd':
        addVelocities(driveTrain.turnRightWheelSpins());
        break;
      case '1':
        moveWheel(0, 1.0);
        break;
      case '2':
        moveWheel(0, -1.0);
        break;
      case '3':
        moveWheel(1, 1.0);
        break;
      case '4':
        moveWheel(1, -1.0);
        break;
      case '5':
        moveWheel(2, 1.0);
        break;
      case '6':
        moveWheel(2, -1.0);
        break;
      case '7':
        moveWheel(3, 1.0);
        break;
      case '8':
        moveWheel(3, -1.0);
        break;
      
      case 'r':
        robotRot = (robotRot + PI) % (PI*2) - PI;
        targetPosEnabled = true;
        targetX = width/2;
        targetY = height/2;
        targetRot = 0;
        break;
      case 't':
        if(driveTrain instanceof MecanumDriveTrain) {
          setupDriveTrain(new TankDriveTrain());
        } else {
          setupDriveTrain(new MecanumDriveTrain());
        }
        targetX = robotX;
        targetY = robotY;
        targetRot = robotRot + PI*2;
        targetPosEnabled = true;
        break;
    }
  }
}

void keyReleased() {
  lastKeyPressed = 0;
  lastKeyCodePressed = 0;
  
  if(int(key) == CODED) {
    switch(keyCode) {
        case UP:
          subtractVelocities(driveTrain.forwardWheelSpins());
          break;
        case DOWN:
          addVelocities(driveTrain.forwardWheelSpins());
          break;
        case LEFT:
          addVelocities(driveTrain.rightWheelSpins());
          break;
        case RIGHT:
          subtractVelocities(driveTrain.rightWheelSpins());
          break;
      }
  } else {
    switch(key) {
      case 'a':
        addVelocities(driveTrain.turnRightWheelSpins());
        break;
      case 'd':
        subtractVelocities(driveTrain.turnRightWheelSpins());
        break;
      case '1':
        moveWheel(0, -1.0);
        break;
      case '2':
        moveWheel(0, 1.0);
        break;
      case '3':
        moveWheel(1, -1.0);
        break;
      case '4':
        moveWheel(1, 1.0);
        break;
      case '5':
        moveWheel(2, -1.0);
        break;
      case '6':
        moveWheel(2, 1.0);
        break;
      case '7':
        moveWheel(3, -1.0);
        break;
      case '8':
        moveWheel(3, 1.0);
        break;
    }
  }
}

void addVelocities(float[] v) {
  for(int i = 0; i < driveTrain.numWheels(); i++)
    inputVelocities[i] += v[i];
}

void subtractVelocities(float[] v) {
  for(int i = 0; i < driveTrain.numWheels(); i++)
    inputVelocities[i] -= v[i];
}

void moveWheel(int number, float amount) {
  if(number < driveTrain.numWheels())
    inputVelocities[number] += amount;
}