import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String imageUrl = 'https://image.tmdb.org/t/p/w500';

class DioApiClient {
  // create dio singleton instance
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() {
    return _instance;
  }
  DioApiClient._internal() {
    _dio = Dio();
  }

  late final Dio _dio;
  Dio get dio => _dio;
}
