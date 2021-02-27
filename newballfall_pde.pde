import processing.sound.*;
SoundFile file, file2;
String audioName = "bgm.mp3";
String path;
String audioName2 = "chi.mp3";
String path2;


import processing.serial.*;
//import ddf.minim.*;
Serial myPort, port2;  // Create object from Serial class
String val, val2;     // Data received from the serial port

PImage ball;
PImage clickk;
PImage background;
PImage naruto; 
PImage laser;
PImage redline;
PImage kaks;
PImage kakb;
PImage go;
int j=0, test = 0;
int z=0;
int x = 0, y = 0, i = 0, flag = 0, flagx = 0, x2 = 0, y2 = 0, fdist, fdist2, len = 1200, lev = 0, f = 0, out = 0; 
String dist, dist2; 
int a = 7; 
int score = 0;
void setup() {
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
  path2 = sketchPath(audioName2);
  file2 = new SoundFile(this, path2);
  size(1400, 1000);
  background(0);
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  String portName2 = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  port2 = new Serial(this, portName2, 9600);
  //ball = loadImage("ball.jpg");
  laser = loadImage("laser.jpg");
  clickk=loadImage("clicktostart.jpeg");
  //naruto = loadImage("naruto.jpg");
  redline = loadImage("redline.gif");
  kaks = loadImage("kaks.png");
  kakb = loadImage("kakb.png");
  go = loadImage("go.jpg");
  func1();
}
void mousePressed() {
  background(0, 0, 0);
  background=loadImage("background.jpeg");
  imageMode(CENTER);
  image(kakb, 700, 500, 1500, 1000);
  //  fill(50,0,0);
  //rect(50,300,240,50);
  //rect(50,365,240,50);
  textSize(50); 
  fill(0, 0, 0);
  text("Instructions: \n 1. Don't get hit by the ball. \n 2. Move the stick to move your player. \n 3. Flash light to fire. \n 4. The bar at the top represents your\n chakra. When the bar goes to zero, the\n game ends. After each level, speed of\n ball increases.\n 5. Survive as long as possible. \nPress 's' to start", 60, 80);
  //text("Click m for multi player",60,395);
}
void keyPressed() {
  if (key=='s' || key=='S') {
    z++;
    out = 0;
    file.stop();
    //changepos();
  } else if (key == 'r' || key == 'R') {
    score = 0; 
    x = 0 ; 
    y = 0 ; 
    i = 0 ; 
    flag = 0 ; 
    flagx = 0 ; 
    x2 = 0 ; 
    y2 = 0 ; 
    len = 1200 ; 
    lev = 0 ;  
    f = 0 ; 
    out = 0 ; 
    a = 7;
    func1();
  }
  /*else if(key==ENTER){             //
   text("LEVEL-2",290,30);    //
   }*/
  /*else if(key=='m' || key == 'M'){
   text("LEVEL-1",400,40);   //1
   z++;
   }*/

  /*else{
   background(255,0,0);
   text("Oops! Invalid Key entered", 165,240);
   text("Click to return", 250,290);
   }*/
}
void draw() {
  if (z==1) {
    changepos();
    delay(1);
  }
}
void func1() {
  imageMode(CENTER);
  image(kaks, 700, 500, 1400, 1000);
  textSize(70);
  text("Click to start", 200, 500, 100);
  textSize(120);
  text("BALL ENIGMA", 200, 300, 100);
  
}
void changepos() {


  background(0, 0, 0);
  //image(bg , 700 , 500 , 1400 , 1000);
  fill(255, 255, 255);
  //text("LEVEL-1",580,40); 
  //image(ball,x,y,90,50);
  image(redline, 700, 60, len, 20);
  textSize(70);
  text(score, 700, 500);
  text("LEVEL " + score/1000, 600, 40);
  if (y > 720)flag = 1;
  if (y < 160)flag = 0;
  if (x > 1390)flagx = 1;
  if (x < 3)flagx = 0;
  if (flag == 0 && flagx == 0) {
    x += a + 10 + 20*(score/1000); 
    y += i; 
    i++;
  } else if (flag == 1 && flagx == 0) {
    x += a + 10 + 20*(score/1000); 
    y -= i; 
    i--;
  } else if (flag == 1 && flagx == 1) {
    x -= a + 10 + 20*(score/1000); 
    y -= i; 
    i--;
  } else if (flag == 0 && flagx == 1) {
    x -= a + 10 + 20*(score/1000); 
    y += i; 
    i++;
  }
  // image(ball,50,60,90,50)
  if ( myPort.available() > 0) 
  {  // If data is available,
    //delay(10);
    dist = myPort.readStringUntil('\n');        
    if (dist != null)fdist = Integer.parseInt(dist.trim());
  } 
  if ( port2.available() > 0) 
  {  // If data is available,
    //delay(10);
    dist2 = port2.readStringUntil('\n');        
    if (dist2 != null)fdist2 = Integer.parseInt(dist2.trim());
  } 
  if ((Math.abs(x - fdist * 25 + 5) < 80) && (y>710) || len == 0) {
    image(go, 700, 500, 1400, 1000); 
    out = 1;
  }
  if (out == 1) {
    image(go, 700, 500, 1400, 1000); 
    out = 1;
    text("Score: " + score + "\nPress R to play again", 700, 400);
    //delay(10000);
  }
  if (out != 1) {
    if (fdist2 > 10) {
      len-=3;
      //file2.play();
      //image(laser , fdist * 20 - 5 , 0 , 32 , 1950);
      image(redline, 700, 60, len, 20);
      if ((Math.abs(x - (fdist * 25 - 5)) < 30)) {
        image(laser, fdist * 25 - 20, y + (745 - y)/2, 32, 745 - y);
        score += 69;
        text(score, 700, 500);
      }
      //image(laser , fdist * 20 - 5 , 0 , 32 , 1950);
    }
    if (fdist2 > 10) {
      if (!(Math.abs(x - (fdist * 25 - 5)) < 30))image(laser, fdist * 25 - 20, -230, 32, 1950);
    }
    //else file2.stop();


    //if(score > 200 && f == 2)
    image(laser, fdist * 25, 6500, 6500, 10);
    naruto = loadImage("naruto.png");
    image(naruto, fdist * 25, 780, 180, 180);
    //image(ball , x , y , 140 , 90);
    stroke(255);
    fill(78, 56, 34);
    ellipse(x, y, 70, 70);
  }
}
