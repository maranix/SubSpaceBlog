import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/model/model.dart';

/// A concrete implementation of the `LocalStorage` class for storing and retrieving blog data.
final class BlogStorageService implements LocalStorage {
  /// Creates a new `BlogStorageService` instance.
  BlogStorageService();

  /// The key for the blog list box in Hive.
  static const _blogListKey = 'blog_list_storage';

  /// The key for the blog box in Hive.
  static const _blogKey = 'blog_storage';

  /// The key for the liked blog box in Hive.
  static const _blogFavouriteKey = 'blog_favourite_storage';

  /// The lazy box for the blog list.
  Box get _blogListBox => Hive.box(_blogListKey);

  /// The lazy box for the blog.
  Box get _blogBox => Hive.box(_blogKey);

  /// The box for the liked blog.
  Box get _blogFavouriteBox => Hive.box(_blogFavouriteKey);

  /// Opens the local storage database.
  @override
  Future<void> open() async {
    /// Waits for all of the lazy boxes to be opened.
    await Future.wait([
      Hive.openBox(_blogFavouriteKey),
      Hive.openBox(_blogListKey),
      Hive.openBox(_blogKey),
    ]);
  }

  /// Stores the blog list in local storage.
  Future<void> storeBlogList(BlogList list) async {
    /// Converts the blog list to a list of JSON maps.
    final blogs = list.blogs.map((b) => b.toJson()).toList();

    /// Stores the list of JSON maps in the blog list box.
    return _blogListBox.put('blogs', blogs);
  }

  /// Retrieves the blog list from local storage.
  Future<BlogList> retrieveBlogList() async {
    /// Retrieves the list of JSON maps from the blog list box.
    final blogs = await _blogListBox.get('blogs') as List<dynamic>;

    /// If the list of JSON maps is not null, then converts it to a `BlogList` object.
    if (blogs != null) {
      return BlogList.fromJson({
        'blogs': blogs.map((e) => Map<String, dynamic>.from(e)).toList(),
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
    return Map.from(await _blogBox.get(id));
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
    return _blogFavouriteBox.values
        .map((e) => BlogListItem.fromJson(Map.from(e)));
  }
}
