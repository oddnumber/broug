float r= 180;
int fCol = 210;

PLine[] lines;

void setup(){
  size(620,400);
  hint(ENABLE_STROKE_PURE);
  
  lines = new PLine[3];
  
  for(int i=0; i<lines.length; i++){
    lines[i] = new PLine();
  }
  
  background(255);
}

void draw(){
  stroke(fCol);
  translate(300,200);
 // rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  createFrame();

      stroke(fCol);
    //  drawAxes();
      drawSpokes();
      stroke(0);  
    //  drawPattern(); 
 
 
}

void detranslate(){
   resetMatrix();
   translate(-r+10,r+10);   
}

void drawPattern(){
  lines[1] = new PLine(0,tan(PI/8)*r,-r,tan(PI/8)*2*r);
  lines[2] = new PLine(r,0,cos(PI/4) * tan(PI/8)*r, sin(PI/4)*tan(PI/8)*r);
  
  lines[1].spin4MirrorDiag();
  lines[2].spin4MirrorDiag();
  
}

void createFrame(){
   lines[0] = new PLine(0,r,cos(PI/6)*r,sin(PI/6)*r);
   lines[0].spin(6);
   
  lines[1] = new PLine(-cos(PI/6)*r, sin(PI/6)*r,cos(PI/6)*r,sin(PI/6)*r);
   lines[1].spin3();
   
   lines[2] = new PLine(-cos(PI/6)*r, -sin(PI/6)*r,cos(PI/6)*r,-sin(PI/6)*r);
   lines[2].spin3();
     
   
}

void drawAxes(){
  PLine axes = new PLine(-r,0,r,0);
  axes.spin(4);
}

void drawSpokes(){
  PLine spoke =  new PLine(0,0,r,0);
  spoke.spin(12);
}

