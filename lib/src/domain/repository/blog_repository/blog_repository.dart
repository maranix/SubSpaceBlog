import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';
import 'package:sub_space_blog/src/domain/repository/base_repository.dart';

final class BlogRepository extends Repository {
  BlogRepository({
    required SubSpaceBlogsApiClient client,
  }) : _client = client;

  final SubSpaceBlogsApiClient _client;

  Future<BlogList> getBlogs() async {
    final blogs = await _client.getBlogs();

    return BlogList.fromJson(blogs);
  }
}
