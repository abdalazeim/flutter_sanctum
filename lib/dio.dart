import 'package:dio/dio.dart';
import 'package:flutter_sanctum/providers/auth.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
      //baseUrl: 'https://deliverysudan.000webhostapp.com/api/login/login.php',
      baseUrl: 'https://deliverysudan.000webhostapp.com/api/login/login/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'api/login/login',
        'content-type': 'api/login/login',
      }));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    requestInterceptor(options);
    return handler.next(options); //continue
  }));
  return dio;
}

dynamic requestInterceptor(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    var token = await Auth().getToken();
    options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}
