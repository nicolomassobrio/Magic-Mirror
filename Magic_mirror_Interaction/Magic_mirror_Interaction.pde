import processing.opengl.*;
import SimpleOpenNI.*;

// declare our poser objects
SkeletonPoser Hug;
SkeletonPoser Fear;
SkeletonPoser Anger;
SkeletonPoser Disgust;
SkeletonPoser noFeeling;
SkeletonPoser Time;


SimpleOpenNI kinect;


PImage userImage;
PImage resultImage;

int userID;
String t = "";
String q = "";
String q1 = "";
String t1 = "";
int[] userMap;
color c = color(0, 0, 0);
color c1 = color(0, 0, 0);
int widthrect = 0;
int heightrect = 0;

void setup() {
  background(0, 0, 0);
  size(1500, 800, P3D);
  textSize(30);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableRGB();
  kinect.setMirror(true);
  
   // turn on depth/color alignment
  kinect.alternativeViewPointDepthToImage();
  
  //create a buffer image to work with instead of using sketch pixels
  resultImage = new PImage(640, 480);
  
  
  // initialize the pose objects
  Hug = new SkeletonPoser(kinect);
  Fear = new SkeletonPoser(kinect);
  Anger = new SkeletonPoser(kinect);
  Disgust = new SkeletonPoser(kinect);
  noFeeling = new SkeletonPoser(kinect);
  Time = new SkeletonPoser(kinect);
  
 
 
  
  //////////pose noFeeling///////////
  // rules for the right arm
  noFeeling.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  noFeeling.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  // rules for the left arm
  noFeeling.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  noFeeling.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  
  //////////pose Time///////////
  // rules for the right arm
  Time.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Time.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Time.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  Time.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Time.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Time.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Time.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Time.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  
  
  
  //////////pose Hug///////////
  // rules for the right arm
  Hug.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Hug.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Hug.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Hug.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Hug.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Hug.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
    
    
    
    
    //////////pose Fear///////////
  // rules for the right arm
  Fear.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Fear.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Fear.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  Fear.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Fear.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Fear.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Fear.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  
  
  
  
  //////////pose Anger///////////
  // rules for the right arm
  Anger.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Anger.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Anger.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  Anger.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Anger.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Anger.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Anger.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Anger.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  
  
  
  
    //////////pose Disgust///////////
  // rules for the right arm
  Disgust.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Disgust.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Disgust.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  Disgust.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Disgust.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Disgust.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Disgust.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Disgust.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  
  
  
  strokeWeight(0);
}


