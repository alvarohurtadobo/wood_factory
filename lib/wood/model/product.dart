class Product {
  static int lastId = 0;
  int id = 0;
  String code = "";
  String name = "";
  int inventoryTypeId = 0;
  int lineType = 0;

  bool is_wood=false;
  double? length;
  double? width ;
  double? height ;
  String? species;

  Product.empty();

  Product(this.code, this.name, this.is_wood) {
    lastId++;
    id = lastId;
  }

  Product.all() {
    id = 0;
    code = "Todos";
  }
  String getName(){
    return "$code - $name";
  }

  static List<Product> getProductListForDropdown() {
    List<Product> myProductsForDropdown = [Product.all()];
    myProductsForDropdown.addAll(myProducts);
    return myProductsForDropdown;
  }
}

Product currentProduct = Product.empty();

List<Product> myProducts = [
  Product("INEF8001", "GRAPA 1 1/2\"", false),
  Product("INEF8002", "GRAPA 1 3/4\"", true),
  Product("MPBQ4006", "BLOQUE 150 CM", false),
  Product("MPMC5001", "CUARTON 120X14.5X8", true),
  Product("MPMC5014", "CUARTON 100X14.5X8", true),
];
