float r= 12;

int numX = 26;
int numY = 17;
Structure[][] shapes;

void setup(){
  frameRate(14);
  size(620,400);
  //hint(ENABLE_STROKE_PURE);
  strokeWeight(1);
 
  
  background(255);
  
  shapes = new Structure[numY][numX];
  
  for(int j=0; j<numY; j++){
   for(int i=0; i<numX; i++){
       shapes[j][i] = new Structure();
   }
  }
    
}

void draw(){
  background(255);
  translate(-r,r);
  for(int j=0; j<numY;j++){
      detranslate();
      translate(0,2*j*r);
      for(int i=0; i<numX;i++){
        translate(2*r,0);
  //      drawAxes();
   //     drawSpokes();
   //     drawFrame();
   //     drawPattern(); 
         shapes[j][i].draw();
    }
 }
  /*rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  
     drawFrame();
       drawPattern();
  */
  

  
  /* stroke(fCol);
  drawAxes();
  drawSpokes();
  drawFrame();
  stroke(0);  
  drawPattern(); 
  */
 
}

void detranslate(){
   resetMatrix();
   translate(-r,r);   
}


void drawAxes(){
  PLine axes = new PLine(-r,0,r,0);
  axes.spin4();
}

void drawSpokes(){
  PLine spoke=  new PLine(0,0,r,r);
  spoke.spin4();
}

class PLine {
  
  int startCol;
  int endCol;
  int nowCol;
  int speedChange;
  boolean fading;
  boolean fadingOffAgain; 
  boolean fadingOnRandom;
  float x1;
  float y1;
  float x2;
  float y2;
  
  float A=0;
  float B=0;
  float C=0;
 
  int[] fadeLines; // 0 to 255 of each line
  int[] randomTriggers;
  int[] fadeDirections;
  int numLines = 0;
  int savedTime;
 
   PLine(){
    x1 = 0;
    y1 = 0;
    x2 = 0;
    y2 = 0;
    
    A = 0;
    B = 0;
    C = 0;
  }
  
  PLine(float xP1, float yP1, float xP2, float yP2){
    x1 = xP1;
    y1 = yP1;
    x2 = xP2;
    y2 = yP2;
    
    A = y2 - y1;
    B = x1 - x2;
    C = A * x1 + B * y1;
    
    fadeLines = new int[8];
    randomTriggers = new int[8];
    fadeDirections = new int[8];
    
    resetSpeed();
}
  
  float getB(){
   return B; 
  }
  

  
  void highlight(){
   int tmpCol = g.strokeColor;
   stroke(0,255,0);
   line(x1,y1,x2,y2); 
   stroke(tmpCol);
  }
  
  void mirrorX(){
    line(-x1,y1,-x2,y2);
  }
  
  PLine getMirrorX(){
    return new PLine(-x1,y1,-x2,y2);
  }

  PLine getRotate90(){
    return new PLine(-y1,-x1,-y2,-x2);
  }

  PLine getMirrorDiag(){
    return new PLine(-y1,-x1,-y2,-x2);
  }
  
  void mirrorY(){
    line(x1,-y1,x2,-y2);
  }
  

  void mirrorDiagDown(){
    line(-y1,-x1,-y2,-x2);
  }
  
  void spin4(){
   for(int i=0; i<4; i++){
     rotate(PI/2);
     display();    
    }
  }
  
  void spin3(){
    for(int i=0; i<3; i++){
       rotate(2*PI/3);
       display();
      
    }
  }
  
  void spin(int numSpin){
   numLines = numSpin;
   for(int i=0; i<numSpin; i++){
     rotate(PI/(numSpin/2));
     display();    
    }
  }  
  
 
    
  
  void spin4MirrorX(){
   for(int i=0; i<4; i++){
     rotate(PI/2);
     display(); 
     //mirrorX();   
    }  
  }
  
  void spin4MirrorY(){
   for(int i=0; i<4; i++){
     rotate(PI/2);
     display(); 
     mirrorY();   
    }  
  }  
  
  void spin4MirrorDiag(){
   for(int i=0; i<4; i++){
     if(fadingOnRandom){
       handleFadingOnRandom(i);
     }
     rotate(PI/2);
     display(); 
     mirrorDiagDown();   
    }      
  }
  
