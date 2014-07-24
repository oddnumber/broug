float r= 180;
PLine aLine;

void setup(){
  size(620,400);
  hint(ENABLE_STROKE_PURE);

  background(255);
  
  stroke(0);
  translate(300,200);
  aLine = new PLine(0,0,0,r);
  aLine.fadeOnandOffAgain();
  frameRate(25);
}

void draw(){
  background(255);
  translate(300,200);
  aLine.spin(4);
}
