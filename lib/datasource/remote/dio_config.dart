import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class DioConfig{
static Dio getPrettyDio(){
  Dio dio=Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestBody: true,
    responseBody:true,
    requestHeader: true,
    responseHeader: true,
    canShowLog: true,
    error: true
  ));
  return dio;
}
}