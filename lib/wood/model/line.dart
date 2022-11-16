class Line {
  static int lastId = 0;
  int id = 0;
  String name = "";
  
  Line(this.name) {
    lastId++;
    id = lastId;
  }

  Line.all(){
    id=0;
    name="Todas";
  }

  String getName() => name;

  static List<Line> getLineListForDropdown() {
    List<Line> myLinesForDropdown = [Line.all()];
    myLinesForDropdown.addAll(demoLines);
    return myLinesForDropdown;
  }
}

List<Line> demoLines = [
  Line("ELEMENTO DE FIJACIÓN"),
  Line("BOQUE"),
  Line("CUARTONES"),
  Line("TROZA"),
  Line("ESTIBAS"),
  Line("ESTIBAS USADAS"),
  Line("REPISAS"),
  Line("TABLAS"),
  Line("TACOS"),
  Line("HUACAL"),
  Line("MARCOS"), 
  Line("PRODUCTOS POR REPARACION"),
];
