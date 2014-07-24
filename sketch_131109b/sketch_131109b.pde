int sH=360;
int oW,oH;
float r= sH/2;
int fCol = 210;

float a = sin(PI/4)*r;
float b = (cos(PI/4)*r)+r;
float z = sqrt(sq(a)+sq(b));
// float theta = asin(a/z);
float theta = PI/8;

void setup(){
  size(600,400);
  oH=height/2;
  oW=width/2;
  
  stroke(fCol);
  noLoop();
}

void draw(){
  background(255);
  translate(oW,oH);
  rect(-sH/2,-sH/2,sH,sH);
  ellipse(0,0,sH,sH);
  
  stroke(fCol);  
  drawSpokes();
  drawFrame();
  
  stroke(0);
  drawPattern();
}

void drawPattern(){
   for(int i=0;i<4;i++){
    rotate(PI/2);
    line(0, tan(theta)*sH/2, -sH/2,tan(theta)*sH);
    line(0, tan(theta)*sH/2, sH/2,tan(theta)*sH);
    line(sH/2, 0, cos(PI/4) * tan(theta)*sH/2, sin(PI/4) * tan(theta)*sH/2);
    line(sH/2, 0, cos(PI/4) * tan(theta)*sH/2, -sin(PI/4) * tan(theta)*sH/2);
  }  
}

void drawFrame(){  
  for(int i=0;i<4;i++){
    rotate(PI/2);
    line(sH/2,0,-sH/2,tan(theta)*sH);
    line(sH/2,0,-sH/2,-tan(theta)*sH);
  }
}

void drawSpokes(){
  line(-sH/2,0,sH/2,0);
  line(0,sH/2,0,-sH/2);
  line(0,0,-r,r);
  line(0,0,r,r);
  line(0,0,r,-r);
  line(0,0,-r,-r);
}

