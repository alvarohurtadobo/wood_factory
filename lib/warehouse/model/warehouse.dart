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
  String getName() {
    return "$name - Bogota";
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
