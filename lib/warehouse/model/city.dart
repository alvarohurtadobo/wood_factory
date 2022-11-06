class City {
  static int lastId = 0;
  int id = 0;
  String name = "";
  String country = "";

  City(this.name, this.country) {
    lastId++;
    id = lastId;
  }

  City.all() {
    id = 0;
    name = "Todos";
  }
}

List<City> myCities = [
  City("Bogota", "Colombia"),
  City("Medellin", "Colombia"),
  City("Tunja", "Colombia"),
  City("Pereira", "Colombia"),
];
