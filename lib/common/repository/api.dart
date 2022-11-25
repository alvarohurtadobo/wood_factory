import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wood_center/wood/model/pallet.dart';

const String serverUrl = "http://10.0.2.2:8000/";

// const String apiPath = "api/v1/";
const String apiPath = "api/v1/";
String finalUrl = serverUrl + apiPath;
String currentToken = "";

var dio = Dio();

Map<String, String> _getHeaderInvoice(String license) {
  return {"license-key": license, "Content-Type": "application/json"};
}

Map<String, String> _getHeader() {
  if (currentToken == "") {
    return {"Content-Type": "application/json"};
  }
  return {
    "Authorization": "Bearer $currentToken",
    "Content-Type": "application/json"
  };
}

class BackendResponse {
  int status = 0;
  Map myBody = {};
  BackendResponse({this.status = 999, this.myBody = const {}});
  @override
  String toString() {
    return "[RES $status] $myBody";
  }
}

class Api {
  static Future<BackendResponse> _get(String path) async {
    finalUrl = serverUrl + apiPath + path;

    Response response = await dio.get(
        finalUrl); // options: Options(headers: {"Authorization": "Bearer $currentToken"})
    return BackendResponse(
        myBody: response.data, status: response.statusCode ?? 666);
  }

  static Future<BackendResponse> _delete(String path) async {
    finalUrl = serverUrl + apiPath + path;

    Response response = await dio.delete(
        finalUrl); // options: Options(headers: {"Authorization": "Bearer $currentToken"})
    return BackendResponse(myBody: {}, status: response.statusCode ?? 666);
  }

  static Future<BackendResponse> _postOrPut(String path, Map myBody,
      {bool isPut = false}) async {
    finalUrl = serverUrl + apiPath + path;
    print("finalUrl: $finalUrl");
    String myBodyString = json.encode(myBody);
    Response response;
    print("myBodyString: $myBodyString");
    if (isPut) {
      response = await dio.put(finalUrl,
          options: Options(headers: _getHeader()), data: myBodyString);
    } else {
      response = await dio.post(finalUrl,
          options: Options(headers: _getHeader()), data: myBodyString);
    }
    print("Response: ${response.data.toString()}");
    Map<String, dynamic> objectResponse = response.data;
    if (objectResponse["error"] == true) {
      return BackendResponse(myBody: {}, status: response.statusCode ?? 0);
    }
    return BackendResponse(
        myBody: objectResponse, status: response.statusCode ?? 0);
  }

  static Future<BackendResponse> _post(String path, Map myBody) async {
    return await _postOrPut(path, myBody, isPut: false);
  }

  static Future<BackendResponse> _put(String path, Map myBody) async {
    return await _postOrPut(path, myBody, isPut: true);
  }

  static Future<BackendResponse> login(String email, String password) async {
    return await Api._post(
        "user/login", {"email": email, "password": password});
  }

  static Future<BackendResponse> loginEmail(String email) async {
    return await Api._post("user/login_token", {"email": email});
  }

  static Future<BackendResponse> getSettings() async {
    return await Api._get("wood/get_settings");
  }

  static Future<BackendResponse> getEmployees() async {
    return await Api._get("user/employees");
  }

  static Future<BackendResponse> getProviders() async {
    return await Api._get("user/providers");
  }

  static Future<BackendResponse> createKit(Pallet myKit) async {
    return await Api._post("wood/kit", myKit.toMap());
  }

  static Future<BackendResponse> updateKit(int kitId, Pallet myKit) async {
    return await Api._put("wood/kit/$kitId", myKit.toMap());
  }

  static Future<BackendResponse> deleteKit(int kitId, Pallet myKit) async {
    return await Api._delete("wood/kit/$kitId");
  }
}
