class Pallet {
  static int lastId = 0;
  int id = 0;
  int productId = 0;
  int locationId = 0;
  int destinyId = 0;
  int stateId = 0;
  double width = 0;
  double height = 0;
  double length = 0;
  int amount = 0;

  Pallet.empty();

  // Auxiliar
  String productCode = "";
  String locationName = "";
  String statusName = "";

  Pallet(this.width, this.height, this.length, this.amount, this.productCode,
      this.locationName, this.statusName) {
    lastId++;
    id = lastId;
  }
}

Pallet currentPallet = Pallet.empty();
List<Pallet> myPallets = [
  Pallet(5, 2.5, 120, 30, "INEF8001", "A1 - Bogotá", "Bueno"),
  Pallet(7.5, 2.5, 240, 1, "INEF8002", "A2 - Bogotá", "Hongos"),
  Pallet(10, 5, 320, 5, "INEF8003", "D1 - Bogotá", "Torcido"),
  Pallet(20, 12.5, 500, 10, "INEF8004", "B1 - Medellín", "Bueno"),
];
