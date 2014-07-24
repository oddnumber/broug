int sH=360;
int oW,oH;
float r= sH/2;

void setup(){
  size(600,400);
  oH=height/2;
  oW=width/2;
  
  stroke(210);
  noLoop();
}

void draw(){
  background(255);
  translate(oW,oH);
//  rect(oW-sH/2,oH-sH/2,sH,sH);
  rect(-sH/2,-sH/2,sH,sH);
  ellipse(oW,oH,sH,sH);
  drawSpokes();
  
  Point p1 = new Point(sH/2,0);
  
  float a = sin(PI/4)*r;
  float b = (cos(PI/4)*r)+r;
  float z = sqrt(sq(a)+sq(b));
  
  float theta = asin(a/z);
  
  Point p2 = new Point(-sH/2, tan(theta) * sH);
  lineP(p1,p2);
  
  rotate(PI/4);
  lineP(p1,p2);

}

void lineP(Point a, Point b){
 lineO(a.x, a.y, b.x, b.y); 
}

void lineO(float x1,float y1,float x2,float y2){
 line(oW + x1, oH - y1, oW + x2, oH - y2);   
}

void drawSpokes(){
  lineO(-sH/2,0,sH/2,0);
  lineO(0,sH/2,0,-sH/2);
  lineO(0,0,-r,r);
  lineO(0,0,r,r);
  lineO(0,0,r,-r);
  lineO(0,0,-r,-r);
}

