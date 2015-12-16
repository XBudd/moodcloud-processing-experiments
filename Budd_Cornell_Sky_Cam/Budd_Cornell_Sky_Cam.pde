/**
 * Colin Budd
 * Cornell University
 * Dec 9, 2015
 */
import gab.opencv.*;
OpenCV opencv;
PImage img; 
PImage cropImg;
PImage cornerCropImg;
float min = minute();
int time;
boolean evenOdd = true; //start with assumption that assuming that it is even for sky
int wait = 250;

ArrayList<Contour> contours;
int contoursCount;


void setup() {
  size(1350, 550);
  time = millis(); // store current time;
 
  // The image file must be in the data folder of the current sketch 
  // to load successfully

  img = loadImage("http://cs1.pixelcaster.com/cornell/cornell.jpg");  // Load the image into the program  
  cropImg = img.get(400, 0, 1150, 350); //get sky
  opencv = new OpenCV(this, cropImg);

  opencv.gray();
  opencv.threshold(70);
  background(getAverageColor(cropImg));
  contours = opencv.findContours();
  contoursCount = contours.size();
  println("found " + contours.size() + " contours");
}

void draw() {
  //get current minute
  min = minute();
  int sec = second();
  int x;
  if (evenOdd) {
    x = 0; //even
  } else {
    x = 1; //odd
  } 
  if (min % 2 == x && sec == 5) {
    println("-----new image----");
    println(hour() + ":"+ minute() +":" + second());
    img = loadImage("http://cs1.pixelcaster.com/cornell/cornell.jpg"); 
    cropImg = img.get(400, 0, 1150, 350); //get sky

    //clear arraylist
   // contours.clear();
    contours = opencv.findContours();
    println("found " + contours.size() + " contours");
    cornerCropImg = cropImg.get(1130, 330, 20, 20); //get corner
    image(cornerCropImg, 0, 0);

    if (contours.size() > contoursCount) {
      println("this image has MORE contours....changing evenOdd val...");
      evenOdd = !evenOdd;
      println ("even?  = " + evenOdd);
    } else { //correct image laoded

      background(getAverageColor(cropImg));
      println("color: " + getAverageColor(cropImg));
      contoursCount = contours.size();
      println("this image has LESS contours");
    }

   
  }


  // Displays the image at its actual size at point (0,0)

  // Displays the image at point (0, height/2) at half of its size
  //image(img, 0, height/2, img.width/2, img.height/2);

  image(cropImg, 100, 100);
 
}


color getAverageColor(PImage img) {
  img.loadPixels();

  int r = 0, g = 0, b = 0;
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;


  return color(r, g, b);
}