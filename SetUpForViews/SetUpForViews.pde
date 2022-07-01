


/**
 TODO -> amountOfPlayer setzen
 -> camera logic -> "richtig machen
 -> setup loose for less then 4 player !
 */
import controlP5.*;
import processing.video.*;

/**state:
 0 = startScreen + setupCamera
 1 = inGame + gameOver-screen
 */
int state = 0;


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
Button startGameButton;

//ScreenThree / mainGame
InGameLogic igl;
Button backToMainMenu;
int amountOfPlayers = 3;

// debug
float selectNumber = 0;

//Camera stuff


void setup() {
  fullScreen(); //geeinigt, dass ganzes Programm in fullscreen laufen soll
  // -> automatisch auf bildschirm des Users angepasst
  frameRate(30);
  setupScreenOne();
  // screenThree setup
  igl = new InGameLogic(amountOfPlayers);
  camSetup(); ////////////////////////////////////////////////////////////////////////////////

}

void draw() {
setupP1Yellow();
setupP2Blue();
setupP3Red();
  
  switch(state) {
  case 0:
    background(300, 182, 30);
    drawScreenOne();
    drawLittleLouieTurning();
    break;
  case 1:
    igl.drawInGame();
    break;
  }

  text("amountOfPlayer: " + selectNumber, 100, 100);
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isGroup()) {
    //TODO hier Anzahl = playerNumber als Variable in Logik merken -> TOM
    //-> aufruf von igl.setPlayerAmount(amountOfPlayers);
    selectNumber = theControlEvent.getController().getValue();
    amountOfPlayers = int(selectNumber + 1);
    if (theControlEvent.isGroup()) {
      // check if the Event was triggered from a ControlGroup
      println("event from group : "+theControlEvent.getGroup().getValue()+" from "+theControlEvent.getGroup());
    }
    igl.setPlayerAmount(amountOfPlayers);
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
    startGameButton.hide();

    startButton.show();
    numberOfPlayersList.show();
    gameDescription.show();
    logo.show();
    //--movie was disposed before -> initialize newly
    louieExampleMovie = new Movie(this, "Mein Film.mp4");
    image(louieExampleMovie, width/11, height/3.5, 550, (550/16)*11);
    louieExampleMovie.loop();

    KopfFueslerMovie.stop();
    KopfFueslerMovie.dispose();
  }

  if (theControlEvent.isFrom(startGameButton)) {
    bodyTextarea.hide();
    headerTextarea.hide();
    backToStartButton.hide();
    startGameButton.hide();
    logo.hide();

    KopfFueslerMovie.stop();
    KopfFueslerMovie.dispose();


    igl.inGameLogicSetup(this);
    state = 1; // start game
  }

  if (theControlEvent.isFrom(backToMainMenu)) {
    backToMainMenu.hide();
    igl = new InGameLogic(amountOfPlayers);

    startButton.show();
    numberOfPlayersList.show();
    gameDescription.show();
    logo.show();
    //--movie was disposed before -> initialize newly
    louieExampleMovie = new Movie(this, "Mein Film.mp4");
    image(louieExampleMovie, width/11, height/3.5, 550, (550/16)*11);
    louieExampleMovie.loop();
    state = 0;
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
