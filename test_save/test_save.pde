/* Colin Budd
 * December 15, 2015
 * Cornell University
 */

import java.io.BufferedWriter;
import java.text.*;
import java.io.FileWriter;
import processing.net.*;
import gab.opencv.*;
OpenCV opencv;
ArrayList<Contour> contours;
int contoursCount;
// The WeatherGrabber object does the work for us!
WeatherGrabber wg;
skyColor sc;
readTable rt;

int x = 0;
void setup() {
  size(200, 200);

  wg = new WeatherGrabber("14850");  
  sc = new skyColor();
  rt = new readTable();
  sc.findSkyColor();
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
}
void writeFile() {
  try {
    //FILE SAVE DATA (change the path from below)
    String filename = "/Users/Budd/Desktop/moodcloud/Research/test_save/data/weatherSheet.csv";
    boolean newFile=false;
    File f = new File(filename);

    FileWriter writer = new FileWriter(f);         

    int count = 0;
    try {
      wg.requestWeather();
      sc.findSkyColor();

      try {
        writer.write("id,condition,temp,windSpeed,dayLight,skyColor,\n");
        String[] data = new String[6];             
        data[0] = ""+x; 
        data[1] = wg.getWeather(); 
        data[2] = String.valueOf(wg.getTemp()); 
        data[3] = String.valueOf(wg.getWindSpeed());
        data[4] = String.valueOf(wg.getDayLight()); 
        data[5] = String.valueOf(sc.getSkyColor());
        println(String.valueOf(sc.getSkyColor()));
        //this if case will fill the array just if the search is null               
        if (data[0] ==null) {
          data[0] = ""; 
          data[1] = ""; 
          data[2] = ""; 
          data[3] = ""; 
          data[4] = "";
          data[5] = "";
        }             

        for (int k=0; k < data.length; k++) {
          writer.write(data[k] + ",");
          x++;
        }
        writer.write("\n");
        writer.write("\n");
        writer.flush();
      } 
      catch(NullPointerException e) {
        println("Null");
      }
    }
    catch(NullPointerException e) {
      println("Null");
    }
  }
  catch (IOException ioe) {
    println("IO/ERROR: " + ioe);
  }
}
void mouseClicked() {
  writeFile();
  background(sc.getSkyColor());
  rt.printWeather();
}

void requestData() {
  String url = "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=KITH";
  String[] lines = loadStrings(url);

  // Turn array into one long String
  String xml = join(lines, "" ); 
  println(xml);
  saveStrings("weather.text", lines);
}

