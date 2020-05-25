/* @pjs preload="file1.png","file2.png","file3.jgp"; */
// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game

Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Potato[] potatoes;       // An array of drop objects
PotatoH[] potatoesH;
PotatoV[] potatoesV;
Covid19[] covid19;
int totalPotatoes = 0; // totalDrops
int totalCovid19 = 0;

String potatoesRescued = "Potatoes Rescued: ";
String potatoesWasted = "Potatoes Wasted: ";
int caught;
int wasted;

void setup() {
  size(1024, 768);
  catcher = new Catcher(32); // Create the catcher with a radius of 32
  potatoes = new Potato[1000];    // Create 1000 spots in the array
  potatoesH = new PotatoH[1000];
  potatoesV = new PotatoV[1000];
  covid19 = new Covid19[100];
  timer = new Timer(300);    // Create a timer that goes off every 300 milliseconds
  timer.start();             // Starting the timer
}

void draw() {
  background(255);

  // Set catcher location
  catcher.setLocation(mouseX, mouseY); 
  // Display the catcher
  catcher.display(); 

  // Check the timer
  if (timer.isFinished()) {
    // Deal with raindrops
    // Initialize one drop
    potatoes[totalPotatoes] = new Potato();
    potatoesH[totalPotatoes] = new PotatoH();
    potatoesV[totalPotatoes] = new PotatoV();
    covid19[totalCovid19] = new Covid19();
    // Increment totalDrops
    totalPotatoes ++ ;
    totalCovid19 ++;
    // If we hit the end of the array
    if (totalPotatoes >= potatoes.length) {
      totalPotatoes = 0; // Start over
    }
    if (totalCovid19 >= covid19.length) {
      totalCovid19 = 0; // Start over
    }
    
    timer.start();
  }

  // Move and display all drops
  for (int i = 0; i < totalPotatoes; i++ ) {
    potatoes[i].move();
    potatoesH[i].move();
    potatoesV[i].move();
    
    potatoes[i].display();
    potatoesH[i].display();
    potatoesV[i].display();
    
    if (catcher.intersect(potatoes[i])) {
      potatoes[i].caught();
      caught++;
    }
    if (catcher.intersect(potatoesH[i])) {
      potatoesH[i].caught();
      caught++;
    }
    if (catcher.intersect(potatoesV[i])) {
      potatoesV[i].caught();
      caught++;
    }
    
    if (potatoes[i].reachedBottom()){
      wasted++;
    }
    if (potatoesH[i].reachedBottom()){
      wasted++;
    }
    if (potatoesV[i].reachedBottom()){
      wasted++;
    }
    
  }
  
  for (int i = 0; i < totalCovid19; i++){
    covid19[i].move();
    covid19[i].display();
    if (catcher.intersect(covid19[i])) {
      covid19[i].caught();
      caught = 0;
      background(255,0,0);
    }
  }
  
  fill(0);
  textSize(24);
  text(potatoesRescued, 5, 25);
  text(potatoesWasted, 5, 50);
  fill(0,255,0);
  text(caught, 225, 25);
  fill(255,0,0);
  text(wasted, 210, 50);
  
  
}

// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game

class Catcher {
  float r;    // radius
  color col;  // color
  float x, y; // location
  PImage pantry;

  Catcher(float tempR) {
    r = tempR;
    col = color(50, 10, 10, 150);
    x = 0;
    y = 0;
    pantry = loadImage("food-bank.png");
  }

  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void display() {
    //stroke(0);
    //fill(col);
    //ellipse(x, y, r*2, r*2);
    imageMode(CENTER);
    image(pantry, x, y);
  }

  // A function that returns true or false based on
  // if the catcher intersects a raindrop
  boolean intersect(Potato d) {
    // Calculate distance
    float distance = dist(x, y, d.x, d.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(PotatoH d) {
    // Calculate distance
    float distance = dist(x, y, d.x, d.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(PotatoV d) {
    // Calculate distance
    float distance = dist(x, y, d.x, d.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
  
  
  boolean intersect(Covid19 d) {
    // Calculate distance
    float distance = dist(x, y, d.x, d.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
  
}

// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game
class Covid19 {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  PImage covid19;

  Covid19() {
    r = 8;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*4;                // Start a little above the window
    speed = random(1, 5);    // Pick a random speed
    c = color(50, 100, 150); // Color
    covid19 = loadImage("covid19.png");
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  // Display the raindrop
  void display() {
    // Display the drop
    //fill(c);
    //noStroke();
    for (int i = 2; i < r; i++ ) {
      //ellipse(x, y + i*4, i*2, i*2);
      image(covid19, x, y);
      
    }
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    y = -1000;
  }
}


// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game
class Potato {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  PImage potato;

  Potato() {
    r = 8;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*4;                // Start a little above the window
    speed = random(1, 5);    // Pick a random speed
    c = color(50, 100, 150); // Color
    potato = loadImage("potato.png");
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  // Display the raindrop
  void display() {
    // Display the drop
    //fill(c);
    //noStroke();
    for (int i = 2; i < r; i++ ) {
      //ellipse(x, y + i*4, i*2, i*2);
      image(potato, x, y);
      
    }
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    y = -1000;
  }
}


// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game
class PotatoH {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  PImage potatoH;

  PotatoH() {
    r = 8;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*4;                // Start a little above the window
    speed = random(1, 5);    // Pick a random speed
    c = color(50, 100, 150); // Color
    potatoH = loadImage("potatohor.png");
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  // Display the raindrop
  void display() {
    // Display the drop
    //fill(c);
    //noStroke();
    for (int i = 2; i < r; i++ ) {
      //ellipse(x, y + i*4, i*2, i*2);
      image(potatoH, x, y);
      
    }
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    y = -1000;
  }
}


// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game
class PotatoV {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  PImage potatoV;

  PotatoV() {
    r = 8;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*4;                // Start a little above the window
    speed = random(1, 5);    // Pick a random speed
    c = color(50, 100, 150); // Color
    potatoV = loadImage("potatover.png");
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  // Display the raindrop
  void display() {
    // Display the drop
    //fill(c);
    //noStroke();
    for (int i = 2; i < r; i++ ) {
      //ellipse(x, y + i*4, i*2, i*2);
      image(potatoV, x, y);
      
    }
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    y = -1000;
  }
}


// Based off original source code from: http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game

class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }

  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
