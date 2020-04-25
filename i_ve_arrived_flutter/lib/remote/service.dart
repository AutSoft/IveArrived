import 'dart:math';

import 'package:dio/dio.dart';
import 'package:i_ve_arrived/remote/models.dart';

class Service {
  Dio _dio;
  String _accessToken;

  Service() {
    _dio = Dio();
    _dio.options.baseUrl = "...";
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
  }

  Future loginUser(String email, String password) async {
    /*var response = await _dio.post(
      "login",
      queryParameters: {"email": email, "password": password},
    );

     */
    await Future.delayed(Duration(seconds: 2));
    return;
  }


  Future<OrderListResponse> fetchOrderList() async {
    //....
    await Future.delayed(Duration(seconds: 2));
    return OrderListResponse(
      [
        for (int i = 0; i < 50; i++)
          OrderItem(id: "IDID$i", orderDate: "2020.04.20", address: "1138 Budapest Tomori u. 27", lat: 47.5514763, lng: 19.0777766, status: DeliveryStatus.values[Random().nextInt(DeliveryStatus.values.length)]),
      ],
    );
  }

}

var service = Service();