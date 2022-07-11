import processing.video.*;


Capture video;

color trackColor;
float threshold = 25;

void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[0]);
  video.start();
  trackColor = color(255, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}


void draw() {
  isYellow();
  image(video,0,0);
}
