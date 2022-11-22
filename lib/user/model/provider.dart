class Provider {
  static int lastId = 0;
  int id = 0;
  String firstName = "";
  String lastName = "";
  int cityId = 0;
  String nit = "";
  DateTime createdAt = DateTime.now();

  Provider(this.firstName, this.lastName, this.cityId, this.nit) {
    lastId++;
    id = lastId;
    createdAt = DateTime.now();
  }

  String getName()=> "$firstName $lastName";
}

List<Provider> myProviders = [
  Provider("Alejandra", "Gonzalo", 2, "32132"),
  Provider("Alex", "Pérez", 2, "123"),
  Provider("David", "Ramirez", 2, "3454563"),
  Provider("Stanley", "Gonzalo", 3, "2345311")
];
