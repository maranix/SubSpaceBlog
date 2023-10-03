import 'dart:async';

import 'package:http/http.dart' as http;

/// A base class for implementing API clients.
///
/// This class provides a common set of functionality for making HTTP requests, such as setting the base URL and headers.
abstract class BaseApiClient {
  /// Creates a new `BaseApiClient` instance.
  ///
  /// * `client`: The `http.Client` instance to use for making HTTP requests.
  /// * `baseUrl`: The base URL of the API.
  /// * `headers`: A map of headers to include in all HTTP requests.
  const BaseApiClient({
    required http.Client client,
    required String baseUrl,
    Map<String, String>? headers,
  })  : _client = client,
        _baseUrl = baseUrl,
        _headers = headers;

  /// The `http.Client` instance to use for making HTTP requests.
  final http.Client _client;

  /// The base URL of the API.
  final String _baseUrl;

  /// A map of headers to include in all HTTP requests.
  final Map<String, String>? _headers;

  /// Makes a GET request to the specified path.
  ///
  /// * `path`: The path of the resource to request.
  ///
  /// Returns a `Future` that resolves to the `http.Response` object.
  Future<http.Response> get(String path) async {
    /// Parses the specified path and base URL into a Uri object.
    final uri = Uri.parse(
      Uri.encodeFull(
        '$_baseUrl/$path',
      ),
    );

    /// Makes a GET request to the specified Uri object, with the specified headers.
    return _client.get(uri, headers: _headers);
  }
}
