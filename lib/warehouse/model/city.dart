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

  static List<City> getCitiesForDropDown() {
    List<City> myDropdownCities = [City.all()];
    myDropdownCities.addAll(myCities);
    return myDropdownCities;
  }

  String getName()=> name;
}

List<City> myCities = [
  City("Bogota", "Colombia"),
  City("Medellin", "Colombia"),
  City("Tunja", "Colombia"),
  City("Pereira", "Colombia"),
];
