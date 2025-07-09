import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const String imageUrl = 'https://image.tmdb.org/t/p/w500';

class HttpApiClient {
  // create http singleton instance
  static final HttpApiClient _instance = HttpApiClient._internal();
  factory HttpApiClient() {
    return _instance;
  }
  HttpApiClient._internal() {
    _client = http.Client();
  }

  final baseUrl = 'https://api.themoviedb.org/3';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['TMDB_API_KEY']}'
  };

  late final http.Client _client;
  http.Client get client => _client;
}
