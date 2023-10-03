import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';

final class BlogStorageService implements LocalStorage {
  BlogStorageService() {
    open();
  }

  static const _blogListKey = 'blogs_storage';
  static const _blogKey = 'blog_storage';

  LazyBox<BlogList> get _blogListBox => Hive.lazyBox(_blogListKey);
  LazyBox<BlogListItem> get _blogBox => Hive.lazyBox(_blogKey);

  @override
  Future<void> open() async {
    await Future.wait([
      Hive.openLazyBox(_blogListKey),
      Hive.openLazyBox(_blogKey),
    ]);
  }

  Future<void> saveBlogList(BlogList list) async {
    return _blogListBox.put('blogs', list);
  }

  Future<BlogList?> getBlogList() async {
    return await _blogListBox.get('blogs');
  }

  Future<void> saveBlog(BlogListItem item) async {
    return _blogBox.put(item.id, item);
  }

  Future<BlogListItem?> getBlog(String id) async {
    return await _blogBox.get(id);
  }
}
