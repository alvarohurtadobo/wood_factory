import 'package:wood_center/common/settings.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/wood/model/woodState.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/warehouse/model/location.dart';

Future<bool> getSettings() async {
  if (DEBUG) {
    // myCities
    // myLines
    await Future.delayed(const Duration(seconds: 1));
    return true;
  } else {
    BackendResponse settingsResponse = await Api.getSettings();
    print("Response is $settingsResponse");
    if (settingsResponse.status!=200){
      return false;
    }
    if (settingsResponse.myBody.containsKey("products")) {
      myProducts = settingsResponse.myBody["products"]
          .map<Product>((prodRes) => Product.fromBackendResponse(prodRes))
          .toList();
    }
    if(settingsResponse.myBody.containsKey("locations")){
      myLocations = settingsResponse.myBody["locations"]
          .map<Location>((locRes) => Location.fromBackendResponse(locRes))
          .toList();
    }
    if(settingsResponse.myBody.containsKey("wood_states")){
      myWoodStates = settingsResponse.myBody["wood_states"]
          .map<WoodState>((stateRes) => WoodState.fromBackendResponse(stateRes))
          .toList();
    }
    return true;
  }
}
