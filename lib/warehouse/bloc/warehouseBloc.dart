import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';

Future<bool> getAllWarehouses() async {
  if (DEBUG) {
    return true;
  }
  BackendResponse myRes = await Api.getAllWarehouses();
  if (myRes.status != 200 || !myRes.myBody.containsKey("warehouses")) {
    return false;
  }
  myWarehouses = myRes.myBody["warehouses"]
      .map<Warehouse>((w) => Warehouse.fromBackendResponse(w))
      .toList();
  return true;
}
