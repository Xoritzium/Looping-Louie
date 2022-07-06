import processing.video.*;

Capture camera;

color trackColor;// -> pure red

float trackH;
float trackS;
float trackB;

float threshold = 50;

void setup() {///////////////////////////////////////////////////////
background(0,0,0);
  frameRate(30);
  size(1000, 480);
  String[] cams = Capture.list();
  if (cams.length ==0) {
    System.err.println("no cameras found");
  }
  camera = new Capture(this, cams[0]);
  camera.start();
  colorMode(HSB, 360, 100, 100); //360 = h, 100 = s, 100 = b
  trackColor = color(0, 100, 100);
  trackH = hue(trackColor); // 0
  trackS = saturation(trackColor); // 100
  trackB = brightness(trackColor); // 100
}

void captureEvent(Capture vid) {
  vid.read();
}

void draw() {/////////////////////////////////////////////////////////
  camera.loadPixels();
  image(camera, 0, 0);
float h1 = 0,s1 = 0,b1 = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < camera.width; x++ ) {
    for (int y = 0; y < camera.height; y++ ) {
      int loc = x + y * camera.width;
      // What is current color
      color currentColor = camera.pixels[loc];
       h1 = hue(currentColor);
       s1 = saturation(currentColor);
       b1 = brightness(currentColor);

      if (colorMatch(h1, s1, b1)) {
        println("color found");
      }
    }
  }
  text("h: " + trackH + " s: " + trackS + " b: " + trackB,640,10);
   text("h: " + h1 + "s: " + s1 + "b: " + b1, 640,20);
  
}


boolean colorMatch(float h, float s, float b) {
  if ( h >= 360-threshold &&h <= 360 && h <= trackH +threshold &&
    s <= trackS -threshold && s >= trackS + threshold &&
    b <= trackB -threshold && b >= trackB+threshold) {
    return true;
  }
  return false;
}
