import 'package:dio/dio.dart';
import 'package:i_ve_arrived/example/remote/model.dart';

class Service{
  Dio _dio;

  Service(){
    _dio = Dio();
    _dio.options.baseUrl = "https://api.exchangeratesapi.io/";
  }

  Future<RateResponse> fetchRates() async{
    var response = await _dio.get("latest");
    await Future.delayed(Duration(seconds: 2));
    return RateResponse.fromJson(response.data);
  }
}

var exampleService = Service();