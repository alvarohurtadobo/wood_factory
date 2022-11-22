class Pallet {
  static int lastId = 0;
  int id = 0;
  int? productId;
  int? stateId;
  int amount = 0;

  int? locationId;
  int? destinyId;
  int? originalLocationId;

  int? externalProviderId;
  int? employeeId;

  int updatingUserId = 0;

  DateTime createdAt = DateTime.now();

  Pallet.empty();

  // Auxiliar
  String productCode = "";
  String locationName = "";
  String statusName = "";

  Pallet(this.productId, this.originalLocationId, this.stateId, this.amount) {
    lastId++;
    id = lastId;
  }
}

Pallet currentPallet = Pallet.empty();
List<Pallet> myPallets = [
  // Pallet(5, 2.5, 120, 30, "INEF8001", "A1 - Bogotá", "Bueno"),
  // Pallet(7.5, 2.5, 240, 1, "INEF8002", "A2 - Bogotá", "Hongos"),
  // Pallet(10, 5, 320, 5, "INEF8003", "D1 - Bogotá", "Torcido"),
  // Pallet(20, 12.5, 500, 10, "INEF8004", "B1 - Medellín", "Bueno"),
];