  Point intersect(PLine l, boolean showWorking){
    float x=0;
    float y=0;
    float det=0;
    
    
    det = A * l.B - l.A * B;
  
     if(det == 0){
     // lines parallel
     }else{
       x = (l.B * C - B * l.C) / det;
       y = (A * l.C - l.A * C) / det;
   }
    int tmpCol = g.strokeColor;
    if(showWorking){
     println("x: " + x + " y: " + y);
     stroke(255,0,0);
      display();
      l.display();
      ellipse(x,y,10,10);
  }
  
  stroke(tmpCol);
  return new Point(x,y);  
    
  }
  
  int currentCol(){
    return nowCol;
  }
  
  boolean currentlyFading(){
   if(speedChange < 0){ 
     return true;
   }else{
     return false;
   }
  }
  
  int getEndCol(){
    return endCol;  
  }
  
  void resetSpeed(){
     speedChange = int(random(5))+5; 
  }
  
  void fadeOnRandom(int start, int end){
   // we need to have the fade values stored separately
   // together with different start times
   startCol = start;
   endCol = end;
   fadingOnRandom = true;
   for(int n=0; n<numLines; n++){
      randomTriggers[n]= int(random(1600)); 
      fadeLines[n] = startCol;  
      fadeDirections[n] = speedChange;
      savedTime = millis();
   }
  }
  
  void handleFadingOnRandom(int n){
       stroke(fadeLines[n]);
       if(millis() - savedTime > randomTriggers[n]){
           fadeLines[n] = fadeLines[n] - fadeDirections[n]; 
           
         if(fadeDirections[n] > 0){
             // it's getting darker
             if(fadeLines[n] <= endCol){ 
                fadeLines[n] = endCol;
             //   resetSpeed();
                fadeDirections[n] = - speedChange;
             }
         }else if(fadeDirections[n] < 0){    
            if(fadeLines[n] >= startCol){
               fadeLines[n] = startCol;
          //     resetSpeed();
               fadeDirections[n] =  speedChange;
            } 
         }
       }
  }
  
  void setNumLines(int n){
   numLines = n; 
  }
  
  void fadeOn(int start, int end){
      startCol = start;
      endCol = end;
      nowCol = startCol;
      
      fading = true;
  }
  
  void fadeOnandOffAgain(int start, int end){
      fadeOn(start, end);
      fadingOffAgain = true;
  }


  void handleFading(){
       nowCol = nowCol - speedChange;
      if(nowCol <= endCol){
        nowCol = endCol;
        if(fadingOffAgain){
           speedChange = -speedChange; 
        }else{
          println(endCol);
         fading=false; 
        }
      }    
      if(fadingOffAgain){
       if(nowCol >= startCol){
        nowCol = startCol;
        fading = false;
       } 
      }
  }

  void display(){
    //stroke(nowCol);
    if(fading){
      handleFading();
    }
   
    
   line(x1,y1,x2,y2); 
  }  
}
class Point{
   float x;
  float y;

   Point(float x1, float y1) {
    x = x1;
   y = y1; 
   }
}
class Structure {
  
PLine[] lines;
  
  
  Structure(){
    lines = new PLine[3];
      for(int i=0; i<lines.length; i++){
        lines[i] = new PLine();
      }
   
      createFrame();
      createPattern();     
    }
    
    void draw(){
     // drawFrame();
      drawPattern();
    }
    
  void createPattern(){
    lines[1] = new PLine(0,tan(PI/8)*r,-r,tan(PI/8)*2*r);
    lines[2] = new PLine(r,0,cos(PI/4) * tan(PI/8)*r, sin(PI/4)*tan(PI/8)*r);
    lines[1].setNumLines(4);
    lines[2].setNumLines(4);
    lines[1].fadeOnRandom(255,0);
    lines[2].fadeOnRandom(255,0);
  }

  void drawPattern(){
 
      lines[1].spin4MirrorDiag();
      lines[2].spin4MirrorDiag();
  
  }

  void createFrame(){
     lines[0] = new PLine(r,0,-r,tan(PI/8)*2*r);
     lines[0].setNumLines(4);
     lines[0].fadeOnRandom(255,180);
   }

  void drawFrame(){  
   lines[0].spin4MirrorDiag();
  }
    
  
}