void draw() {
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  // if we have detected any users
  if (userList.size() > 0)
  {
  
    int userId = userList.get(0);

   if ( kinect.isTrackingSkeleton(userId)) 
   {

    
     
     // check to see if the user
     // is in the pose noFeeling
      if(noFeeling.check(userId))
      {
        c = color(0, 0, 0);
        background(0, 0, 0);
      }
 
     
     // check to see if the user
     // is in the pose Hug
      if(Hug.check(userId))
      {
        c = color(237, 215, 0);
        background(237, 215, 0);
      }
     
     // check to see if the user
     // is in the pose Fear
      if(Fear.check(userId))
      {
        c = color(49,7,90);
        background(49,7, 90);
      }
     
     // check to see if the user
     // is in the pose Anger
      if(Anger.check(userId))
      {
        c = color(255, 0, 0);
        background(255, 0, 0);
      }
     
     // check to see if the user
     // is in the pose Disgust
      if(Disgust.check(userId))
      {
        c = color(172, 194, 149);
        background(172, 194, 149);
      }
     
    
     
     
     
     
   
      ///////////Special poses///////////
   
    
      PVector rightHand = new PVector();
      PVector rightElbow = new PVector();
      PVector rightShoulder = new PVector();
      PVector leftKnee = new PVector();
      PVector rightKnee = new PVector();
      PVector rightFoot = new PVector();
      PVector leftFoot = new PVector();
      PVector leftHand = new PVector();
      PVector leftElbow = new PVector();
      PVector leftShoulder = new PVector();

      
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_HAND,
      leftHand);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_ELBOW,
      leftElbow);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_RIGHT_HAND,
      rightHand);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_RIGHT_ELBOW,
      rightElbow);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_RIGHT_SHOULDER,
      rightShoulder);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_SHOULDER,
      leftShoulder);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_RIGHT_FOOT,
      rightFoot);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_FOOT,
      leftFoot);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_RIGHT_KNEE,
      rightKnee);
      kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_KNEE,
      leftKnee);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_RIGHT_ELBOW,
      SimpleOpenNI.SKEL_RIGHT_SHOULDER);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_LEFT_SHOULDER,
      SimpleOpenNI.SKEL_LEFT_ELBOW);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_RIGHT_KNEE,
      SimpleOpenNI.SKEL_RIGHT_FOOT);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_LEFT_KNEE,
      SimpleOpenNI.SKEL_LEFT_FOOT);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_RIGHT_HAND,
      SimpleOpenNI.SKEL_RIGHT_ELBOW);
      
      kinect.drawLimb(userId,
      SimpleOpenNI.SKEL_LEFT_HAND,
      SimpleOpenNI.SKEL_LEFT_ELBOW);
      
      

      //////////Greeting///////////
      if(rightHand.y > rightElbow.y + 200 && rightShoulder.x < rightElbow.x - 150  
          && rightShoulder.y > rightElbow.y  && leftHand.y < leftElbow.y) 
      {
        q = "Hello, my dear!";
        c = color(255, 165, 0);
        background(255, 165, 0);
      }
      else 
      {
         q = ""; 
      }

  
           
      //////////Time/////////
      if(rightHand.y > rightElbow.y - 150 && rightHand.y < rightElbow.y && rightHand.x < rightElbow.x 
         && rightElbow.x > rightShoulder.x && rightElbow.y < rightShoulder.y)
      {
        t ="It's " + hour() + ":" + minute() + ".";     
      } else{
        t = "";
      }
      
    }
    
    
    
    
    
    
    if(userList.size() > 1){
      
    int userId2 = userList.get(1);
    
      
    if ( kinect.isTrackingSkeleton(userId2)) 
    {
     widthrect = 750;
     heightrect = 800;
     
     
     // check to see if the user
     // is in the pose noFeeling
      if(noFeeling.check(userId2))
      {
        c1 = color(0, 0, 0);
      }
 
     
     // check to see if the user
     // is in the pose Hug
      if(Hug.check(userId2))
      {
        c1 = color(237, 215, 0);
      }
     
     // check to see if the user
     // is in the pose Fear
      if(Fear.check(userId2))
      {
        c1 = color(49,7,90);
      }
     
     // check to see if the user
     // is in the pose Anger
      if(Anger.check(userId2))
      {
        c1 = color(255, 0, 0);
      }
     
     // check to see if the user
     // is in the pose Disgust
      if(Disgust.check(userId2))
      {
        c1 = color(172, 194, 149);
      }
     
    
     
     
     
     
   
      ///////////Special poses///////////
   
    
      PVector rightHand = new PVector();
      PVector rightElbow = new PVector();
      PVector rightShoulder = new PVector();
      PVector leftKnee = new PVector();
      PVector rightKnee = new PVector();
      PVector rightFoot = new PVector();
      PVector leftFoot = new PVector();
      PVector leftHand = new PVector();
      PVector leftElbow = new PVector();
      PVector leftShoulder = new PVector();

      
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_LEFT_HAND,
      leftHand);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_LEFT_ELBOW,
      leftElbow);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_RIGHT_HAND,
      rightHand);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_RIGHT_ELBOW,
      rightElbow);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_RIGHT_SHOULDER,
      rightShoulder);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_LEFT_SHOULDER,
      leftShoulder);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_RIGHT_FOOT,
      rightFoot);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_LEFT_FOOT,
      leftFoot);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_RIGHT_KNEE,
      rightKnee);
      kinect.getJointPositionSkeleton(userId2,
      SimpleOpenNI.SKEL_LEFT_KNEE,
      leftKnee);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_RIGHT_ELBOW,
      SimpleOpenNI.SKEL_RIGHT_SHOULDER);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_LEFT_SHOULDER,
      SimpleOpenNI.SKEL_LEFT_ELBOW);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_RIGHT_KNEE,
      SimpleOpenNI.SKEL_RIGHT_FOOT);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_LEFT_KNEE,
      SimpleOpenNI.SKEL_LEFT_FOOT);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_RIGHT_HAND,
      SimpleOpenNI.SKEL_RIGHT_ELBOW);
      
      kinect.drawLimb(userId2,
      SimpleOpenNI.SKEL_LEFT_HAND,
      SimpleOpenNI.SKEL_LEFT_ELBOW);
      
      

      //////////Greeting///////////
      if(rightHand.y > rightElbow.y + 200 && rightShoulder.x < rightElbow.x - 150  
          && rightShoulder.y > rightElbow.y  && leftHand.y < leftElbow.y) 
      {
        q1 = "Hello, my dear!";
        c1 = color(255, 165, 0);
      }
      else 
      {
         q1 = ""; 
      }

  
           
      //////////Time/////////
      if(rightHand.y > rightElbow.y - 150 && rightHand.y < rightElbow.y && rightHand.x < rightElbow.x 
         && rightElbow.x > rightShoulder.x && rightElbow.y < rightShoulder.y)
      {
        t1 ="It's " + hour() + ":" + minute() + ".";     
      } else{
        t1 = "";
      }
      
    }
             
  }
  else 
  {
    widthrect = 0;
    heightrect = 0;
  }
      
    
    // find out which pixels have users in them
    userMap = kinect.userMap();

    // populate the pixels array from the sketch's current contents
    loadPixels();
  
    for (int i = 0; i < userMap.length; i++) 
    {
      resultImage.pixels[i] = c;
    }
  
  // display the changed pixel array
   resultImage.updatePixels();
   image(resultImage, 1500 / 4, 800 / 3.5);
  }
  
    fill(c1);
    rect(750, 0, widthrect, heightrect);
  
    fill(255, 255, 255);
    textSize(36);
    text("Magic Mirror", 50, 60);
    textSize(28);
    text(t, 50, 150);
    text(q, 50, 150);
    text(q1, 1100, 150);
    text(t1, 1100, 150);
}


