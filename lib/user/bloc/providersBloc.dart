import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';

Future<bool> updateEmployeesAndProviders() async {
  if (DEBUG) {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  BackendResponse myRes = await Api.getEmployees();
  if (myRes.status == 200) {
    if (myRes.myBody.containsKey("employees")) {
      myEmployees = myRes.myBody["employees"]
          .map<Employee>((emp) => Employee.fromBackendResponse(emp))
          .toList();
    }
  }

  myRes = await Api.getProviders();
  if (myRes.status == 200) {
    if (myRes.myBody.containsKey("providers")) {
      myProviders = myRes.myBody["providers"]
          .map<Provider>((emp) => Provider.fromBackendResponse(emp))
          .toList();
    }
  }

  return true;
}
