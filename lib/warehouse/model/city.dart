class City {
  static int lastId = 0;
  int id = 0;
  String name = "";
  String code = "";
  String country = "";

  City.empty();

  City.fromBackendResponse(Map<String, dynamic> myRes){
    id = myRes["id"]??0;
    name = myRes["name"]??"";
    code = myRes["code"]??"";
    country = myRes["country"]??"";
  }

  City(this.name, this.country) {
    lastId++;
    code = name;
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

  String getName() => name;

  @override
  String toString() {
    return "[CITY] $id, $name, $code";
  }
}

City myCity = City.empty();

List<City> myCities = [
  City("Bogota", "Colombia"),
  City("Medellin", "Colombia"),
  City("Tunja", "Colombia"),
  City("Pereira", "Colombia"),
];
