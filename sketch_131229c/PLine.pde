class PLine {
  
  int startCol;
  int endCol;
  int nowCol;
  int speedChange=5;
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
  
  void fadeOnRandom(int start, int end){
   // we need to have the fade values stored separately
   // together with different start times
   startCol = start;
   endCol = end;
   fadingOnRandom = true;
   for(int n=0; n<numLines; n++){
      randomTriggers[n]= int(random(10000)); // want frames
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
                fadeDirections[n] = - speedChange;
             }
         }else if(fadeDirections[n] < 0){    
            if(fadeLines[n] >= startCol){
               fadeLines[n] = startCol;
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
