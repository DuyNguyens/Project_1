int numSteves = 1;
int numFoods = 30;

Steve[] steves = new Steve[numSteves];
Food[] foods = new Food[numFoods];
boolean monkaW = true;
int numCreatures = 50; 
PVector position, target;
PImage faceCurrent, anime02, anime04, anime01, anime05, animeBackground; 
float margin = 50;

boolean monkaS = false;
int botheredMarkTime = 0;
int botheredTimeout = 3000; // Processing measures time in milliseconds
int botheredSpread = 5;

boolean monkaHmm = false;
int blinkMarkTime = 0;
int blinkTimeout = 4000;
int blinkDuration = 250;

float triggerDistance1 = 100;
float triggerDistance2 = 5;
float triggerDistance3 = 0;
float movementSpeed = 0.08;

void setup() { 
  size(800, 600, P2D);
  position = new PVector(width/2, height/2);
  pickTarget();
  
  food = loadImage("food.png");
  animeBackground = loadImage("animeBackground.jpg");
  
   for (int i=0; i<steves.length; i++) {
    steves[i] = new Steve(random(width), random(height));
  }
  
  for (int i=0; i<foods.length; i++) {
    foods[i] = new Food(random(width), random(height));
  }
   
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
}

 
void draw() {
  background(animeBackground);
  
   for (int i=0; i<foods.length; i++) {
    foods[i].run();
  }
  
  for (int i=0; i<steves.length; i++) {
    steves[i].run();
  }
  
   
  if (monkaS) {
    botheredMarkTime = millis();
    faceCurrent = anime04; // worried expression
    position = position.lerp(target, movementSpeed).add(new PVector(random(-botheredSpread, botheredSpread), random(-botheredSpread, botheredSpread)));
    if (position.dist(target) < triggerDistance2) {
      pickTarget();
    }
  } else if (!monkaS && millis() > botheredMarkTime + botheredTimeout) {
    if (!monkaHmm && millis() > blinkMarkTime + blinkTimeout) {
      monkaHmm = true;
      blinkMarkTime = millis();
    } else if (monkaHmm && millis() > blinkMarkTime + blinkDuration) {
      monkaHmm = false;
    }

    if (monkaHmm) {
      faceCurrent = anime01; // blink with happy expression
    } else {
      faceCurrent = anime05; // happy expression
    }    
  } else if (!monkaS && millis() > botheredMarkTime + botheredTimeout/6) {
    faceCurrent = anime02; // neutral expression
  }

  position.y += sin(millis()) / 2;

}

void pickTarget() {
  target = new PVector(random(margin, width-margin), random(margin, height-margin));
}

 
