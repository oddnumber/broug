float r= 180;
int fCol = 210;

PLine[] lines;

void setup(){
  size(620,400);
  hint(ENABLE_STROKE_PURE);
  
  lines = new PLine[8];
  
  for(int i=0; i<lines.length; i++){
    lines[i] = new PLine();
  }
  background(255);
}

void draw(){
  stroke(fCol);
  translate(300,200);
  strokeWeight(1);    

  rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  createFrame();
  stroke(fCol);
  drawAxes();
  drawSpokes();
  drawFrame();
  stroke(0);  
  drawPattern(); 
 
}

void detranslate(){
   resetMatrix();
   translate(-r+10,r+10);   
}

void drawPattern(){
  Point a = lines[0].intersect(lines[3],false);
  Point b = lines[0].intersect(lines[2], false);
  Point c = lines[2].intersect(lines[3].getMirrorX(),false);
  Point d = lines[2].intersect(lines[3].getRotate90(),false);

  lines[4] = new PLine(0,r,a.x,a.y);
  lines[5] = new PLine(b.x,b.y,lines[0].x2,lines[0].y2);
  lines[6] = new PLine(-a.x,a.y,c.x,c.y); 
  lines[7] = new PLine(b.x,b.y,d.x,d.y);
   
  lines[4].spin4MirrorX();
  lines[5].spin4MirrorDiag();
  lines[6].spin4MirrorX();
  lines[7].spin4MirrorDiag();
 
}

void createFrame(){
  float iSq = cos(PI/4)*r;
  float d = r - tan(PI/8)*r;
    
  lines[0] = new PLine(0,r,-r,r-tan(PI/8)*r);
  lines[1] = new PLine(-iSq,iSq,iSq,iSq);  
  lines[2] = new PLine(-d,r,r,-d); 
  
  Point a = lines[1].intersect(lines[2], false);
  lines[3] = new PLine(a.x,r,a.x,-r);
}

void drawFrame(){  
  lines[0].spin4MirrorX();
  rotate(PI/2);
  lines[1].spin4MirrorY();
  rotate(PI/4);
  lines[1].spin4MirrorY();
  rotate(-PI/4);  
  lines[2].spin4MirrorDiag();
  lines[3].spin4MirrorX(); 
  rotate(-PI/2);
}

void drawAxes(){
  PLine axes = new PLine(-r,0,r,0);
  axes.spin4();
}

void drawSpokes(){
  PLine spoke=  new PLine(0,0,r,r);
  spoke.spin4();
}

