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

  Line.fromBackendResponse(Map<String, dynamic> myRes){
    id = myRes["id"]??0;
    name = myRes["name"]??"";
  }

  String getName() => name;

  @override
  String toString() {
    return "[LINE] $id, $name";
  }

  static List<Line> getLineListForDropdown() {
    List<Line> myLinesForDropdown = [Line.all()];
    myLinesForDropdown.addAll(myLines);
    return myLinesForDropdown;
  }
}

List<Line> myLines = [Line("ELEMENTO DE FIJACIÓN"),
  Line("BLOQUE"),
  Line("CUARTONES"),
  Line("TROZA"),
  Line("ESTIBAS"),
  Line("ESTIBAS USADAS"),
  Line("REPISAS"),
  Line("TABLAS"),
  Line("TACOS"),
  Line("HUACAL"),
  Line("MARCOS"), 
  Line("PRODUCTOS POR REPARACION"),];
