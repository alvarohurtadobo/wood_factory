import 'package:wood_center/warehouse/model/city.dart';

class Warehouse {
  static int lastId = 0;
  int id = 0;
  String name = "";
  String mapUrl = "";
  int cityId = 0;

  // Auxiliar
  String cityName = "";
  String countryName = "";

  Warehouse(this.name) {
    lastId++;
    id = lastId;
    cityId = id % myCities.length;
    // cityName = myCities.where((element) => element.id == cityId).first.name;
    // countryName =
    //     myCities.where((element) => element.id == cityId).first.country;
  }

  Warehouse.fromBackendResponse(Map<String, dynamic> myRes) {
    id = myRes["id"] ?? 0;
    name = myRes["name"] ?? "";
    cityId = myRes["city_id"] ?? 0;
    mapUrl = myRes["map_url"] ?? "";
    cityName = myRes["city_name"] ?? "";
  }

  String getName() {
    return "$name - $cityName";
  }

  Warehouse.all() {
    id = 0;
    name = "Todos";
  }

  static List<Warehouse> getWarehousesForDropDown() {
    List<Warehouse> myDropdownWarehouses = [Warehouse.all()];
    myDropdownWarehouses.addAll(myWarehouses);
    return myDropdownWarehouses;
  }

  static List<Warehouse> getWarehousesForDropDownFilteredByCityId(int? cityId) {
    List<Warehouse> myDropdownWarehouses = [Warehouse.all()];
    myDropdownWarehouses.addAll(myWarehouses);
    if (cityId == 0 || cityId == null) {
      return myDropdownWarehouses;
    }
    return myDropdownWarehouses
        .where((element) => [cityId, 0].contains(element.cityId))
        .toList();
  }
}

List<Warehouse> myWarehouses = [
  Warehouse("A1"),
  Warehouse("A2"),
  Warehouse("B1"),
  Warehouse("B2"),
  Warehouse("C1"),
  Warehouse("C2"),
  Warehouse("C3"),
  Warehouse("D1"),
  Warehouse("D2"),
  Warehouse("D3"),
  Warehouse("D4"),
];
