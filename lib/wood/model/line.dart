class Line {
  static int lastId = 0;
  int id = 0;
  String name = "";
  
  Line(this.name) {
    lastId++;
    id = lastId;
  }
}

List<Line> lines = [
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
