import 'package:wood_center/common/settings.dart';
import 'package:wood_center/user/model/role.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/repository/api.dart';

Future<bool> login(String email, String password) async {
  if (DEBUG) {
    myUser = demoUsers.firstWhere(
        (usr) => usr.email == email && usr.password == password, orElse: () {
      return User.empty();
    });
    myRole = myRoles.firstWhere((role) => role.id == myUser.roleId, orElse: () {
      return Role(0, "Error");
    });
    myCity = myCities.firstWhere((cit) => cit.id == myUser.cityId, orElse: () {
      return City.empty();
    });
    await Future.delayed(const Duration(seconds: 1));
    if (myUser.id == 0 || myRole.id == 0 || myCity.id == 0) {
      return false;
    }
    return true;
  }

  BackendResponse myResponse = await Api.login(email, password);
  print(myResponse.myBody);
  if (myResponse.status == 200) {
    if (myResponse.myBody.containsKey("user")) {
      myUser = User.fromBackendResponse(myResponse.myBody["user"]);
      print("My recovered user is $myUser");
    }
    if (myResponse.myBody.containsKey("token")) {
      token = myResponse.myBody["token"];
      print("Recovered token is $token");
    }
    if (myResponse.myBody.containsKey("role")) {
      myRole = Role.fromBackendResponse(myResponse.myBody["role"]);
      print("Recovered role is $myRole");
    }
    if (myResponse.myBody.containsKey("city")) {
      myCity = City.fromBackendResponse(myResponse.myBody["city"]);
      print("Recovered city is $myCity");
    }
    if (myResponse.myBody.containsKey("cities")) {
      myCities = myResponse.myBody["cities"]
          .map<City>((cityRes) => City.fromBackendResponse(cityRes))
          .toList();
      print("Recovered cities are $myCities");
    }
    if (myResponse.myBody.containsKey("lines")) {
      myLines = myResponse.myBody["lines"]
          .map<Line>((lineRes) => Line.fromBackendResponse(lineRes))
          .toList();
      print("Recovered lines are $myLines");
    }
    return true;
  }

  return false;
}

Future<bool> loginWithEmail(String email) async {
  if (DEBUG) {
    myUser = demoUsers.firstWhere((usr) => usr.email == email, orElse: () {
      return User.empty();
    });
    myRole = myRoles.firstWhere((role) => role.id == myUser.roleId, orElse: () {
      return Role(0, "Error");
    });
    myCity = myCities.firstWhere((cit) => cit.id == myUser.cityId, orElse: () {
      return City.empty();
    });
    await Future.delayed(const Duration(seconds: 1));
    if (myUser.id == 0 || myRole.id == 0 || myCity.id == 0) {
      return false;
    }
    return true;
  }
  BackendResponse myResponse = await Api.loginEmail(email);
  if (myResponse.status == 200) {
    if (myResponse.myBody.containsKey("user")) {
      myUser = User.fromBackendResponse(myResponse.myBody["user"]);
      print("My recovered user is $myUser");
    }
    if (myResponse.myBody.containsKey("token")) {
      token = myResponse.myBody["token"];
      print("Recovered token is $token");
    }
    if (myResponse.myBody.containsKey("role")) {
      myRole = Role.fromBackendResponse(myResponse.myBody["role"]);
      print("Recovered role is $myRole");
    }
    if (myResponse.myBody.containsKey("city")) {
      myCity = City.fromBackendResponse(myResponse.myBody["city"]);
      print("Recovered city is $myCity");
    }
    if (myResponse.myBody.containsKey("cities")) {
      myCities = myResponse.myBody["cities"]
          .map<City>((cityRes) => City.fromBackendResponse(cityRes))
          .toList();
      print("Recovered cities are $myCities");
    }
    if (myResponse.myBody.containsKey("lines")) {
      myLines = myResponse.myBody["lines"]
          .map<Line>((lineRes) => Line.fromBackendResponse(lineRes))
          .toList();
      print("Recovered lines are $myLines");
    }
    return true;
  }

  return false;
}
