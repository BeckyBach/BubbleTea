//currently 1:1 ratio of bombs and bobas
PImage[] bobas = new PImage[5];
PImage[] bombs = new PImage[5];

float[] xPos = new float[5]; //values of x for bobas
float[] yPos = new float[5]; //values of y for bobas
int velocityY = 5; //speed bobas fall

void setup() {
  background(0);
  size(450,750);
  frameRate(30);
  
  //load images to bombs and bobas
  for (int i = 0; i < 5; i++) {
    bobas[i] = loadImage("ball.jpg");
    bombs[i] = loadImage("bomb.jpg");
  }
}

boolean isGone = true;


void initBalls() {
  for (int i = 0; i < 5; i++) {
    xPos[i] = randomX(); //init ball x pos
    yPos[i] = randomY(); //init ball y pos
  }
  
  isGone =  false;
}

void draw() {
  background(0);
  
  if (isGone == true)
    initBalls();
    
  for (int i = 0; i < 5; i++) {
    image(bobas[i], xPos[i], yPos[i], 50, 50);
    yPos[i] += velocityY;
    
    //when bobas hit the bottom, move back to top
    if (yPos[i] == 800) {
      yPos[i] = randomY();
      isGone = true;
    }
  }  
  
  fill(255,0,0);
  rect(mouseX, 600, 107, 178); //cup
}

//return random value between width
float randomX() {
  return random(0, 400);
}

//return random value for y position
float randomY() {
  return random(-100, 0);
}