PImage img;

PVector highestPoint;
int NUM = 80000;                               // 422*423 pixels, which really depends on the size of the img

int [] colorMark = new int [5];                 // to first record if a pixel and the four pixel around it is black or white; white==1; black==0; 
PVector [] position = new PVector [NUM]; // position vector array is to store all the pixel that are part of edge, but the order is by lines and columns rather than writing order.
PVector [] positionCopy = new PVector [NUM]; 
PVector [] order = new PVector[NUM];            // the ordered pixels are stored here, start from the highest point.
int counter=0;
int dotNum=0;
int breakMark=0;
int pointType=0;
int aroundDot;


int [] jTempt = new int [8];





void setup() {  
  highestPoint = new PVector(3810, 2160);

  size(2000, 2000);
  img = loadImage("FrenchScript.png");
  //println("size"+width + "," + height);
  image(img, 0, 0);

  //*******************************************initial the position array and order array
  for (int i=0; i<NUM; i++) {
    position[i] = new PVector();
    positionCopy [i] = new PVector();
    order[i] = new PVector();
  }

  ////*******************************************detect the point which is at the outline of the pic, like the border of black and white
  //for (int y = 1; y < height-1; y++) {
  //  for (int x = 1; x < width-1; x++) {
  //    if (int(red(get(x, y)))==255) {
  //      colorMark[0]=1;
  //    } else { 
  //      colorMark[0]=0;
  //    }
  //    if (int(red(get(x-1, y)))==255) {
  //      colorMark[1]=1;
  //    } else { 
  //      colorMark[1]=0;
  //    }
  //    if (int(red(get(x+1, y)))==255) {
  //      colorMark[2]=1;
  //    } else { 
  //      colorMark[2]=0;
  //    }
  //    if (int(red(get(x, y-1)))==255) {
  //      colorMark[3]=1;
  //    } else { 
  //      colorMark[3]=0;
  //    }
  //    if (int(red(get(x, y+1)))==255) {
  //      colorMark[4]=1;
  //    } else { 
  //      colorMark[4]=0;
  //    }
  //    //*******************************************store the new detected into the array position[]
  //    if ( colorMark[0]!=colorMark[1] || colorMark[0]!=colorMark[2] || colorMark[0]!=colorMark[3] || colorMark[0]!=colorMark[4] ) {
  //      position[counter].x = x;
  //      position[counter].y = y;
  //      //println(position[counter]);
  //      counter++;
  //    }
  //  }
  //}

  //*******************************************detect the point which is at the outline of the pic, like the border of black and white
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
          position[counter].x = x;
          position[counter].y = y;
          counter+=1;
        }
      }
    }
  }


  dotNum=counter;
  println(counter);
  
  //************************************************************delete the redundant points
  for (int i=0; i<NUM; i++) {
    int k=0;
    for (int j=0; j<dotNum; j++) { //
      if ((position[j].x == position[i].x+1 && position[j].y == position[i].y)||
        (position[j].x == position[i].x+1 && position[j].y == position[i].y-1)||
        (position[j].x == position[i].x+1 && position[j].y == position[i].y+1)||
        (position[j].x == position[i].x-1 && position[j].y == position[i].y)||
        (position[j].x == position[i].x-1 && position[j].y == position[i].y-1)||
        (position[j].x == position[i].x-1 && position[j].y == position[i].y+1)||
        (position[j].x == position[i].x && position[j].y == position[i].y+1)||
        (position[j].x == position[i].x && position[j].y == position[i].y-1)) {
        aroundDot++;
        if ((position[j].x == position[i].x+1 && position[j].y == position[i].y)||
          (position[j].x == position[i].x-1 && position[j].y == position[i].y)||
          (position[j].x == position[i].x && position[j].y == position[i].y+1)||
          (position[j].x == position[i].x && position[j].y == position[i].y-1)) {
          jTempt[k]=j;
        }
      }
    }

    if (aroundDot>=3) {
      for (int p=0; p<jTempt.length; p++) {
        position[jTempt[p]].set(0, 0);
      }
    }
    aroundDot=0;
  }
  
  
  //*************************copy position array
  for (int i=0; i<dotNum; i++) {
    positionCopy[i].x = position[i].x;
    positionCopy[i].y = position[i].y;
  }
  //**********************************************************finding highest point
  for (int i=0; i<NUM; i++) {
    if (position[i].y!=0 && position[i].x!=0) {
      if (position[i].y<highestPoint.y) {
        highestPoint = position[i];
        println(highestPoint);
      }
    }
  }

  order[0] = highestPoint;
  println("highestPoint"+order[0]);
  //************************************************************put them in order
  for (int i=0; i<counter; i++) {
    //--1--
    for (int j=0; j<counter; j++) {
      if (position[j].x == order[i].x+1 && position[j].y == order[i].y ) {
        pointType=1;  
        order[i+1].x = position[j].x;
        order[i+1].y = position[j].y;       
        position[j].set(0, 0); 
      
        break;
      }
    }
    if (pointType==1) {
      pointType=0;
    } else {
      //--2--
      for (int j=0; j<counter; j++) {
        if (position[j].x == order[i].x+1 && position[j].y == order[i].y-1 ) {
          pointType=2;  
          order[i+1].x = position[j].x;
          order[i+1].y = position[j].y;
          position[j].set(0, 0);
          break;
        }
      }
      if (pointType==2) {
        pointType=0;
      } else {
        //--3--
        for (int j=0; j<counter; j++) {
          if (position[j].x == order[i].x && position[j].y == order[i].y-1 ) {
            pointType=3;  
            order[i+1].x = position[j].x;
            order[i+1].y = position[j].y;
            position[j].set(0, 0);
            break;
          }
        }
        if (pointType==3) {
          pointType=0;
        } else {
          //--4--
          for (int j=0; j<counter; j++) {
            if (position[j].x == order[i].x-1 && position[j].y == order[i].y-1 ) {
              pointType=4;  
              order[i+1].x = position[j].x;
              order[i+1].y = position[j].y;
              position[j].set(0, 0);
              break;
            }
          }
          if (pointType==4) {
            pointType=0;
          } else {
            //--5--
            for (int j=0; j<counter; j++) {
              if (position[j].x == order[i].x-1 && position[j].y == order[i].y ) {
                pointType=5;  
                order[i+1].x = position[j].x;
                order[i+1].y = position[j].y;
                position[j].set(0, 0);
                break;
              }
            }
            if (pointType==5) {
              pointType=0;
            } else {
              //--6--
              for (int j=0; j<counter; j++) {
                if (position[j].x == order[i].x-1 && position[j].y == order[i].y+1 ) {
                  pointType=6;  
                  order[i+1].x = position[j].x;
                  order[i+1].y = position[j].y; 
                  position[j].set(0, 0);
                  break;
                }
              }
              if (pointType==6) {
                pointType=0;
              } else {
                //--7--
                for (int j=0; j<counter; j++) {
                  if (position[j].x == order[i].x && position[j].y == order[i].y+1 ) {
                    pointType=7;  
                    order[i+1].x = position[j].x;
                    order[i+1].y = position[j].y; 
                    position[j].set(0, 0);
                    break;
                  }
                }
                if (pointType==7) {
                  pointType=0;
                } else {
                  //--8--
                  for (int j=0; j<counter; j++) {
                    if (position[j].x == order[i].x+1 && position[j].y == order[i].y+1 ) {
                      pointType=8;  
                      order[i+1].x = position[j].x;
                      order[i+1].y = position[j].y; 
                      position[j].set(0, 0);
                      break;
                    }
                  }
                  if (pointType==8) {
                    pointType=0;
                  }//whether PT==8
                }//whether PT==7
              }//whether PT==6
            }//whether PT==5
          }//whether PT==4
        }//whether PT==3
      }//whether PT==2
    } //whether PT==1
  }


  //end of setup function
  for (int i =0; i<dotNum; i++) {
    // println("order"+i+"="+order[i]);
  }
}


void draw() {
  fill(255, 255, 255);
  rect(0, 0, width, height);
  fill(255, 0, 0);
  noStroke();
  for (int i =0; i<dotNum; i++) {
    fill(0, 255, 0);
   // rect(positionCopy[i].x*6, positionCopy[i].y*6, 5, 5);
  }
  for (int i =0; i<dotNum; i++) {
    fill(255, 0, 0);
    rect(order[i].x*6, order[i].y*6, 5, 5);
  }
}
