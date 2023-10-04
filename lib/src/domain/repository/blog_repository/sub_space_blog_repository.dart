part of 'blog_repository.dart';

/// A concrete implementation of the `Repository` class for interacting with the SubSpace blog API.
final class SubSpaceBlogRepository extends BlogRepository {
  /// Creates a new `SubSpaceBlogRepository` instance.
  ///
  /// * `client`: The `BlogClient` instance to use. Defaults to `[SubSpaceBlogApiClient]`.
  SubSpaceBlogRepository({BlogClient? client})
      : super(
          client ?? SubSpaceBlogApiClient(),
        );

  /// Gets a list of all blog posts from the SubSpace blog API.
  ///
  /// * Returns a `Future` that resolves to a `BlogList` object containing all blog posts.
  @override
  Future<BlogList> getBlogs() async {
    /// Makes a GET request to the `/blogs` endpoint of the SubSpace blog API.
    final response = await client.getBlogs();

    /// Converts the JSON response to a `BlogList` object.
    return BlogList.fromJson(response);
  }
}
