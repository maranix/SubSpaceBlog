part of 'blog_client.dart';

/// A concrete implementation of the `BlogClient` class for interacting with the SubSpace blog API.
final class SubSpaceBlogApiClient extends BlogClient {
  /// Creates a new `SubSpaceBlogApiClient` instance.
  ///
  /// * `client`: The `http.Client` instance to use for making HTTP requests.
  /// * `baseURL`: The base URL of the API.
  ///
  /// If `client` is not specified, a new `http.Client` instance will be created. If `baseURL` is not specified, the `baseEndpoint` constant will be used.
  SubSpaceBlogApiClient({
    http.Client? client,
    String? baseURL,
  }) : super(
          client: client ?? http.Client(),
          baseUrl: baseURL ?? baseEndpoint,
          headers: {
            'x-hasura-admin-secret': BlogClient.apiSecretKey,
          },
        );

  /// Gets a list of all blog posts.
  ///
  /// This method makes a GET request to the `/blogs` endpoint of the SubSpace blog API. The `apiSecretKey` is used to authenticate the request.
  ///
  /// Returns a `Future` that resolves to a map of blog posts, where the keys are the blog post IDs and the values are the blog post objects.
  @override
  Future<Map<String, dynamic>> getBlogs() async {
    final response = await get(blogsEndpoint);

    if (response.statusCode == HttpStatus.ok) {
      return response.toMap();
    } else {
      throw Exception('Failed to get blog posts');
    }
  }
}
