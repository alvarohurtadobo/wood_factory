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

  String updatingUserFirstName = "";
  String updatingUserLastName = "";

  DateTime createdAt = DateTime.now();

  // Ultimate version
  String providerFirstName = "";
  String providerLastName = "";
  String employeeFirstName = "";
  String employeeLastName = "";

  String originalLocationName = "";
  String productSpecies = "";

  DateTime? usedDatetime;
  DateTime? transformedDatetime;

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
  int? sourceKitId;

  bool isFromExternalProvider() {
    return externalProviderId !=
        null; // ||(employeeId == null && originalLocationId == null) ;
  }

  Kit.copy(Kit oldKit) {
    id = oldKit.id;
    amount = oldKit.amount;
    productId = oldKit.productId;
    stateId = oldKit.stateId;
    locationId = oldKit.locationId;
    destinyId = oldKit.destinyId;
    originalLocationId = oldKit.originalLocationId;
    externalProviderId = oldKit.externalProviderId;
    employeeId = oldKit.employeeId;
    updatingUserId = oldKit.updatingUserId;
    productHeight = oldKit.productHeight;
    productWidth = oldKit.productWidth;
    productLength = oldKit.productLength;
    productCode = oldKit.productCode;
    productName = oldKit.productName;
    productIsWood = oldKit.productIsWood;
    locationName = oldKit.locationName;
    warehouseName = oldKit.warehouseName;
    woodStatusName = oldKit.woodStatusName;
    // Ultimate version
    providerFirstName = oldKit.providerFirstName;
    providerLastName = oldKit.providerLastName;
    employeeFirstName = oldKit.employeeFirstName;
    employeeLastName = oldKit.employeeLastName;

    originalLocationName = oldKit.originalLocationName;
    productSpecies = oldKit.productSpecies;
    sourceKitId = oldKit.sourceKitId;
    transformedDatetime =oldKit.transformedDatetime;
    usedDatetime = oldKit.usedDatetime;
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
    // Ultimate version
    providerFirstName = myRes["external_provider_first_name"] ?? "";
    providerLastName = myRes["external_provider_last_name"] ?? "";
    employeeFirstName = myRes["employee_first_name"] ?? "";
    employeeLastName = myRes["employee_last_name"] ?? "";

    originalLocationName = myRes["original_location_name"] ?? "";
    productSpecies = myRes["product_species"] ?? "";
    sourceKitId = myRes["source_kit_id"];
    transformedDatetime =
        DateTime.tryParse(myRes["transformed_at_datetime"] ?? "");
    usedDatetime = DateTime.tryParse(myRes["used_at_datetime"] ?? "");


    updatingUserFirstName = myRes["updating_user_first_name"] ?? "";
    updatingUserLastName = myRes["updating_user_last_name"] ?? "";
    print("Updating user is $updatingUserFirstName, $updatingUserLastName");

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
      "source_kit_id": sourceKitId
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
