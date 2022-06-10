

public class Player {

  float xpos; // position of the player
  float ypos;
  float defaultHeight; // defines how high the player must jump to trigger "hadJumped()"
  boolean coneHit; // unessescary?
  
  
  Cone cone;


  public Player(float xSpawn, float ySpawn, float defaultHeight) {
    cone = new Cone();
    xpos = xSpawn;
    ypos = ySpawn;
    this.defaultHeight = defaultHeight;
  }
  /*
  Contains the conditions if a Player had Jumped.
  @return true if the player had jumped
   */
  public boolean hadJumped() {
    if (keyPressed) {
      if (key == 'q') {
        return true;
      }
    }
    return false;
  }
  

  // capsulate the information for the cones
  private class Cone {
    int cones = 3;
  }
}
