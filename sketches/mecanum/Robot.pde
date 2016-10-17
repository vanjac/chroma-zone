// robot state
float robotX;
float robotY;
float robotRot;
float[] wheelSpins;

DriveTrain driveTrain;

interface DriveTrain {
  String getDriveTrainName();
  
  int numWheels();
  float[] forwardWheelSpins();
  float[] rightWheelSpins();
  float[] turnRightWheelSpins();
  
  void drawWheels(float[] wheelSpins, float[] wheelVelocities);
  PVector getRobotTranslation(float[] velocities);
  float getRobotRotation(float[] velocities);
}

void setupRobot() {
  setupDriveTrain(new MecanumDriveTrain());
  
  robotX = width/2;
  robotY = height + robotHeight;
  robotRot = 0;
}

void setupDriveTrain(DriveTrain d) {
  driveTrain = d;
  inputVelocities = new float[driveTrain.numWheels()];
  velocities = new float[driveTrain.numWheels()];
  wheelSpins = new float[driveTrain.numWheels()];
}

void moveWheels(float[] velocities) {
  for(int i = 0; i < driveTrain.numWheels(); i++)
    wheelSpins[i] += velocities[i];
  
  float rotation = driveTrain.getRobotRotation(velocities);
  robotRot += rotation;
  
  PVector movement = driveTrain.getRobotTranslation(velocities);
  movement.rotate(robotRot);
  robotX += movement.x;
  robotY += movement.y;
}