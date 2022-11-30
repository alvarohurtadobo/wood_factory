import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/wood/model/kit.dart';

Future<bool> getExtendedKit(int? requestedKitId) async {
  if (DEBUG) {
    return true;
  }
  if (requestedKitId == 0 || requestedKitId == null) {
    return false;
  }
  BackendResponse myRes = await Api.getExtendedKit(requestedKitId);
  if (myRes.status != 200 || !myRes.myBody.containsKey("kit")) {
    return false;
  }
  currentKit = Kit.fromBackendResponse(myRes.myBody["kit"]);
  print("Redeived kit is ${currentKit.toMap()}");
  return true;
}

Future<bool> useKit(int? requestedKitId) async {
  if (DEBUG) {
    return true;
  }
  if (requestedKitId == 0 || requestedKitId == null) {
    return false;
  }
  BackendResponse myRes = await Api.useAndEmpty(requestedKitId);
  if (myRes.status != 204) {
    return false;
  }
  currentKit.usedDatetime = DateTime.now();
  currentKit.amount = 0;
  return true;
}


Future<bool> transformKit(int? requestedKitId) async {
  print("1");
  if (DEBUG) {
    return true;
  }
  print("2");
  if (requestedKitId == 0 || requestedKitId == null) {
    print("Req id: $requestedKitId");
    return false;
  }
  print("3");
  BackendResponse myRes = await Api.transformAndEmpty(requestedKitId);
  print("4");
    print("status ${myRes.status}");
  if (myRes.status != 204) {
    print("204status ${myRes.status}");
    return false;
  }
  print("5");
  currentKit.transformedDatetime = DateTime.now();
  print("6");
  currentKit.amount = 0;
  return true;
}