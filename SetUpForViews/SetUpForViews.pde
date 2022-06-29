import controlP5.*;
import processing.video.*;

//ScreenOne
Movie louieExampleMovie;
ControlP5 cp5;
Button startButton;
DropdownList numberOfPlayersList;
Textarea gameDescription;
Textarea logo;
PFont buttonTextFont;
int playerNumber;

//ScreenTwo
float angleRotate = 0.0;
Movie KopfFueslerMovie;
Textarea headerTextarea;
Textarea bodyTextarea;
Button backToStartButton;

void setup() {
  fullScreen(); //geeinigt, dass ganzes Programm in fullscreen laufen soll
  // -> automatisch auf bildschirm des Users angepasst
  frameRate(30);
  setupScreenOne();
}

void draw() {
  background(300, 182, 30);
  drawScreenOne();
  drawLittleLouieTurning();
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom(numberOfPlayersList)) {
    //TODO hier Anzahl = playerNumber als Variable in Logik merken -> TOM
  }

  if (theControlEvent.isFrom(startButton)) {
    //dann starte Screen Two
    louieExampleMovie.stop();
    louieExampleMovie.dispose();
    startButton.hide();
    numberOfPlayersList.hide();
    gameDescription.hide();

    setupScreenTwo();
    try {
      KopfFueslerMovie.loop();
    }
    catch(IllegalStateException e) {
      KopfFueslerMovie = new Movie(this, "playerYellow-Idle.3gp");
      image(KopfFueslerMovie, width/4 * 2.3, height/4 * 1.25, 470, 480);
      KopfFueslerMovie.loop();
    }
  }


  if (theControlEvent.isFrom(backToStartButton)) {
    //dann restart mit initialem SetUp
    bodyTextarea.hide();
    headerTextarea.hide();
    backToStartButton.hide();

    startButton.show();
    numberOfPlayersList.show();
    gameDescription.show();
    //--movie was disposed before -> initialize newly
    louieExampleMovie = new Movie(this, "Mein Film.mp4");
    image(louieExampleMovie, width/11, height/3.5, 550, (550/16)*11);
    louieExampleMovie.loop();

    KopfFueslerMovie.stop();
    KopfFueslerMovie.dispose();
  }
}

void movieEvent(Movie m) {
  m.read();
}

void drawLittleLouieTurning() {
  //----Little turning Looping Louie text animation
  pushMatrix();
  translate(width/5, height/7);
  rotate(radians(angleRotate));
  text( "L O O P I N G    L O U I E", 5, 5);
  popMatrix();
  angleRotate += 0.65;
}
