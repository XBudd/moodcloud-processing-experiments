class saveTable {
  void newTable() {

    Table table  = new Table();
    table.addColumn("id");
    //table.addColumn("hour");
    //table.addColumn("minute");
    table.addColumn("condition");
    table.addColumn("temperature");
    table.addColumn("windSpeed");
    table.addColumn("sunRise");
    table.addColumn("sunSet");
    table.addColumn("dayLight");
  }
  void setRow() {

    TableRow newRow = table.addRow();
    newRow.setInt("id", table.getRowCount() - 1);
    newRow.setString("condition", wg.getWeather());
    newRow.setString("temperature", String.valueOf(wg.getTemp()));
    newRow.setString("windSpeed", String.valueOf(wg.getWindSpeed()));
    newRow.setString("dayLight",String.valueOf( wg.getDayLight()));

    saveTable(table, "data/new.csv");
  }
}

// Sketch saves the following to a file called "new.csv":
// id,species,name
// 0,Panthera leo,Lion
o,Lion

