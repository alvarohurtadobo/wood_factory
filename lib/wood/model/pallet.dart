import 'package:wood_center/user/model/user.dart';

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

  Pallet.empty(){
    updatingUserId = myUser.id;
  }

  // Auxiliar
  String productCode = "";
  String locationName = "";
  String statusName = "";

  Pallet(this.productId, this.originalLocationId, this.stateId, this.amount) {
    lastId++;
    id = lastId;
  }

  Map<String, dynamic> toMap(){
    return {
      "product_id": productId,
      "state_id": stateId,
      "amount":amount,
      "location_id": locationId,
      "destiny_location_id":destinyId,
      "original_location_id": originalLocationId,
      "external_provider_id": externalProviderId,
      "employee_id": employeeId,
      "updating_user_id":updatingUserId,
      
    };
    // "product_id": 2,
    // "state_id": 2,
    // "amount": 200,
    // "location_id": 1,
    // "destiny_location_id": 2,
    // "original_location_id": null,
    // "external_provider_id": 1,
    // "employee_id": null,
    // "updating_user_id": 2,
    // "created_at": "2022-11-22T01:09:32Z",
    // "updated_at": "2022-11-22T01:09:32Z"
  }
}

Pallet currentPallet = Pallet.empty();
List<Pallet> myPallets = [
  // Pallet(5, 2.5, 120, 30, "INEF8001", "A1 - Bogotá", "Bueno"),
  // Pallet(7.5, 2.5, 240, 1, "INEF8002", "A2 - Bogotá", "Hongos"),
  // Pallet(10, 5, 320, 5, "INEF8003", "D1 - Bogotá", "Torcido"),
  // Pallet(20, 12.5, 500, 10, "INEF8004", "B1 - Medellín", "Bueno"),
];
