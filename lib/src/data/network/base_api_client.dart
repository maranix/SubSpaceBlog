import 'package:http/http.dart' as http;

base class ApiClient {
  ApiClient({
    http.Client? client,
    required String baseUrl,
    Map<String, String>? headers,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl,
        _headers = headers;

  final http.Client _client;
  final String _baseUrl;
  final Map<String, String>? _headers;

  http.Client get client => _client;

  String get baseUrl => _baseUrl;

  Map<String, String>? get headers => _headers;
}
