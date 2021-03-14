
import 'package:book_catalog/common_classes/api_constants.dart';
import 'package:dio/dio.dart';

BaseOptions options=new BaseOptions(
  baseUrl: ApiConstants.BASE_URL,
  connectTimeout: 1000*15,
  receiveTimeout: 1000*15,
);

var _http =new Dio(options);
Dio httpClient([String param]){

  return _http;
}



