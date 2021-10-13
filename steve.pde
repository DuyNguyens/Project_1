class Steve {
  
  
  boolean monkaW = true;
  PVector position, target;
  PImage faceCurrent, anime02, anime04, anime01, anime05;
  float margin = 50;
  int foodChoice;
  
  boolean monkaS = false;
  int botheredMarkTime = 0;
  int botheredTimeout = 3000; // Processing measures time in milliseconds
  float botheredSpread = 5;
  
  boolean monkaHmm = false;
  int blinkMarkTime = 0;
  int blinkTimeout = 4000;
  int blinkDuration = 250;
  
  boolean isHunting = false;
  
  float triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float movementSpeed = 0.08;
    
  // This is the constructor; it needs to have the same name as the class.
  Steve(float x, float y) {
    position = new PVector(x, y);
    pickEscapeTarget();
    
  anime02 = loadImage("anime02.png");
  anime04 = loadImage("anime04.jpeg");
  anime04.resize(anime02.width, anime02.height);
  anime01 = loadImage("anime01.jpg");
  anime01.resize(anime02.width, anime02.height);
  anime05 = loadImage("anime05.jpeg");
  anime05.resize(anime02.width, anime02.height);
    faceCurrent = anime02;
  }
  
  void update() {
    
    
    if (monkaS) {
      isHunting = false;
      botheredMarkTime = millis();
      faceCurrent = anime04; // worried expression
      if (position.dist(target) < triggerDistance2) {
        pickEscapeTarget();
      }
    } else if (!monkaS && millis() > botheredMarkTime + botheredTimeout) {
      if (!monkaHmm && millis() > blinkMarkTime + blinkTimeout) {
        monkaHmm = true;
        blinkMarkTime = millis();
      } else if (monkaHmm && millis() > blinkMarkTime + blinkDuration) {
        monkaHmm = false;
      }
  
      if (monkaHmm) {
        faceCurrent = anime05; // blink with happy expression
      } else {
        faceCurrent = anime01; // happy expression
      }   
      
      // Steve heads toward food if happy
      if (!isHunting) {
        pickFoodTarget();
        isHunting = true;
      }
    } else if (!monkaS && millis() > botheredMarkTime + botheredTimeout/6) {
      faceCurrent = anime02; // neutral expression
    }
  
    if (monkaS || isHunting) {
      position = position.lerp(target, movementSpeed).add(new PVector(random(-botheredSpread, botheredSpread), random(-botheredSpread, botheredSpread)));
    }
    
    if (isHunting && position.dist(target) < 5) {
      foods[foodChoice].alive = false; 
      pickFoodTarget();
    }
    
    position.y += sin(millis()) / 2;
  }
  
  void draw() {    
    
    if (mousePressed && (mouseButton == LEFT)) { // holding left click will make the picture follow your cursor,
// left click only will make the picture move on its own.
  PVector mousePos = new PVector(mouseX, mouseY);
  monkaS = position.dist(mousePos) < triggerDistance1;
}

if (mousePressed && (mouseButton == RIGHT)) { // right click will make the image heaading towards food.
  PVector mousePos = new PVector(0,0);
  monkaS = position.dist(mousePos) < triggerDistance3;
}
    ellipseMode(CENTER);
    rectMode(CENTER);
    imageMode(CENTER);
  
    image(faceCurrent, position.x, position.y);
  
    if (monkaW) {
    noFill();
    stroke(0, 255, 0);
    if (mousePressed && (mouseButton == LEFT)){
    rect(mouseX,mouseY, triggerDistance1*3, triggerDistance1*2);
    }else{
    rect(position.x,position.y, triggerDistance1*3, triggerDistance1*2);
    }
    if (mousePressed && (mouseButton == LEFT)){
    rect(mouseX, mouseY, triggerDistance2*2, triggerDistance2*2);
    }else{
    rect(position.x,position.y, triggerDistance2*2, triggerDistance2*2);
    }
    if (mousePressed && (mouseButton == LEFT)){
    line(target.x,target.y, mouseX,mouseY);
    }else{
    line(target.x, target.y, position.x, position.y);
    }
    stroke(255, 0, 0);
    if (mousePressed && (mouseButton == LEFT)){
    rect(mouseX,mouseY, 20, 20);
    }else{
    rect(target.x, target.y, 10, 10);
    }
  }
  }
  
  void run() {
    update();
    draw();
  }
  
  void pickEscapeTarget() {
    target = new PVector(random(margin, width-margin), random(margin, height-margin));
  }
  
  void pickFoodTarget() {
    foodChoice = int(random(foods.length));
    if (foods[foodChoice].alive) {
      target = foods[foodChoice].position;
    }
  }
  
}
