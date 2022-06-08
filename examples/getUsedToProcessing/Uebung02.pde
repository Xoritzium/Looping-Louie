
PImage photo;
boolean negative;

void setup() {
  size(600, 600);
  photo = loadImage("testbild.jpg");
}

void draw () {
  // image(photo, 0, 0);
  //negative = switchButton();
   
}


//
void keyPressed() {
  if (key == 'q') {
    changeColor(photo);
    image(photo, 0, 0);
  } 
    
  
}

void changeColor(PImage pic) {
  for (int x =0; x < pic.width; x++) {
    for (int y = 0; y< pic.height; y++) {
      pic.set( x, y, 255 - pic.get(x, y));
    }
  }
}
