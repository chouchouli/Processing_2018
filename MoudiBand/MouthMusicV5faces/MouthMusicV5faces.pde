// Adapted from -
// Processing 3.0x template for receiving raw points from
// Kyle McDonald's FaceOSC v.1.1 
// https://github.com/kylemcdonald/ofxFaceTracker
//
// for Thesis 1 project - Moudi Band version 5 - Parsons, Design and Technology
// Adapted by Yasong Li (Chouchou)
// https://github.com/chouchouli/Processing_2018/tree/master/MoudiBand/MouthMusicV5faces



import processing.sound.*;
int NUM = 4;
PrintWriter output;
PrintWriter [] dataOutput = new PrintWriter[NUM];
int mark=0;
int Blink=0;


import oscP5.*;
Sound s;
OscP5 oscP5;
SoundFile eyeSmall;
SoundFile eyeBig;
SoundFile smile;
SoundFile mouthBig;
SoundFile c;
SoundFile d;
SoundFile e;
SoundFile g;
SoundFile f;



int found;
float[] rawArray;
float[] newPoint;
int highlighted; //which point is selected

float centerX;
float centerY;

float mouthFreq=0;
float mouthData=0;
float mouthPre=0;

float lEyeFreq=0;
float lEyeData=0;
float lEyePre=0;

float noseFreq=0;
float noseData=0;

float mouthClosed=0;
float mouthOuterDist;
float mouthOuterDistNorm;


//--------------------------------------------
void setup() {
  size(1920, 1080);
  frameRate(80);

  rawArray = new float[132]; 
  newPoint = new float[80];
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "rawData", "/raw");

  s = new Sound(this);
  smile= new SoundFile(this, "laugh1.wav");
  eyeSmall = new SoundFile(this, "drum.wav");
  eyeBig = new SoundFile(this, "bass.wav");
  mouthBig = new SoundFile(this, "funk.wav");

  c = new SoundFile(this, "c.wav");
  d = new SoundFile(this, "d.wav");
  e = new SoundFile(this, "e.wav");
  g = new SoundFile(this, "g.wav");
  f = new SoundFile(this, "f.wav");

  mouthClosed = dist(rawArray[102], rawArray[103], rawArray[114], rawArray[115]);
  println("mC", mouthClosed);
}

//--------------------------------------------
void draw() {  
  fill(Blink*20%255,Blink*20%255,Blink*20%255, 30);
  rect(0, 0, width, height);
  noStroke();

  if (found != 0) {
    // addPoint();
    lipPoint();
    drawPoints();
    makeMouthFile();
    makeLeftEyeFile();
    //drawFacePolygons(); //outline of face
  }
}

//upout-102/103
//downout - 114/115
//upin -122/123
//downin - 128/129


void makeMouthFile() {
  centerX= (rawArray[120]+ rawArray[126])/2;
  centerY= (rawArray[121]+ rawArray[127])/2;
  mouthFreq= dist(centerX, centerY, rawArray[120], rawArray[126]);
  mouthOuterDist = dist(rawArray[102], rawArray[103], rawArray[114], rawArray[115]);
  mouthOuterDistNorm = mouthOuterDist/mouthClosed;
  println("norm", mouthOuterDistNorm);

  if (mouthOuterDistNorm<=1.2) {
    println(0);
    mark=0;
  } else  if (mouthOuterDistNorm<=1.6) {
    if (c.isPlaying()==false) {
      c.cue(0.3);
      c.play(2);
      mark=1;
      println("c played");
    }
  } else  if (mouthOuterDistNorm<=2.0) {
    if (d.isPlaying()==false) {
      d.cue(0.3);
      d.play(2);
      mark=2;
      //d.loop();
      println("d played");
    }
  } else if (mouthOuterDistNorm<=2.4) {
    if (e.isPlaying()==false) {
      e.cue(0.3);
      e.play(2);
      mark=3;
      //e.loop();
      println("e played");
    }
  } else if (mouthOuterDistNorm<=2.8) {
    if (f.isPlaying()==false) {
      f.cue(0.3);
      f.play(2);
      mark=4;
      //e.loop();
      println("f played");
    }
  } else {
    if (g.isPlaying()==false) {
      g.cue(0.3);
      g.play(2);
      mark=5;

      //e.loop();
      println("f played");
    }
  }
  mouthPre = mouthFreq;
}


void makeLeftEyeFile() {
  lEyeFreq = dist(rawArray[72], rawArray[73], rawArray[86], rawArray[87]);
  if ((lEyePre-lEyeFreq)>=1.2) {
    lEyeData=1;
    Blink++;
    //println("Blink");
    //println(lEyeFreq + "----"+ lEyePre);
    eyeBig.cue(0.4);
    eyeBig.amp(0.7);
    eyeBig.play();
  }
  if (lEyePre-lEyeFreq<=-1) {
    eyeSmall.cue(1.48);
    eyeSmall.amp(0.1);
    // eyeSmall.play();
  }

  lEyePre = lEyeFreq;
  lEyeData=0;
}

//---------------------------------------------makesound based on circle large

//---------------------------------------------addlip

void lipPoint() {
  int i=0;
  int j;

  //upper lip
  for (j=96; j<132; i++, j++) {
    newPoint[i]= rawArray[j];
  }
}

//--------------------------------------------draw add-points
void drawPoints() {
  fill(255, 0, 0);
  for (int t=0; t<64; t+=2) {
    switch (mark) {
    case 1:
      fill(255, 30, 50);
      break;
    case 2:
      fill(210, 30, 50);
      break;
    case 3:
      fill(170, 30, 50);
      break;
    case 4:
      fill(110, 30, 50);
      break;
    case 5:
      fill(70, 30, 50);
      break;
    }
    noStroke();
    //ellipse(newPoint[t], newPoint[t+1], 70, 70);
    ellipse(newPoint[t]*6%width+30, newPoint[t+1]*3%height-30, 140, 140);
    ellipse(newPoint[t]*8%width+50, newPoint[t+1]*4%height-70, 140, 140);
    ellipse(newPoint[t]*8%width+300, newPoint[t+1]*4%height-100, 140, 140);
  }
}


//--------------------------------------------
public void found(int i) {
  found = i;
}
public void rawData(float[] raw) {
  rawArray = raw; // stash data in array
}



void keyPressed() {
  //exit(); // Stops the program
}

//--------------------------------------------
void drawFacePolygons() {
  noFill(); 
  stroke(100); 

  // Face outline
  beginShape();
  for (int i=0; i<34; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  for (int i=52; i>32; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);

  // Eyes
  beginShape();
  for (int i=72; i<84; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  beginShape();
  for (int i=84; i<96; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);

  // Upper lip
  beginShape();
  for (int i=96; i<110; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  for (int i=124; i>118; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);

  // Lower lip
  beginShape();
  for (int i=108; i<120; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  vertex(rawArray[96], rawArray[97]);
  for (int i=130; i>124; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);

  // Nose bridge
  beginShape();
  for (int i=54; i<62; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape();

  // Nose bottom
  beginShape();
  for (int i=62; i<72; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape();
}
