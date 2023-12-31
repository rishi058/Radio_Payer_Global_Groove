import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RadioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = 'http://de1.api.radio-browser.info/json';
    // 2nd Base Url = 'http://de2.api.radio-browser.info/json'
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Get.snackbar("Server Error",err.toString(),duration: const Duration(seconds: 3));
    super.onError(err, handler);
  }
}

class RadioApi{
  Dio dio = Dio();
  RadioApi(){
    dio.interceptors.add(RadioInterceptor());
  }
}