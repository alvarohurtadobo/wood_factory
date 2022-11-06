class Product {
  static int lastId = 0;
  int id = 0;
  String code = "";
  String description = "";
  int inventoryTypeId = 0;
  int lineType = 0;

  Product.empty();

  Product(this.code, this.description) {
    lastId++;
    id = lastId;
  }

  Product.all() {
    id = 0;
    code = "Todos";
  }
  String getName(){
    return code;
  }

  static List<Product> getProductListForDropdown() {
    List<Product> myProductsForDropdown = [Product.all()];
    myProductsForDropdown.addAll(myProducts);
    return myProductsForDropdown;
  }
}

List<Product> myProducts = [
  Product("INEF8001", "GRAPA 1 1/2\""),
  Product("INEF8002", "GRAPA 1 3/4\""),
  Product("MPBQ4006", "BLOQUE 150 CM"),
  Product("MPMC5001", "CUARTON 120X14.5X8"),
  Product("MPMC5014", "CUARTON 100X14.5X8"),
];
