import 'package:wood_center/user/model/user.dart';

class Kit {
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

  String describe() {
    return "[PROD] $id, product: $productId, location: $locationId, state: $stateId, amount: $amount, origin: $originalLocationId, employee: $employeeId, provider: $externalProviderId";
  }

  Kit.empty() {
    updatingUserId = myUser.id;
  }

  // Auxiliar
  String productCode = "";
  String productName = "";
  bool productIsWood = false;
  String locationName = "";
  String warehouseName = "";
  String woodStatusName = "";
  double productLength = 0;
  double productWidth = 0;
  double productHeight = 0;

  bool isFromExternalProvider() {
    return externalProviderId !=
        null; // ||(employeeId == null && originalLocationId == null) ;
  }

  Kit.fromBackendResponse(Map<String, dynamic> myRes) {
    id = myRes["id"] ?? 0;
    amount = myRes["amount"];
    productId = myRes["product_id"] ?? 0;
    stateId = myRes["state_id"] ?? 0;
    locationId = myRes["location_id"] ?? 0;
    destinyId = myRes["destiny_location_id"];
    originalLocationId = myRes["original_location_id"];
    externalProviderId = myRes["external_provider_id"];
    employeeId = myRes["employee_id"];
    updatingUserId = myRes["updating_user_id"] ?? 0;
    productHeight = double.tryParse(myRes["product_height"]) ?? 0.0;
    productWidth = double.tryParse(myRes["product_width"]) ?? 0.0;
    productLength = double.tryParse(myRes["product_length"]) ?? 0.0;
    productCode = myRes["product_code"] ?? "";
    productName = myRes["product_name"] ?? "";
    productIsWood = myRes["product_is_wood"] ?? "";
    locationName = myRes["location_name"] ?? "";
    warehouseName = myRes["warehouse_name"] ?? "";
    woodStatusName = myRes["wood_state_name"] ?? "";
    // "id": 3,
    // "amount": 200,
    // "created_at": "2022-11-25T17:26:21.394758Z",
    // "updated_at": "2022-11-25T17:26:21.394791Z",
    // "state_id": 2,
    // "destiny_location_id": 2,
    // "original_location_id": null,
    // "external_provider_id": 1,
    // "employee_id": null,
    // "updating_user_id": 2,
    // "product_name": "GRAPA 1 3/4",
    // "product_length": "0.00",
    // "product_width": "0.00",
    // "product_height": "0.00",
    // "location_name": "B001"
  }

  Kit(this.productId, this.originalLocationId, this.stateId, this.amount) {
    lastId++;
    id = lastId;
  }

  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "state_id": stateId,
      "amount": amount,
      "location_id": locationId,
      "destiny_location_id": destinyId,
      "original_location_id": originalLocationId,
      "external_provider_id": externalProviderId,
      "employee_id": employeeId,
      "updating_user_id": updatingUserId,
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

Kit currentKit = Kit.empty();
List<Kit> myKits = [
  // Kit(5, 2.5, 120, 30, "INEF8001", "A1 - Bogotá", "Bueno"),
  // Kit(7.5, 2.5, 240, 1, "INEF8002", "A2 - Bogotá", "Hongos"),
  // Kit(10, 5, 320, 5, "INEF8003", "D1 - Bogotá", "Torcido"),
  // Kit(20, 12.5, 500, 10, "INEF8004", "B1 - Medellín", "Bueno"),
];
