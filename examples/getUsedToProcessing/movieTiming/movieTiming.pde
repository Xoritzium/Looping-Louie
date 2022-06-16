import processing.video.*;

Movie jump;
Movie idle;

boolean jumping = false;
int counter = 0;


void setup() {
  size(1000, 1000);
  jump = new Movie(this, "playerBlue-Jump.mp4");
  idle = new Movie(this, "playerBlue-Idle.mp4");
  // jump.play();
  idle.loop();
}

void draw() {
  
image(idle,0,0); // view.draw play (true)
  if (jumping) { // start jump animation
    if (counter < 46) {
      counter++;
      image(jump, 0, 0);///////////////////////
    } else {
      jumping = false;
      counter = 0;
      idle.loop();
      jump.stop();
    // jump = new Movie(this, "playerBlue-Jump.mp4");
    }
  } else {
    image(idle, 0, 0);/////////////////////
   /// idle.loop();
  }
  text("counter: " + counter, 20, 20);

  // image(jump, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  jump.loop();
  idle.stop();
  jumping = true;
  counter = 0;
}
