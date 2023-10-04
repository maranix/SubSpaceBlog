import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';

/// A concrete implementation of the `LocalStorage` class for storing and retrieving blog data.
final class BlogStorageService implements LocalStorage {
  /// Creates a new `BlogStorageService` instance.
  BlogStorageService() {
    /// Opens the local storage database.
    open();
  }

  /// The key for the blog list box in Hive.
  static const _blogListKey = 'blog_list_storage';

  /// The key for the blog box in Hive.
  static const _blogKey = 'blog_storage';

  /// The key for the liked blog box in Hive.
  static const _blogFavouriteKey = 'blog_favourite_storage';

  /// The lazy box for the blog list.
  LazyBox<Iterable<Map<String, dynamic>>> get _blogListBox =>
      Hive.lazyBox(_blogListKey);

  /// The lazy box for the blog.
  LazyBox<Map<String, dynamic>> get _blogBox => Hive.lazyBox(_blogKey);

  /// The box for the liked blog.
  Box<Map<String, dynamic>> get _blogFavouriteBox => Hive.box(_blogKey);

  /// Opens the local storage database.
  @override
  Future<void> open() async {
    /// Waits for all of the lazy boxes to be opened.
    await Future.wait([
      Hive.openLazyBox(_blogListKey),
      Hive.openLazyBox(_blogKey),
      Hive.openBox(_blogFavouriteKey),
    ]);
  }

  /// Stores the blog list in local storage.
  Future<void> storeBlogList(BlogList list) async {
    /// Converts the blog list to a list of JSON maps.
    final blogs = list.blogs.map(
      (b) => b.toJson(),
    );

    /// Stores the list of JSON maps in the blog list box.
    return _blogListBox.put('blogs', blogs);
  }

  /// Retrieves the blog list from local storage.
  Future<BlogList> retrieveBlogList() async {
    /// Retrieves the list of JSON maps from the blog list box.
    final blogs = await _blogListBox.get('blogs');

    /// If the list of JSON maps is not null, then converts it to a `BlogList` object.
    if (blogs != null) {
      return BlogList.fromJson({
        'blogs': blogs,
      });
    }

    /// Otherwise, returns an empty `BlogList` object.
    return BlogList.empty;
  }

  /// Stores the blog in local storage.
  Future<void> storeBlog(BlogListItem item) async {
    /// Stores the blog as a JSON map in the blog box.
    return _blogBox.put(item.id, item.toJson());
  }

  /// Retrieves the blog from local storage.
  Future<Map<String, dynamic>?> retrieveBlog(String id) async {
    /// Retrieves the blog as a JSON map from the blog box.
    return await _blogBox.get(id);
  }

  /// Stores the liked blog in local storage.
  Future<void> storeLikedBlog(BlogListItem item) async {
    /// Stores the liked blog as a JSON map in the liked blog box.
    return _blogFavouriteBox.put(item.id, item.toJson());
  }

  /// Removes the liked blog from local storage.
  Future<void> removeLikedBlog(String id) async {
    /// Deletes the liked blog from the liked blog box.
    return _blogFavouriteBox.delete(id);
  }

  /// Retrieves the liked blogs from local storage.
  Iterable<BlogListItem> retrieveLikedBlogs() {
    /// Maps the JSON maps in the liked blog box to `BlogListItem` objects.
    return _blogFavouriteBox.values.map(BlogListItem.fromJson);
  }
}
