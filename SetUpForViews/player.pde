

public class Player {

  float xpos; // position of the player
  float ypos;
  float defaultHeight; // defines how high the player must jump to trigger "hadJumped()"
  char jumpKey;
  // maybe overingeneured
  Cone cone;

/**
instanciate the players
*/
  public Player(float xSpawn, float ySpawn, float defaultHeight, char jumpKey) {
    cone = new Cone();
    xpos = xSpawn;
    ypos = ySpawn;
    this.defaultHeight = defaultHeight;
    this.jumpKey = jumpKey;
  }
  /*
  Contains the conditions if a Player had Jumped.
   @return true if the player had jumped
   */
  public boolean hadJumped() {
   /* if (keyPressed) {
      if (key == jumpKey) {
        return true;
      }
    }
    */
    if(yellow){
     return true; 
    }
    return false;
  }


  // capsulate the information for the cones/lifes
  private class Cone {
    int cones = 3;
  }
  
  /**
   *decrease the lifes of a player if he took a hit
  */
  void decreaseCones()  {
    if(cone.cones > 0){
      cone.cones--;
    }
    
  }
  
}
