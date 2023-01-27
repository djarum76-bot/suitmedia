import 'package:dio/dio.dart';
import 'package:suitmedia/util/constants.dart';

class InternetService{
  static Dio dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: 60000,
        receiveTimeout: 60000,
      )
  );
}