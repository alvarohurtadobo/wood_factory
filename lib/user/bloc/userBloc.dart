import 'package:wood_center/common/settings.dart';
import 'package:wood_center/user/model/role.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/warehouse/model/city.dart';


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
    if(myUser.id==0|| myRole.id==0||myCity.id==0){
      return false;
    }
    return true;
  }

  return false;
}

Future<bool> loginWithEmail(String email) async {
  if (DEBUG) {
    myUser = demoUsers.firstWhere(
        (usr) => usr.email == email, orElse: () {
      return User.empty();
    });
    myRole = myRoles.firstWhere((role) => role.id == myUser.roleId, orElse: () {
      return Role(0, "Error");
    });
    myCity = myCities.firstWhere((cit) => cit.id == myUser.cityId, orElse: () {
      return City.empty();
    });
    await Future.delayed(const Duration(seconds: 1));
    if(myUser.id==0|| myRole.id==0||myCity.id==0){
      return false;
    }
    return true;
  }

  return false;
}

