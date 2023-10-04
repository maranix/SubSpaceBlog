import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';

final class BlogStorageService implements LocalStorage {
  BlogStorageService() {
    open();
  }

  static const _blogListKey = 'blog_list_storage';
  static const _blogKey = 'blog_storage';
  static const _blogFavouriteKey = 'blog_favourite_storage';

  LazyBox<Iterable<Map<String, dynamic>>> get _blogListBox => Hive.lazyBox(_blogListKey);
  LazyBox<Map<String, dynamic>> get _blogBox => Hive.lazyBox(_blogKey);
  Box<Map<String, dynamic>> get _blogFavouriteBox => Hive.box(_blogKey);

  @override
  Future<void> open() async {
    await Future.wait([
      Hive.openLazyBox(_blogListKey),
      Hive.openLazyBox(_blogKey),
      Hive.openBox(_blogFavouriteKey),
    ]);
  }

  Future<void> storeBlogList(BlogList list) async {
    final blogs = list.blogs.map(
      (b) => b.toJson(),
    );

    return _blogListBox.put('blogs', blogs);
  }

  Future<BlogList> retrieveBlogList() async {
    final blogs = await _blogListBox.get('blogs');

    if (blogs != null) {
      return BlogList.fromJson({
        'blogs': blogs,
      });
    }

    return BlogList.empty;
  }

  Future<void> storeBlog(BlogListItem item) async {
    return _blogBox.put(item.id, item.toJson());
  }

  Future<Map<String, dynamic>?> retrieveBlog(String id) async {
    return await _blogBox.get(id);
  }

  Future<void> storeLikedBlog(BlogListItem item) async {
    return _blogFavouriteBox.put(item.id, item.toJson());
  }

  Future<void> removeLikedBlog(String id) async {
    return _blogFavouriteBox.delete(id);
  }

  Iterable<BlogListItem> retrieveLikedBlogs() {
    return _blogFavouriteBox.values.map(BlogListItem.fromJson);
  }
}
