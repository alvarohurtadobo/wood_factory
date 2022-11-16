import 'package:wood_center/common/settings.dart';
import 'package:wood_center/warehouse/model/city.dart';

Future<bool> getSettings() async {
  if (DEBUG) {
    // myCities
    // myLines
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
  return false;
}
