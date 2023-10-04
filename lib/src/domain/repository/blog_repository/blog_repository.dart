import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/domain.dart';

part 'sub_space_blog_repository.dart';

/// An abstract interface class for a blog repository.
abstract interface class BlogRepository extends Repository<BlogClient> {
  /// Creates a new `BlogRepository` instance.
  ///
  /// * `client`: The HTTP client to use to make network requests.
  BlogRepository(super.client);

  /// Fetches the latest blog list from the server.
  Future<BlogList> getBlogs();
}
