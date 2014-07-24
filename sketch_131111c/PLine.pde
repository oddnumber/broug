class PLine {
  
  float x1;
  float y1;
  float x2;
  float y2;
  
  float A;
  float B;
  float C;
  
  PLine(float xP1, float yP1, float xP2, float yP2){
    x1 = xP1;
    y1 = yP1;
    x2 = xP2;
    y2 = yP2;
    
    A = y2 - y1;
    B = x1 - x2;
    C = A * x1 + B * y1;
}
  
  void display(){
   line(x1,y1,x2,y2); 
  }
  
}
