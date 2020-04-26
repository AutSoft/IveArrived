import 'dart:io';
import 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:path_provider/path_provider.dart';

class Service {
  Dio _dio;
  CookieJar _cookieJar;

  Service(String tempPath) {
    _dio = Dio();
    _dio.options.baseUrl = "https://ivearrived.azurewebsites.net/api/";
    _cookieJar = PersistCookieJar(dir: tempPath);
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
  
  bool hasAccessToken(){
    return _cookieJar.loadForRequest(Uri.parse(_dio.options.baseUrl)).firstWhere((test) => test.name.contains("Identity"), orElse: () => null) != null;
  }

  Future loginUser(String email, String password) async {
    await _dio.post(
        "Account/Login",
        data: {
          "email": email,
          "password": password,
        }
    );
    return;
  }


  Future<OrderListResponse> fetchOrderListCourier() async {
    var response = await _dio.get("Delivery/ListForCourier");
    var list = response.data as List<dynamic>;
    return OrderListResponse(list.map((it) => OrderItem.fromJson(it)).toList());
  }

  Future<OrderListResponse> fetchOrderListRecipient() async {
    var response = await _dio.get("Delivery/ListForRecipient");
    var list = response.data as List<dynamic>;
    return OrderListResponse(list.map((it) => OrderItem.fromJson(it)).toList());
  }

  Future signupCourier(String password, String email) async {
    await _dio.post(
      "Account/Register",
      data: FormData.fromMap({
        "Role": "CURRIER",
        "Email": email,
        "Password": password,
      }),
    );
    return;
  }

  Future signupUser(String password, String email) async {
    await _dio.post(
      "Account/Register",
      data: FormData.fromMap({
        "Role": "RECEPIENT",
        "Email": email,
        "Password": password,
      }),
    );
    return;
  }

  Future addFirebaseToken(String token) async {
    await _dio.post(
        "Firebase/AddFirebaseTokenToUser",
        data: {
          "firebaseToken": token
        }
    );
    return;
  }

  Future startOrderRinging(String packageId, String firebaseToken) async {
    await _dio.post(
        "Delivery/DoorBell",
        data: {
          "packageId": packageId,
          "responseFirebaseToken": firebaseToken
        }
    );
  }

  Future finishOrder(String packageId, bool success) async {
    await _dio.post(
        "Delivery/DeliveryCompleted",
        data: {
          "packageId": packageId,
          "success": success,
        }
    );
  }

  Future orderRingingResponse(String packageId, bool accept) async {
    await _dio.post(
        "Delivery/DoorBellResponse",
        data: {
          "packageId": packageId,
          "isAvailable": accept,
        }
    );
  }

  Future<MeData> fetchMeData() async {
    var response = await _dio.get("Account/Me");
    return MeData.fromJson(response.data);
  }
}

Service service;