
void setupScreenTwo() {
  
   cp5 = new ControlP5(this);
   ControlFont font = new ControlFont(buttonTextFont, 20);


      //----textBox for Instructions
   headerTextarea = cp5.addTextarea("headerDescription")
                   .setPosition(width/7, height/3.3 )
                  .setSize(550,350)
                  .setFont(createFont("Verdana",20))
                  .setLineHeight(22)
                  .setColor(color(0));
                  
   headerTextarea.setText("Welcome! To start we need to register the headband for each player."
                     +"\n\n"
                    +"Please calibrate headband for player " + playerNumber);

      //----textBox for Instructions overlaying Camera cature box             
   bodyTextarea = cp5.addTextarea("instruction")
                   .setPosition(width/7, height/2.2)
                  .setSize(550,350)
                  .setFont(createFont("Verdana",20))
                  .setLineHeight(22)
                  .setColor(color(0));
                 
                  
  bodyTextarea.setText("Place coloured headband in front of your\n camera and try to cover most of the frame.");
                    
  backToStartButton = cp5.addButton("BACK")
     .setPosition((width/6 * 5.4), height/20)
     .setSize(80, 50)
     .setColorBackground(color(240, 30, 0))
     .setFont(font)
     .setColorForeground(color(220,220,220))
     .setColorActive(color(220,220,220));
}
