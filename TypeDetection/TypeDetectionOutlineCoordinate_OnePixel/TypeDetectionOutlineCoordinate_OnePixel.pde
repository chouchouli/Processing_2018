PImage img;
PVector highestPoint;

int [] colorMark = new int [5];
PVector [] position = new PVector [178506];
PVector [] order = new PVector[178506]; 
PVector [] edge = new PVector [178506];

int counter=0;
int dotNum=0;
int breakMark=0;

int tempt=0;






void setup() {
  highestPoint = new PVector(422, 423);

  size(2000, 2000);
  img = loadImage("2.png");
  println("size"+width + "," + height);
  image(img, 0, 0);


  for (int y = 1; y < height-1; y++) {
    for (int x = 1; x < width-1; x++) {
      // println(red(get(x,y)));
      if (int(red(get(x, y)))<=50) {
        colorMark[0]=1;
      } else {
        colorMark[0]=0;
      }
      if (int(red(get(x-1, y)))<=50) {
        colorMark[1]=1;
      } else {
        colorMark[1]=0;
      }
      if (int(red(get(x+1, y)))<=50) {
        colorMark[2]=1;
      } else { 
        colorMark[2]=0;
      }
      if (int(red(get(x, y-1)))<=50) {
        colorMark[3]=1;
      } else {  
        colorMark[3]=0;
      }
      if (int(red(get(x, y+1)))<=50) {
        colorMark[4]=1;
      } else { 
        colorMark[4]=0;
      }
      if (colorMark[0]==1) {
        if (colorMark[0]!=colorMark[1] || colorMark[0]!=colorMark[2]||
          colorMark[0]!=colorMark[3] || colorMark[0]!=colorMark[4]) {
          // print(counter);
          position[counter] = new PVector();
          position[counter].x = x;
          position[counter].y = y;
          counter+=1;
        }
      }
    }
  }
  dotNum=counter;
  println("counter:"+counter);
}

void draw() {
  fill(255, 255, 255);
  rect(0, 0, width, height);
  for (int i =0; i<counter; i++) {
    fill(255, 0, 0);
    ellipse(position[i].x*5-500, position[i].y*5-500, 1, 1);
  }
}
