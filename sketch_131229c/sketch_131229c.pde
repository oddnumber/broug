float r= 180;
int fCol = 210;

PLine[] lines;

void setup(){
  frameRate(15);
  size(620,400);
  hint(ENABLE_STROKE_PURE);
  strokeWeight(1);
  lines = new PLine[3];
  
  for(int i=0; i<lines.length; i++){
    lines[i] = new PLine();
  }
  
  background(255);
  
  createFrame();
  createPattern();
}

void draw(){
  background(255);
  stroke(fCol);
  translate(300,200);

  rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  
     drawFrame();
       drawPattern();
  
  

  
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
   translate(-r+10,r+10);   
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

void drawAxes(){
  PLine axes = new PLine(-r,0,r,0);
  axes.spin4();
}

void drawSpokes(){
  PLine spoke=  new PLine(0,0,r,r);
  spoke.spin4();
}

