import 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:i_ve_arrived/remote/models.dart';

class Service {
  Dio _dio;
  String _accessToken;
  CookieJar _cookieJar;

  Service() {
    _dio = Dio();
    _dio.options.baseUrl = "https://ivearrived.azurewebsites.net/api/";
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options) {
          if (_accessToken != null) {
            options.headers["X-AUTH-TOKEN"] = _accessToken;
          }
          return options;
        },
      ),
    );
    _cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
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
    var list = response.data as List<Map<String, dynamic>>;
    return OrderListResponse(list.map((it) => OrderItem.fromJson(it)));
  }

  Future<OrderListResponse> fetchOrderListRecipient() async {
    var response = await _dio.get("Delivery/ListForRecipient");
    var list = response.data as List<Map<String, dynamic>>;
    return OrderListResponse(list.map((it) => OrderItem.fromJson(it)));
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

  Future startOrderRinging(String packageId, String firebaseToken) async{
    await _dio.post(
      "Delivery/DoorBell",
      data: {
        "packageId": packageId,
        "responseFirebaseToken": firebaseToken
      }
    );
  }

  Future finishOrder(String packageId, bool success) async{
    await _dio.post(
      "Delivery/DeliveryCompleted",
      data: {
        "packageId": packageId,
        "success": success,
      }
    );
  }

  Future orderRingingResponse(String packageId, bool accept) async{
    await _dio.post(
      "Delivery/DoorBellResponse",
      data: {
        "packageId": packageId,
        "isAvailable": accept,
      }
    );
  }
}

var service = Service();