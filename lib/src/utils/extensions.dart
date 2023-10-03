import 'dart:convert';

import 'package:http/http.dart' as http;

extension ResponseBodyConverter on http.Response {
  Map<String, dynamic> toMap() {
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;

      return json;
    } catch (e) {
      throw const MalformedResponeBodyException();
    }
  }
}

/// Exception thrown when the response body cannot be decoded using [jsonDecode].
final class MalformedResponeBodyException implements Exception {
  const MalformedResponeBodyException();
}
