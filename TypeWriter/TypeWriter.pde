import processing.sound.*;
SoundFile keyboard;

PGraphics pg;

//int wholeNUM=1000;
int NUM = 640000;
PVector [] mousePos = new PVector [NUM];
PVector CMP;
PVector CenterP;
PVector HorizantalLine;
PVector angledVector;
int num=0;
boolean mouseClkMk= false;
int mouseClk=0;

float [] charStroke = new float [NUM];
float [] charAngle = new float [NUM] ;

float drawCharAngle;
float drawCharStroke;
PVector drawCharPos;

PImage typewriter;
PVector typeStart;
int charNum=0;
//alphabet

PImage a;
PImage s;
PImage d;
PImage f;
PImage g;
PImage h;
PImage j;
PImage l;

PImage e;
PImage o;

PImage c;





void setup() {

  frameRate(30);
  size(1600, 2400, P2D);
  //size(800,800, P2D);
  background(255, 204, 0);

  pg = createGraphics(1600, 2400);
  keyboard = new SoundFile(this, "keyboard.wav");

  CMP = new PVector();
  CenterP = new PVector(805, 1330);
  HorizantalLine = new PVector(10, 0);
  angledVector = new PVector();
  drawCharPos = new PVector(805, 1330);

  typeStart = new PVector(100, -140);

  charAngle[0]=0;
  charAngle[1]=0;

  for (int i=0; i<NUM; i++) {
    mousePos[i] = new PVector();
  }

  typewriter= loadImage("typewriter.png");
  drawBack();
}


void draw() {
  println(mouseX, mouseY);
  CMP.set(mouseX, mouseY);
  if (mouseClk==0) {
    reset();
    drawTrackingPt();
  }
  if (mouseClk==1) {
    drawSavedPt();
    num=0;
  }
}

void drawTrackingPt() {
  if (mouseX!=0&&mouseY!=0) {
    if (CMP.dist(CenterP)<=250) {
      mousePos[num].x = CMP.x;
      mousePos[num].y = CMP.y;

      charStroke[num] = CMP.dist(CenterP);

      angledVector.x = CMP.x- CenterP.x;
      angledVector.y = CMP.y - CenterP.y;          //charStroke[] storee the stroke

      if (CMP.y>=CenterP.y) {
        charAngle[num] = -1*PVector.angleBetween(HorizantalLine, angledVector);
      } else {
        charAngle[num] = PVector.angleBetween(HorizantalLine, angledVector);        //charAngle[] stored the angle data
      }
      fill(255, 255, 0);
      //rect(CenterP.x, CenterP.y, 5, 5);
      rect(CMP.x, CMP.y, 5, 5); 
      num++;
    }
  }
}


void mouseClicked() {
  if (mouseX>=500 && mouseX<=1080 && mouseY>=1950 && mouseY<=2000) {
    //test
    mouseClk = 1;
    println("test");
    keyboard.play();
  }
  //----------------------------------------------------------------------------line2
  if (mouseX>=400 && mouseX<=500 && mouseY>=1800 && mouseY<=1840) {
    println("s");
    keyboard.play();
    pg.save("s.png");
  }
  if (mouseX>=520 && mouseX<=600 && mouseY>=1800 && mouseY<=1840) {
    println("d");
    keyboard.play();
    pg.save("d.png");
  }
   if (mouseX>=626 && mouseX<=713 && mouseY>=1800 && mouseY<=1840) {
    println("f");
    keyboard.play();
    pg.save("f.png");
  }
  if (mouseX>=1200 && mouseX<=1800 && mouseY>=1800 && mouseY<=1840) {
    println("l");
    keyboard.play();
    pg.save("l.png");
  }
  
  //---------------------------------------------------------------------------line 1
  if (mouseX>=1084 && mouseX<=1720 && mouseY>=1725 && mouseY<=1760) {
    println("o");
    keyboard.play();
    pg.save("o.png");
  }
    if (mouseX>=505 && mouseX<=582 && mouseY>=1725 && mouseY<=1760) {
    println("e");
    keyboard.play();
    pg.save("e.png");
  }
  //----------------------------------------------------------------------------line3
   if (mouseX>=600 && mouseX<=700 && mouseY>=1875 && mouseY<=1925) {
    println("c");
    keyboard.play();
    pg.save("c.png");
  }
}

void reset() {
  drawCharAngle=0;
  drawCharPos.set(805, 1330);
}

void drawSavedPt() {                                    //draw saved points on the screen
  drawBack();
  noStroke();
  pg.beginDraw();
  pg.beginShape();
  pg.background(255, 0);
  pg.stroke(255);

  pg.fill(0);
  pg.vertex(805, 1330);
  for (int j=0; j<NUM; j++) {
    if (mousePos[j].x!=0 && mousePos[j].y!=0) {

      pg.bezierVertex(drawCharPos.x, drawCharPos.y, drawCharPos.x + 10*cos(drawCharAngle/8), drawCharPos.y -10*sin(drawCharAngle/8), drawCharPos.x, drawCharPos.y);

      //ellipse(drawCharPos.x, drawCharPos.y, charStroke[j]/6, charStroke[j]/6);

      drawCharAngle+= charAngle[j];
      drawCharPos.x += 10*cos(drawCharAngle/8);
      drawCharPos.y -= 10*sin(drawCharAngle/8);
    }
  }
  for (int j=NUM-1; j>0; j--) {
    if (mousePos[j].x!=0 && mousePos[j].y!=0) {

      pg.bezierVertex(drawCharPos.x, drawCharPos.y, drawCharPos.x - 10*cos(drawCharAngle/8)+charStroke[j]/3, drawCharPos.y + 10*sin(drawCharAngle/8)+charStroke[j]/3, drawCharPos.x, drawCharPos.y);

      //ellipse(drawCharPos.x, drawCharPos.y, charStroke[j]/6, charStroke[j]/6);

      drawCharAngle -= charAngle[j];
      drawCharPos.x -= 10*cos(drawCharAngle/8);
      drawCharPos.y += 10*sin(drawCharAngle/8);
    }
  }
  pg.endShape();
  pg.endDraw();
  image(pg, 0, 0, 1600, 2400);



  for (int i=0; i<NUM; i++) {
    mousePos[i].set(0, 0);
  }
  mouseClk=0;
}


void drawBack() {
  //background
  image(typewriter, 0, 0);
}

void keyPressed() {
  if (key=='a') {
    a= loadImage("a.png");
    image(a, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if (key=='s') {
    s= loadImage("s.png");
    image(s, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if (key=='d') {
    d= loadImage("d.png");
    image(d, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if (key=='f') {
    f= loadImage("f.png");
    image(f, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
    if (key=='l') {
    l= loadImage("l.png");
    image(l, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
    if (key=='o') {
    o= loadImage("o.png");
    image(o, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if (key=='e') {
    e= loadImage("e.png");
    image(e, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if (key=='c') {
    c= loadImage("c.png");
    image(c, typeStart.x+charNum*50, typeStart.y, 640, 960);
    keyboard.play();
    charNum++;
  }
  if(key==ENTER){
    typeStart.y+=100;
    charNum=0;
  }
}
