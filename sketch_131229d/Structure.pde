class Structure {
  
PLine[] lines;
  
  
  Structure(){
    lines = new PLine[3];
      for(int i=0; i<lines.length; i++){
        lines[i] = new PLine();
      }
   
      createFrame();
      createPattern();     
    }
    
    void draw(){
     // drawFrame();
      drawPattern();
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
    
  
}
