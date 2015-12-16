// Colin Budd
// 11/26/15
// Based on Daniel Shiffman's Example 18-5
// http://www.learningprocessing.com
Table table;
import gab.opencv.*;
OpenCV opencv;
ArrayList<Contour> contours;
int contoursCount;
PFont f;
String[] zips = { 
  "14850"
};
int counter = 0;
color bg = 255;
// The WeatherGrabber object does the work for us!
WeatherGrabber wg;
skyColor sc;

void setup() {
  size(200, 200);

  // Make a WeatherGrabber object
  wg = new WeatherGrabber(zips[counter]);
  // Tell it to request the weather
  wg.requestWeather();
  sc = new skyColor();
  sc.findSkyColor();


  f = createFont( "Georgia", 16, true);
}
int contourSize() {

  opencv = new OpenCV(this, sc.getImage());
  opencv.gray();
  opencv.threshold(70);
  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  return contours.size();
}

void contoursClear() {
  contours.clear();
}

void draw() {
  background(bg);
  textFont(f);
  fill(0);
  updateSkyColor();

  // Get the values to display
  String weather = wg.getWeather();
  float temp = wg.getTemp();

  //float wind = wg.getWind();

  // Display all the stuff we want to display
  text(zips[counter], 10, 160);
  text(weather, 10, 90);
  text(temp, 10, 40);

  // Draw a little thermometer based on the temperature
  stroke(0);
  fill(175);
  rect(10, 50, int(temp*2), 20);


  noFill();
  strokeWeight(3);

  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();

    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation ().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
}
void mouseClicked() {
  saveTable();
  sc.findSkyColor();
  bg = sc.getSkyColor();
  println(bg);
  background(bg);
}

void updateSkyColor() {

  println("-----new image----");
  println(hour() + ":"+ minute() +":" + second());

  sc.findSkyColor();
  bg = sc.getSkyColor();
}

