import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/domain.dart';

part 'sub_space_blog_repository.dart';

abstract interface class BlogRepository extends Repository<BlogClient> {
  BlogRepository(super.client);

  Future<BlogList> getBlogs();
}
