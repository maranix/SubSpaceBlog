import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sub_space_blog/src/constants.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/utils/utils.dart';

part 'sub_space_blog_api.dart';

/// An abstract interface class for implementing blog clients.
///
/// This class extends `BaseApiClient` and provides a common set of functionality for interacting with a blog API.
abstract interface class BlogClient extends BaseApiClient {
  /// Creates a new `BlogClient` instance.
  ///
  /// * `client`: The `http.Client` instance to use for making HTTP requests.
  /// * `baseUrl`: The base URL of the API.
  /// * `headers`: A map of headers to include in all HTTP requests.
  BlogClient({
    required super.client,
    required super.baseUrl,
    super.headers,
  }) : assert(
          apiSecretKey.isNotEmpty,
          'environment variable ADMIN_SECRET key cannot be empty',
        );

  /// The secret key to authenticate with the blog API.
  static const String apiSecretKey = String.fromEnvironment('ADMIN_SECRET');

  /// Gets a list of all blog posts.
  ///
  /// Returns a `Future` that resolves to a map of blog posts, which resolves into a [blogs] key with `List<dynamic>` values.
  Future<Map<String, dynamic>> getBlogs();
}
