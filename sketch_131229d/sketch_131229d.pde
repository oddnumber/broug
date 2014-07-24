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

