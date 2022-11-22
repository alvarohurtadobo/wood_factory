class Employee {
  static int lastId = 0;
  int id = 0;
  String firstName = "";
  String lastName = "";
  int cityId = 0;
  String nit = "";
  DateTime createdAt = DateTime.now();

  Employee(this.firstName, this.lastName, this.cityId, this.nit) {
    lastId++;
    id = lastId;
    createdAt = DateTime.now();
  }

  String getName()=> "$firstName $lastName";
}

List<Employee> myEmployees = [
  Employee("Ramiro", "Gonzalo", 2, "32132"),
  Employee("Gustavo", "Pérez", 2, "123"),
  Employee("Denisse", "Ramirez", 2, "3454563"),
  Employee("Ariel", "Gonzalo", 3, "2345311")
];
