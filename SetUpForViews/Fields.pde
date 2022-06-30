//----------------------------------------
//--Player Strokes------------------------
//----------------------------------------
//Black lines to mark area of player

  void playerStrokes(){
    stroke(0, 0, 0);
    line((width/4), 0, (width/4), height);
    line(2*(width/4), 0, 2*(width/4), height);
    line(3*(width/4), 0, 3*(width/4), height);
  }
  
  
  
//----------------------------------------
//--Player Scan field - auto color setup--
//----------------------------------------
// Small rectangles to mark area for color setup
  
  //P1 Yellow
  void p1YellowScanField(){
      stroke(255, 255, 0);
      fill(0, 0);
      rect((width/8)-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
  }
  
  //P2 Blue
  void p2BlueScanField(){
    stroke(0, 0, 255);
    fill(0, 0);
    rect(((width/8)+(2*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
  }
  
  //p3 Red
  void p3RedScanField(){
    stroke(255, 0, 0);
    fill(0, 0);
    rect(((width/8)+(4*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
  }
 
  //p4 Green
  void p4GreenScanField(){
    stroke(0, 255, 0);
    fill(0, 0);
    rect(((width/8)+(6*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
  }
  
