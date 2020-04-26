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

  bool hasAccessToken() {
    return _cookieJar.loadForRequest(Uri.parse(_dio.options.baseUrl)).firstWhere((test) => test.name.contains("Identity"), orElse: () => null) != null;
  }

  Future loginUser(String email, String password) async {
    await _dio.post("Account/Login", data: {
      "email": email,
      "password": password,
    });
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
   /*return OrderListResponse(
     [
       OrderItem(
           courier: CourierData(
               null, "Telek József", "https://s3.amazonaws.com/cms-assets.tutsplus.com/uploads/users/810/profiles/19338/profileImage/profile-square-extra-small.png", "+36708795432"
           ),
           courierService: CourierData(
               null, "August Bakery", "https://i.etsystatic.com/17285564/r/il/befeb9/1475774182/il_570xN.1475774182_r79g.jpg", ""
           ),
           state: DeliveryStatus.DeliveryInProgress,
           id: 0,
           address: "1321 Budapest, Sas u. 32",
           estimatedDeliveryEnd: "2020.04.26 08:25",
           packageId: "#TAUDFK99",
           recipientName: "Kovács Béla",
           senderName: "Adam's Bakery"
       ),
       OrderItem(
         courier: CourierData(
           null, "Rozs Anikó", "https://janecanblogdotcom.files.wordpress.com/2014/09/ashley-square-profile.jpg", "+36708795432"
         ),
         courierService: CourierData(
           null, "FedEx", "https://image.cnbcfm.com/api/v1/image/102628798-Untitled-4.jpg?v=1430254868&w=1910", ""
         ),
         state: DeliveryStatus.DeliveryInProgress,
         id: 0,
         address: "1321 Budapest, Sas u. 32",
         estimatedDeliveryEnd: "2020.04.26 15:50",
         packageId: "#ERTUXGA24",
         recipientName: "Kovács Béla",
           senderName: "Adam's Bakery"
       ),
       OrderItem(
         courier: CourierData(
             null, "Kovács Béla", "https://www.mobileworldlive.com/wp-content/uploads/2015/10/Dorsey-iamge.png", "+36708795432"
         ),
         courierService: CourierData(
             null, "GLS", "https://gls-group.eu/HU/media/images/Video_Sound_Images_GLS_Logo_Positive_200x150px-35697_IMG_200x150.png", ""
         ),
         state: DeliveryStatus.DeliveryInProgress,
         id: 0,
         address: "1321 Budapest, Sas u. 32",
         estimatedDeliveryEnd: "2020.04.26 17:20",
         packageId: "#HFTRO84MV",
         recipientName: "Kovács Béla",
           senderName: "Adam's Bakery"
       ),
     ]
   );*/
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
    await _dio.post("Firebase/AddFirebaseTokenToUser", data: {"firebaseToken": token});
    return;
  }

  Future startOrderRinging(String packageId, String firebaseToken) async {
    await _dio.post("Delivery/DoorBell", data: {"packageId": packageId, "responseFirebaseToken": firebaseToken});
  }

  Future finishOrder(String packageId, bool success) async {
    await _dio.post("Delivery/DeliveryCompleted", data: {
      "packageId": packageId,
      "success": success,
    });
  }

  Future orderRingingResponse(String packageId, bool accept) async {
    await _dio.post("Delivery/DoorBellResponse", data: {
      "packageId": packageId,
      "isAvailable": accept,
    });
  }

  Future<MeData> fetchMeData() async {
    var response = await _dio.get("Account/Me");
    return MeData.fromJson(response.data);
  }

  Future subscribeToOrder(String packageId, String firebaseToken) async {
    await _dio.post(
      "Delivery/Subscribe",
      data: {
        "packageId": packageId,
        "firebaseToken": firebaseToken,
      }
    );
  }
}

Service service;
