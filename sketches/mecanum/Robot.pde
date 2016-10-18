// robot state
float robotX;
float robotY;
float robotRot;
float[] wheelSpins;

DriveTrain driveTrain;

// generic interface for a drive train that can be controlled by the user
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

// move the wheels and the robot based on wheel velocities
void moveWheels(float[] velocities) {
  for(int i = 0; i < driveTrain.numWheels(); i++)
    wheelSpins[i] += velocities[i];
  
  float rotation = driveTrain.getRobotRotation(velocities);
  robotRot += rotation / 2.0;
  
  PVector movement = driveTrain.getRobotTranslation(velocities);
  movement.rotate(robotRot);
  robotX += movement.x / 2.0;
  robotY += movement.y / 2.0;
}