class Product {
  static int lastId = 0;
  int id = 0;
  String code = "";
  String name = "";
  int inventoryTypeId = 0;
  int lineId = 0;

  bool isWood = false;
  double? length;
  double? width;
  double? height;
  String? species;

  Product.empty();

  // Auxiliar
  int cityId = 0;

  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();

  Product(this.code, this.name, this.isWood) {
    lastId++;
    id = lastId;
  }

  Product.fromBackendResponse(Map<String, dynamic> myRes, {int receivedCityId = 0}) {
    id = myRes["id"] ?? 0;
    name = myRes["name"] ?? "";
    code = myRes["code"] ?? "";
    inventoryTypeId = myRes["inventory_type_id"] ?? 0;
    lineId = myRes["line_id"] ?? 0;
    isWood = myRes["is_wood"] ?? false;
    length = double.tryParse(myRes["length"]??"0.0") ?? 0.00;
    width = double.tryParse(myRes["width"]??"0.0") ?? 0.00;
    height = double.tryParse(myRes["height"]??"0.0") ?? 0.00;
    species = myRes["species"];
    createdAt = DateTime.tryParse(myRes["created_at"]);
    updatedAt = DateTime.tryParse(myRes["updated_at"]);
    cityId = receivedCityId;
  }

  Product.all() {
    id = 0;
    code = "Todos";
  }
  String getName() {
    return "$code - $name";
  }

  static List<Product> getProductListForDropdown() {
    List<Product> myProductsForDropdown = [Product.all()];
    myProductsForDropdown.addAll(myProducts);
    return myProductsForDropdown;
  }

  static List<Product> getProductListForDropdownFilteredByLineIdAndCityId(int? lineId, int? cityId) {
    List<Product> myProductsForDropdown = [Product.all()];
    List<Product> filteredProducts = Product.getProductListFilteredByLineIdAndCityId(lineId, cityId);
    myProductsForDropdown.addAll(filteredProducts);
    return myProductsForDropdown;
  }

  static List<Product> getProductListFilteredByLineIdAndCityId(int? lineId, int? cityId) {
    List<Product> myProductsForDropdown = myProducts;
    if (lineId != 0 && lineId != null) {
      myProductsForDropdown =  myProductsForDropdown
        .where((thisProduct) => thisProduct.lineId==lineId)
        .toList();
    }
    if (cityId != 0 && cityId != null) {
      myProductsForDropdown =  myProductsForDropdown
        .where((thisProduct) => thisProduct.cityId==cityId)
        .toList();
    }
    return myProductsForDropdown;
  }
}

Product currentProduct = Product.empty();

List<Product> myProducts = [
  Product("INEF8001", "dGRAPA 1 1/2\"", false),
  Product("INEF8002", "dGRAPA 1 3/4\"", true),
  Product("MPBQ4006", "dBLOQUE 150 CM", false),
  Product("MPMC5001", "dCARTON 120X14.5X8", true),
  Product("MPMC5014", "dCARTON 100X14.5X8", true),
];
