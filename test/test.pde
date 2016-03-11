/*
*
*  Group: Alvin Manalastas, Becky Bach, Rutuja Nehra
*  BCUSP 161 Win 2016 Final Project
*  Version: March 10, 2016
*
*/
int numBobas = 10;
int numBombs = 3;
int score = 0;
int health = 3;

PImage cup;

PFont font;

PImage[] bobas = new PImage[numBobas];
PImage[] bombs = new PImage[numBombs];

float[] xPosBobas = new float[bobas.length]; //values of x for bobas
float[] yPosBobas = new float[bobas.length]; //values of y for bobas

float[] xPosBombs = new float[bombs.length]; //values of x for bobas
float[] yPosBombs = new float[bombs.length]; //values of y for bobas

float velocityY; //speed bobas fall

void setup() {
  background(0);
  size(450,750);
  frameRate(30);
  font = createFont("pixel.ttf", 24);
  
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
boolean isGameOver = false;

void initBalls() {
  xPosBobas[0] = randomX();
  for (int i = 1; i < bobas.length; i++) {
    float x = randomX();
    if (xPosBobas[i - 1] > (x + 50) && xPosBobas[i - 1] < (x - 50)) x = randomX();
    xPosBobas[i] = x; //init boba x pos
    yPosBobas[i] = randomY(); //init boba y pos
  }
  
  for (int i = 0; i < bombs.length; i++) {
    xPosBombs[i] = randomX(); //init bomb x pos
    yPosBombs[i] = randomY(); //init bomb y pos
  }
  
  start =  true;
}

void draw() { 
  if (health <= 0) isGameOver = true; //game over check

  //game over screen
  if (isGameOver) {
    //replace with game over screen
    fill(0);
    rect(0, 0, 450, 750);
    image(loadImage("game over.png"), 10, 309);
    fill(255);
    
    velocityY = 0; //stop bobas and bombs from falling
    
    text("Score:" + score, 165, 400); //show score
    
    fill(255, 0, 0); //btn color
    rect(125, 550, 200, 75); //try again button
    fill(255);
    text("TRY AGAIN", 155, 595);
     
    //restart game
    if (mouseX > 200 && mouseX < 325 && mouseY > 550 && mouseY < 625) {
      fill(0, 255, 0);
      rect(125, 550, 200, 75);
      fill(255);
      text("TRY AGAIN", 155, 595);
      
      if (mousePressed) {
        isGameOver = false;
        health = 3;
        score = 0;
        start = false;
      }
    }
  }
  
  if (isGameOver == false) {
    background(loadImage("bg.jpg"));
    cup = loadImage("cup.png");
    velocityY = 5;
    
    //display score and health
    fill(255);
    textFont(font);
    text("Score:" + score, 5, 20);
    text("Health:", 5, 40);
    //draw hearts displaying health
    int offset = 30;
    for(int i = 0; i < health; i++) {
      image(loadImage("heart.png"), (offset * i) + 5, 45);
    }
    for(int i = 0; i < 3 - health; i++) {
      image(loadImage("empty-heart.png"), 65 - (offset * i), 45);
    }
    
    if (start == false) initBalls();
      
    for (int i = 0; i < bobas.length; i++) {
      image(bobas[i], xPosBobas[i], yPosBobas[i], 50, 50);
      yPosBobas[i] += velocityY;
      
      //when bobas hit the bottom, reinit bobas
      if (yPosBobas[i] > 800) {
        yPosBobas[i] = randomY();
      }
      
      //if collide with top of basket increment score and reset pos
      if (bobaCupCollide(xPosBobas[i], yPosBobas[i], 50, mouseX-53, 
          510, 107, 10)) {
        yPosBobas[i] = randomY();
        score++;
        cup = loadImage("catch-boba.png");  //set cup to rainbow
      }
    }  
    
    for (int i = 0; i < bombs.length; i++) {
      image(bombs[i], xPosBombs[i], yPosBombs[i], 50, 60);
      yPosBombs[i] += velocityY;
      
      //when bobas hit the bottom, reinit bobas
      if (yPosBombs[i] > 800) {
        yPosBombs[i] = randomY();
      }
      //if collide with top of basket decrement lives
      if (bobaCupCollide(xPosBombs[i], yPosBombs[i], 50, 
          mouseX-53, 510, 107, 10)) {
        yPosBombs[i] = randomY();
        health--;
        cup = loadImage("catch-bomb.png"); //set cup to red
      }
    }  
  
    //make sure cups stays in bounds
    if (mouseX-53 > 0 && mouseX+53 < 450) {
      image(cup, mouseX-53, 500, 107, 178); //cup
    } else if (mouseX-53 < 0) {
      image(cup, 0, 500, 107, 178);
    } else if (mouseX+53 > 450) {
      image(cup, 450-107, 500, 107, 178);
    }
  
  }
}

//return random value between width
float randomX() {
  return random(0, 400);
}

//return random value for y position
float randomY() {
  return random(-800, 0);
}

// --Re-used function from Excercise 10--
// bobaX: is the X position of the ball
// bobaY: is the Y position of the ball
// bobaSize: is the size of the ball
// cupX/Y: is the X/Y position of the paddle
// cupWidth/Height: are the width/Height of the paddle
//
// This function returns the condition if the ball and the
// paddle has collided.
//
boolean bobaCupCollide(float bobaX, float bobaY, float
bobaSize, float cupX, float cupY, float cupWidth,
float cupHeight) {
  float cupMaxX = cupX + cupWidth;
  if (bobaX < cupMaxX) {
    float bobaMaxX = bobaX + bobaSize;
    if (cupX < bobaMaxX) {
      float paddleMaxY = cupY + cupHeight;
      if (bobaY < paddleMaxY) {
        return (cupY < (bobaY + bobaSize));
      }
    }
  }
  return false;
}