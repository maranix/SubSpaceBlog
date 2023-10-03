import 'dart:async';

import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';
import 'package:sub_space_blog/src/domain/repository/base_repository.dart';

/// A concrete implementation of the `Repository` class for interacting with the SubSpace blog API.
final class SubSpaceBlogRepository extends Repository<BlogClient> {
  /// Creates a new `SubSpaceBlogRepository` instance.
  ///
  /// * `client`: The `BlogClient` instance to use.
  SubSpaceBlogRepository(BlogClient client) : super(client);

  /// Gets a list of all blog posts from the SubSpace blog API.
  ///
  /// * Returns a `Future` that resolves to a `BlogList` object containing all blog posts.
  Future<BlogList> getBlogs() async {
    /// Makes a GET request to the `/blogs` endpoint of the SubSpace blog API.
    final response = await client.getBlogs();

    /// Converts the JSON response to a `BlogList` object.
    return BlogList.fromJson(response);
  }
}
