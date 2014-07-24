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
  drawPattern();
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
    line(r,0,-r,tan(theta)*2*r);
    line(r,0,-r,-tan(theta)*2*r);
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

