import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/wood/model/product.dart';

Future<bool> getProductsForCityAndUpdateAllLocalProducts(
    int? requestedCityId) async {
  if (DEBUG) {
    return true;
  }
  if(requestedCityId==0 || requestedCityId== null){
    return true;
  }
  BackendResponse myRes = await Api.getProductsForCity(requestedCityId);
  if (myRes.status != 200 || !myRes.myBody.containsKey("products")) {
    return false;
  }
  List<Product> productsWithCityId = myRes.myBody["products"]
      .map<Product>((prodRes) =>
          Product.fromBackendResponse(prodRes, receivedCityId: requestedCityId))
      .toList();
  List<int> toUpdateIds = productsWithCityId.map((prod) => prod.id).toList();
  myProducts.removeWhere((element) => toUpdateIds.contains(element.id));
  myProducts.addAll(productsWithCityId);
  return true;
}
