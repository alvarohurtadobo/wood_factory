class Inventory {
  int id = 0;
  String code = "";
  int employeeId = 0;
  int createUserId = 0;
  DateTime inventoryOpenDate = DateTime.now();
  DateTime inventoryCloseDate = DateTime.now();
  String status = "";
  String statusName = "";
  String createUserName = "";

  Inventory(
      this.id,
      this.code,
      this.employeeId,
      this.createUserId,
      this.createUserName,
      this.inventoryOpenDate,
      this.inventoryCloseDate,
      this.status,
      this.statusName);
  Inventory.empty();
}

List<Inventory> myInventories = [
  Inventory(1, "213fsa", 0, 0, "Alvaro", DateTime.now(), DateTime.now(), "OPEN",
      "Abierto"),
  Inventory(
      2,
      "213fsa",
      0,
      0,
      "Alvaro",
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now(),
      "CLOSED",
      "Cerrado"),
  Inventory(
      3,
      "213fsa",
      0,
      0,
      "Daniel",
      DateTime.now().subtract(const Duration(days: 2)),
      DateTime.now().subtract(const Duration(days: 1)),
      "CLOSED",
      "Cerrado"),
  Inventory(
      4,
      "213fsa",
      0,
      0,
      "Alvaro",
      DateTime.now().subtract(const Duration(days: 10)),
      DateTime.now().subtract(const Duration(days: 5)),
      "CLOSED",
      "Cerrado"),
];
Inventory myInventory = Inventory.empty();