void drawSkeleton(int userId) 
{
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD,
  SimpleOpenNI.SKEL_NECK);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_LEFT_ELBOW,
  SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_NECK,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_RIGHT_ELBOW,
  SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_LEFT_SHOULDER,
  SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER,
  SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO,
  SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP,
  SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_LEFT_KNEE,
  SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO,
  SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_RIGHT_HIP,
  SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId,
  SimpleOpenNI.SKEL_RIGHT_KNEE,
  SimpleOpenNI.SKEL_RIGHT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP,
  SimpleOpenNI.SKEL_LEFT_HIP);
}



void drawLimb(int userId, int jointType1, int jointType2)
{
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float confidence;
// draw the joint position
  confidence = kinect.getJointPositionSkeleton(userId, jointType1, jointPos1);
  confidence = kinect.getJointPositionSkeleton(userId, jointType2, jointPos2);
  line(jointPos1.x, jointPos1.y, jointPos1.z, jointPos2.x, jointPos2.y, jointPos2.z);
}



// user-tracking callbacks!
void onNewUser(SimpleOpenNI kinect,int uId) 
{
  userID = userID;
  println("tracking");
  kinect.startTrackingSkeleton(uId);
}


void onLostUser(SimpleOpenNI curContext, int uId)
{
  println("onLostUser - userId: " + uId);
}
