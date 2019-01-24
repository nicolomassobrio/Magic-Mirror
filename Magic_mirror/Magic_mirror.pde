import processing.opengl.*;
import SimpleOpenNI.*;
// import and declarations for minim:
import ddf.minim.*;

// declare our poser objects
SkeletonPoser pose;
SkeletonPoser Hug;
SkeletonPoser Fear;
SkeletonPoser Anger;
SkeletonPoser Disgust;
SkeletonPoser Stopmusic;
SkeletonPoser noFeeling;
SkeletonPoser Time;

Minim minim;
AudioPlayer player;
AudioPlayer player2;
AudioPlayer player3;
SimpleOpenNI kinect;


PImage userImage;
PImage resultImage;

int userID;
String t = "";
String q = "";
int[] userMap;
color c = color(0, 0, 0);

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
  
  // initialize the minim object
  minim = new Minim(this);
  
  // and load the stayin alive mp3 file
  player2 = minim.loadFile("Bohemian Rhapsody.mp3");
  player = minim.loadFile("Staying Alive.mp3");
  
  // initialize the pose objects
  pose = new SkeletonPoser(kinect);
  Hug = new SkeletonPoser(kinect);
  Fear = new SkeletonPoser(kinect);
  Anger = new SkeletonPoser(kinect);
  Stopmusic = new SkeletonPoser(kinect);
  Disgust = new SkeletonPoser(kinect);
  noFeeling = new SkeletonPoser(kinect);
  Time = new SkeletonPoser(kinect);
  
  ////////////pose Staying Alive///////////
   // rules for the right arm
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  pose.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  
  // rules for the right leg
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_KNEE,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_HIP);
  pose.addRule(SimpleOpenNI.SKEL_RIGHT_KNEE,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_HIP);
  
  // rules for the left leg
  pose.addRule(SimpleOpenNI.SKEL_LEFT_KNEE,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_HIP);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_KNEE,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_HIP);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_FOOT,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_LEFT_KNEE);
  pose.addRule(SimpleOpenNI.SKEL_LEFT_FOOT,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_KNEE);
  
  
  
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
  
  
  
  
  //////////pose Stopmusic///////////
  // rules for the right arm
  Stopmusic.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Stopmusic.addRule(SimpleOpenNI.SKEL_RIGHT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_ELBOW);
  Stopmusic.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  Stopmusic.addRule(SimpleOpenNI.SKEL_RIGHT_ELBOW,
  PoseRule.BELOW,
  SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  
  // rules for the left arm
  Stopmusic.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.LEFT_OF,
  SimpleOpenNI.SKEL_LEFT_SHOULDER);
  Stopmusic.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.RIGHT_OF,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Stopmusic.addRule(SimpleOpenNI.SKEL_LEFT_HAND,
  PoseRule.ABOVE,
  SimpleOpenNI.SKEL_LEFT_ELBOW);
  Stopmusic.addRule(SimpleOpenNI.SKEL_LEFT_ELBOW,
  PoseRule.ABOVE,
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
     // is in the pose
     if(pose.check(userId))
     {
       
       // start the song playing
       if(!player2.isPlaying()) 
       {
          if(!player.isPlaying()) 
          {
            player.play();

          }
       } 
     }
     
     // check to see if the user
     // is in the pose noFeeling
      if(noFeeling.check(userId))
      {
        c = color(0, 0, 0);
        background(0, 0, 0);
      }
     
     
     //// check to see if the user
     //// is in the pose noFeeling
     // if(Time.check(userId))
     // {
     //    fill(255, 0, 0);
     //    textSize(30);
     //    t = hour() + ":" + minute();
     //    c = color(0, 0, 0);
     //    background(0, 0, 0);
     // }
     // else{
     //  t = "";
     //  }
     
     
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
     
     // check to see if the user
     // is in the pose Stopmusic
      if(Stopmusic.check(userId))
      {
          if(player.isPlaying()) 
          {
            fill(255, 255, 255);
            textSize(28);
            text("Music in Pause mode", 50, 150);
            player.pause();
          }
          else{
          }
          if(player2.isPlaying())
          {
            fill(255, 255, 255);
            textSize(28);
            text("Music in Pause mode", 50, 150);
            player2.pause();
          }
          else{
          }
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
        q = "Hello, are you all right?";
        c = color(255, 165, 0);
        background(255, 165, 0);
      }
      else 
      {
         q = ""; 
      }



      //////////Freddie/////////
      if(rightHand.y > rightElbow.y && rightHand.x > rightElbow.x - 60 
         && rightHand.x < rightElbow.x + 60 && rightElbow.y > rightShoulder.y 
         && rightFoot.x > rightKnee.x && leftFoot.x < leftKnee.x)
      {
         // start the song playing
         if(!player.isPlaying()){
           if(!player2.isPlaying()) 
           {
              q = "Bohemian Rhapsody - Queen";
              player2.play();
           } 
           else {
              q = "";  
           }
         }
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
    
    // find out which pixels have users in them
    userMap = kinect.userMap();

    // populate the pixels array from the sketch's current contents
    loadPixels();
  
    for (int i = 0; i < userMap.length; i++) 
    {
      // if the current pixel is on a user
      if (userMap[i] != 0) 
      {
      // make it white
      resultImage.pixels[i] = color(255, 255, 255);
      }
      else {
        //set it to the background
        resultImage.pixels[i] = c;
      }
    }
  
  // display the changed pixel array
   resultImage.updatePixels();
   image(resultImage, 1500 / 4, 800 / 3.5);
  }
  
    fill(255, 255, 255);
    textSize(36);
    text("Magic Mirror", 50, 60);
    textSize(28);
    text(t, 50, 150);
    text(q, 50, 150);
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
void onNewUser(SimpleOpenNI kinect,int userId) 
{
  userID = userID;
  println("tracking");
  kinect.startTrackingSkeleton(userId);
}


void onLostUser(SimpleOpenNI curContext, int uId)
{
  println("onLostUser - userId: " + uId);
}
