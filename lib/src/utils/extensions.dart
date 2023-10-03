import 'dart:convert';

import 'package:http/http.dart' as http;

/// An extension class for converting a `http.Response` object to a JSON map.
extension ResponseBodyConverter on http.Response {
  /// Converts the response body to a JSON map.
  ///
  /// * Returns a `Map<String, dynamic>` object containing the JSON data in the response body.
  Map<String, dynamic> toMap() {
    try {
      /// Decodes the response body using the `jsonDecode()` function.
      final json = jsonDecode(body) as Map<String, dynamic>;

      /// Returns the decoded JSON data.
      return json;
    } catch (e) {
      /// Throws a `MalformedResponseBodyException` exception if the response body cannot be decoded.
      throw const MalformedResponseBodyException();
    }
  }
}

/// Exception thrown when the response body cannot be decoded using [jsonDecode].
final class MalformedResponseBodyException implements Exception {
  /// Creates a new `MalformedResponseBodyException` instance.
  const MalformedResponseBodyException();
}
