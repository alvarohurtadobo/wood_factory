import 'package:wood_center/warehouse/model/warehouse.dart';

class Location {
  static int lastId = 0;
  int id = 0;
  String name = "";
  int warehouseId = 0;
  int cityId = 0;

  Location(this.name) {
    lastId++;
    id = lastId;
    warehouseId = warehouseId;
    cityId = warehouseId;
  }

  Location.fromBackendResponse(Map<String, dynamic> myRes) {
    id = myRes["id"] ?? 0;
    name = myRes["name"] ?? "";
    warehouseId = myRes["warehouse_id"] ?? 0;
    cityId =
        myRes["city_id"] ?? 0;
    // "id": 1,
    // "name": "B001",
    // "warehouse_id": 1
  }

  String getName() {
    return name;
  }

  Location.all() {
    id = 0;
    name = "Todos";
  }

  static List<Location> getLocationsForDropDown() {
    List<Location> myDropdownLocations = [Location.all()];
    myDropdownLocations.addAll(myLocations);
    return myDropdownLocations;
  }

  static List<Location> getLocationsForDropDownFilteredByCityId(int? cityId) {
    List<Location> myDropdownoLocations = [Location.all()];
    myDropdownoLocations.addAll(myLocations);
    if (cityId == 0 || cityId == null) {
      return myDropdownoLocations;
    }
    return myDropdownoLocations
        .where((element) => [cityId, 0].contains(element.cityId))
        .toList();
  }

  static List<Location> getLocationsFilteredByCityId(int? cityId) {
    if (cityId == 0 || cityId == null) {
      return myLocations;
    }
    return myLocations.where((element) => element.cityId == cityId).toList();
  }

  @override
  String toString() {
    return "[LOC] $name, [$cityId:$warehouseId]";
  }
}

List<Location> myLocations = [
  Location("A01"),
  Location("A02"),
  Location("B01"),
  Location("B02"),
  Location("C01"),
  Location("C02"),
  Location("C03"),
  Location("D01"),
  Location("D02"),
];
