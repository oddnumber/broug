float r= 180;
int fCol = 210;
float theta = PI/8;

void setup(){
  size(600,400);
  noLoop();
}

void draw(){
  background(255);
  translate(300,200);
  stroke(fCol);
  rect(-r,-r,2*r,2*r);
  ellipse(0,0,2*r,2*r);
  
  stroke(fCol);  
  drawSpokes();
  drawFrame();
  
  stroke(0);
  //drawPattern();
}

void drawPattern(){
   for(int i=0;i<4;i++){
    rotate(PI/2);
    line(0, tan(theta)*r, -r,tan(theta)*2*r);
    line(0, tan(theta)*r, r,tan(theta)*2*r);
    line(r, 0, cos(PI/4) * tan(theta)*r, sin(PI/4) * tan(theta)*r);
    line(r, 0, cos(PI/4) * tan(theta)*r, -sin(PI/4) * tan(theta)*r);
  }  
}

void drawFrame(){  
  for(int i=0;i<4;i++){
    rotate(PI/2);
    line(0,r,-r,r-tan(theta)*r);
    line(0,r,r,r-tan(theta)*r);
  }
  
  noFill();
  float iSq = cos(PI/4)*r;
  
  for(int i=0;i<2;i++){
   rotate(PI/4);
   rect(-iSq,-iSq,2*iSq,2*iSq);
  }
  
  rotate(-PI/2);  
  PLine sql = new PLine(-iSq,iSq,iSq,iSq);

  float d = r - tan(theta)*r;
  for(int i=0;i<2;i++){
   rotate(PI/2);
   line(-r,d,d,-r);
   line(-d,r,r,-d);
  
 }

  sql.display();
  PLine diag = new PLine(-d,r,r,-d);
  diag.display();
  
  Point xy;
  xy = findIntersection(sql,diag);
   stroke(fCol);
for(int i=0;i<2;i++){
     rotate(PI/2);  line(-xy.x,r,-xy.x,-r);
    line(xy.x,r,xy.x,-r);
 }
}

void drawSpokes(){
  line(-r,0,r,0);
  line(0,r,0,-r);
  line(0,0,-r,r);
  line(0,0,r,r);
  line(0,0,r,-r);
  line(0,0,-r,-r);
}

Point findIntersection(PLine l1, PLine l2){
  float x=0;
  float y=0;
  
  float det = l1.A * l2.B - l2.A * l1.B;
   if(det == 0){
     // lines parallel
   }else{
     x = (l2.B * l1.C - l1.B * l2.C) / det;
     y = (l1.A * l2.C - l2.A * l1.C) / det;
   }
  
  println("x: " + x + " y: " + y);
  stroke(0);
  ellipse(x,y,10,10);
  Point ab = new Point(x,y);
  return ab;
}


