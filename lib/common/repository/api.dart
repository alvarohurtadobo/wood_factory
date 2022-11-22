import 'dart:convert';
import 'package:dio/dio.dart';

const String serverUrl = "http://10.0.2.2:8000/";

// const String apiPath = "api/v1/";
const String apiPath = "";
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

    Response response = await dio.get(finalUrl,
        options: Options(headers: {"Authorization": "Bearer $currentToken"}));
    // .timeout(Duration(seconds: 30), onTimeout: () {
    //   return Response("{}", 999);
    // }).catchError((error) {
    //   return Response("{}", 666);
    // });

    Map objectResponse = json.decode(response.data);
    if (objectResponse["error"] == true) {
      return BackendResponse(myBody: {}, status: objectResponse["status"]);
    }
    if (objectResponse.containsKey("body")) {
      return BackendResponse(
          myBody: objectResponse["body"], status: response.statusCode ?? 0);
    }
    return BackendResponse(myBody: {}, status: 666);
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
    print("Response: " + response.data.toString());
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
}
