import controlP5.*;
import processing.video.*;

Movie LLDemoMovie;
ControlP5 cp5;
Button startButton;
DropdownList numberOfPlayersList;
Textarea gameDescription;
Textarea logo;
PFont buttonTextFont;
 

void setup() {
  frameRate(30);
  fullScreen(); //geeinigt, dass ganzes Programm in fullscreen laufen soll 
  // -> automatisch auf bildschirm des Users angepasst
  LLDemoMovie = new Movie(this, "WhatsApp Video 2022-06-03 at 8.31.42 AM.mp4");
  LLDemoMovie.loop();
  
  buttonTextFont = createFont("Thonburi-Bold", 20, true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(buttonTextFont, 20);
  
  cp5 = new ControlP5(this);

  startButton = cp5.addButton("START")
     .setPosition((width/6 * 4.3), height/8 *6)
     .setSize(150, 100)
     .setColorBackground(color(240, 30, 0))
     .setFont(font)
     .setColorForeground(color(140, 225, 10))
     .setColorActive(color(40, 255, 40));
     
  numberOfPlayersList = cp5.addDropdownList("Please select number of Players")
     .setPosition(width/6 *3.3, height/8 *5.6);
     //TODO: Schrift größer ----> nicht möglich? 
    customize(numberOfPlayersList);



  numberOfPlayersList.addItem("1 Player", 1);
     for(int j = 2; j < 5; j++){
          numberOfPlayersList.addItem(j+" Players", j);  
      };
   

  //----textBox for game description
  gameDescription = cp5.addTextarea("txt")
                  .setPosition(width/4 *2.1, height/3.5 )
                  .setSize(550,350)
                  .setFont(createFont("Verdana",20))
                  .setLineHeight(22)
                  .setColor(color(0));
                  
  gameDescription.setText("1. You will see an arm turning and your goal is to protect your tokens from being hit by the same one. "
                    +"\n\n"
                    +"2. To protect your tokens jump when the arm reaches you and try to hit it, in order to change the trajectory."
                    +"\n\n"
                    +"3. If you miss the arm you will loose one token, if you hit, the arm will fly over your tokens."
                    +"\n\n"
                    +"4. If you loose three tokens you will be eliminated."
                    +"\n\n"
                    +"5. Your Goal is to hit the arm more then your opponents and be the last with protected tokens."
                    );
                      
  //----textBox for logo
  logo = cp5.addTextarea("LOGO")
                  .setPosition(height/2,width/11)
                  .setSize(520,80)
                  .setFont(createFont("Tahoma-Bold",40))
                  .setLineHeight(22)
                  .setColor(color(239))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(20,100));
                  
  logo.setText(" L O O P I N G    L O U I E" );
  
  
//--- development help: prints out list of fonts
size(200, 200);
String[] fontList = PFont.list();
printArray(fontList);

}

void customize(DropdownList ddl) {
  ddl.setSize(200,300);
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(30);
  ddl.setBarHeight(30);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255,128));
  ddl.setBarVisible(true);
  ddl.close();
} 

void draw() {
  background(300, 182 , 30);
  image(LLDemoMovie, width/8, height/3.5, 550, 450);

}

void movieEvent(Movie m) {
  m.read();
}

void controlEvent(ControlEvent theControlEvent) 
{
  if (theControlEvent.isFrom(numberOfPlayersList))
  {  
    println("playerNumber");
  }
  if (theControlEvent.isGroup()) {
    println("event from group : "+theControlEvent.getGroup().getValue()+" from "+theControlEvent.getGroup());
  }
  if (theControlEvent.isFrom(startButton))
  {  
    println("play");
  }
}
