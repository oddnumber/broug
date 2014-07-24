float r= 180;
int fCol = 210;

PLine[] lines = new PLine[8];

void setup(){
  size(600,400);
  hint(ENABLE_STROKE_PURE);
  noLoop();
}

void draw(){
  background(255);
  translate(300,200);
  stroke(fCol);
  rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  
  stroke(fCol);  
  drawAxes();
  drawSpokes();
  drawFrame();
  
  stroke(0);
  drawPattern();


}


void drawPattern(){
  Point a = findIntersection(lines[0],lines[3],false);
  Point b = findIntersection(lines[0],lines[2], false);
  Point c = findIntersection(lines[2],lines[3].getMirrorX(),false);
  Point d = findIntersection(lines[2],lines[3].getRotate90(),false);

  lines[4] = new PLine(0,r,a.x,a.y);
  lines[5] = new PLine(b.x,b.y,lines[0].x2,lines[0].y2);
  lines[6] = new PLine(-a.x,a.y,c.x,c.y); 
  lines[7] = new PLine(b.x,b.y,d.x,d.y);
   
  lines[4].spin4MirrorX();
  lines[5].spin4MirrorDiag();
  lines[6].spin4MirrorX();
  lines[7].spin4MirrorDiag();
 
}

void drawFrame(){  
  float iSq = cos(PI/4)*r;
  float d = r - tan(PI/8)*r;
    
  lines[0] = new PLine(0,r,-r,r-tan(PI/8)*r);
  lines[1] = new PLine(-iSq,iSq,iSq,iSq);  
  lines[2] = new PLine(-d,r,r,-d); 
  Point a = findIntersection(lines[1],lines[2],false);
  lines[3] = new PLine(a.x,r,a.x,-r);
  
  lines[0].spin4MirrorX();
  rotate(PI/2);
  lines[1].spin4MirrorY();
  rotate(PI/4);
  lines[1].spin4MirrorY();
  rotate(-PI/4);  
  lines[2].spin4MirrorDiag();
  lines[3].spin4MirrorX(); 
  
}

void drawAxes(){
  PLine axes = new PLine(-r,0,r,0);
  axes.spin4();
}

void drawSpokes(){
  PLine spoke=  new PLine(0,0,r,r);
  spoke.spin4();
}

Point findIntersection(PLine l1, PLine l2, boolean showWorking){
  float x=0;
  float y=0;
  
  float det = l1.A * l2.B - l2.A * l1.B;
   if(det == 0){
     // lines parallel
   }else{
     x = (l2.B * l1.C - l1.B * l2.C) / det;
     y = (l1.A * l2.C - l2.A * l1.C) / det;
   }
  int tmpCol = g.strokeColor;
  if(showWorking){
   println("x: " + x + " y: " + y);
   stroke(255,0,0);
    l1.display();
    l2.display();
    ellipse(x,y,10,10);
  }
  stroke(tmpCol);
  return new Point(x,y);
}


