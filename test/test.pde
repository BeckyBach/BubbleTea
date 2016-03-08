int numBobas = 10;
int numBombs = 3;

PImage[] bobas = new PImage[numBobas];
PImage[] bombs = new PImage[numBombs];

float[] xPosBobas = new float[bobas.length]; //values of x for bobas
float[] yPosBobas = new float[bobas.length]; //values of y for bobas

float[] xPosBombs = new float[bombs.length]; //values of x for bobas
float[] yPosBombs = new float[bombs.length]; //values of y for bobas

int velocityY = 5; //speed bobas fall

void setup() {
  background(0);
  size(450,750);
  frameRate(30);
  
  //load images to bobas
  for (int i = 0; i < bobas.length; i++) {
    bobas[i] = loadImage("ball.jpg");
  }
  
  //load images to bombs
  for (int i = 0; i < bombs.length; i++) {
    bombs[i] = loadImage("bomb.jpg");
  }
}

boolean start = false;

void initBalls() {
  for (int i = 0; i < bobas.length; i++) {
    xPosBobas[i] = randomX(); //init ball x pos
    yPosBobas[i] = randomY(); //init ball y pos
  }
  
  for (int i = 0; i < bombs.length; i++) {
    xPosBombs[i] = randomX(); //init bomb x pos
    yPosBombs[i] = randomY(); //init bomb y pos
  }
  
  start =  true;
}

void draw() {
  background(0);
  
  if (start == false) initBalls();
    
  for (int i = 0; i < bobas.length; i++) {
    image(bobas[i], xPosBobas[i], yPosBobas[i], 50, 50);
    yPosBobas[i] += velocityY;
    
    //when bobas hit the bottom, reinit bobas
    if (yPosBobas[i] > 800) {
      yPosBobas[i] = randomY();
    }
  }  
  
  for (int i = 0; i < bombs.length; i++) {
    image(bombs[i], xPosBombs[i], yPosBombs[i], 50, 50);
    yPosBombs[i] += velocityY;
    
    //when bobas hit the bottom, reinit bobas
    if (yPosBombs[i] > 800) {
      yPosBombs[i] = randomY();
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
  return random(-800, 0);
}