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
  return true;
}
