class readTable {

  Table table = loadTable("/Users/Budd/Desktop/moodcloud/Research/test_save/data/weatherSheet.csv", "header");

  //println(table.getRowCount() + " total rows in table"); 

  TableRow row = table.getRow(0);

  int id = row.getInt("id");
  String condition = row.getString("condition");
  String temp = row.getString("temp");
  String windSpeed = row.getString("windSpeed");
  String dayLight = row.getString("dayLight");
  String skyColor = row.getString("skyColor");
  
  void printWeather(){
  println(hour() +":"+ minute() + " || " + id + " is currently " + condition + " and " + temp +
    " with windSpeed of " + windSpeed + ", dayLight = " + dayLight + " and skyColor = " + unhex(skyColor));
  }
  // Get the dayLight
  Boolean getDayLight() {
    return Boolean.valueOf(dayLight);
  }
  // Get the skyColor
  color getSkyColor() {
    return unhex(skyColor);
  }

  // Get the temperature
  float getTemp() {
    return Float.parseFloat(temp);
  }

  // Get the weather
  String getWeather() {
    return condition;
  }

  // Get weather's wind speed. All of it!
  float getWindSpeed() {
    return Float.parseFloat(windSpeed);
  }
}

