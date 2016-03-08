int numBobas = 10;
int numBombs = 3;
int score = 0;
int health = 3;

PImage cup;

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
  
  cup = loadImage("cup.png");
  
  //load images to bobas
  for (int i = 0; i < bobas.length; i++) {
    bobas[i] = loadImage("boba.png");
  }
  
  //load images to bombs
  for (int i = 0; i < bombs.length; i++) {
    bombs[i] = loadImage("bomb.png");
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
  background(loadImage("bg.jpg"));
  
  if (start == false) initBalls();
    
  for (int i = 0; i < bobas.length; i++) {
    image(bobas[i], xPosBobas[i], yPosBobas[i], 50, 50);
    yPosBobas[i] += velocityY;
    
    //when bobas hit the bottom, reinit bobas
    if (yPosBobas[i] > 800) {
      yPosBobas[i] = randomY();
    }
    
    //if collide with top of basket increment score and reset pos
    if (ballPaddleCollide(xPosBobas[i], yPosBobas[i], 50, mouseX, 510, 107, 50)) {
      yPosBobas[i] = randomY();
      score++;
    }
  }  
  
  for (int i = 0; i < bombs.length; i++) {
    image(bombs[i], xPosBombs[i], yPosBombs[i], 50, 60);
    yPosBombs[i] += velocityY;
    
    //when bobas hit the bottom, reinit as
    if (yPosBombs[i] > 800) {
      yPosBombs[i] = randomY();
    }
    //if collide with top of basket decrement lives
    if (ballPaddleCollide(xPosBombs[i], yPosBombs[i], 50, mouseX, 510, 107, 50)) {
      yPosBombs[i] = randomY();
      health--;
    }
  }  
  
  fill(255,0,0);
  image(cup, mouseX, 500, 107, 178); //cup
  
  //display score and health
  fill(255);
  text("Score:" + score, 10, 10);
  text("Health:" + health, 10, 20);
}

//return random value between width
float randomX() {
  return random(0, 400);
}

//return random value for y position
float randomY() {
  return random(-800, 0);
}

//
// ballX: is the X position of the ball
// ballY: is the Y position of the ball
// ballSize: is the size of the ball
// paddleX/Y: is the X/Y position of the paddle
// paddleWidth/Height: are the width/Height of the paddle
//
// This function returns the condition if the ball and the
// paddle has collided.
//
boolean ballPaddleCollide(float ballX, float ballY, float
ballSize, float paddleX, float paddleY, float paddleWidth,
float paddleHeight) {
  float paddleMaxX = paddleX + paddleWidth;
  if (ballX < paddleMaxX) {
    float ballMaxX = ballX + ballSize;
    if (paddleX < ballMaxX) {
      float paddleMaxY = paddleY + paddleHeight;
      if (ballY < paddleMaxY) {
        return (paddleY < (ballY + ballSize));
      }
    }
  }
  return false;
}