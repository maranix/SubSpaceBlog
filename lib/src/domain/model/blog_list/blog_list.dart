import 'package:sub_space_blog/src/domain/model/base_model.dart';

/// A model class for representing a list of blog posts.
final class BlogList extends Model {
  /// Creates a new `BlogList` instance.
  ///
  /// * `blogs`: A list of blog posts.
  const BlogList({
    required this.blogs,
  });

  /// A list of blog posts.
  final List<BlogListItem> blogs;

  /// Creates a `BlogList` instance from a JSON map.
  ///
  /// * `json`: A JSON map representing a list of blog posts.
  factory BlogList.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'blogs': List<dynamic> items,
        }) {
      final blogs = items
          .cast<Map<String, dynamic>>()
          .map(
            BlogListItem.fromJson,
          )
          .toList();

      return BlogList(blogs: blogs);
    } else {
      throw const FormatException('BlogList: could not parse JSON, received an invalid JSON structure');
    }
  }

  @override
  BlogList copyWith({
    List<BlogListItem>? blogs,
  }) {
    return BlogList(blogs: blogs ?? this.blogs);
  }

  @override
  Map<String, dynamic> toJson() {
    final items = blogs
        .map(
          (e) => e.toJson(),
        )
        .toList();

    return {
      'blogs': items,
    };
  }

  @override
  List<Object?> get props => [
        blogs,
      ];

  @override
  String toString() {
    return '${blogs.take(5)}...${blogs.length - 5} more...';
  }
}

/// A model class for representing a blog post.
final class BlogListItem extends Model {
  /// Creates a new `BlogListItem` instance.
  ///
  /// * `id`: The ID of the blog post.
  /// * `title`: The title of the blog post.
  /// * `imageUrl`: The image URL of the blog post.
  const BlogListItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  /// The ID of the blog post.
  final String id;

  /// The title of the blog post.
  final String title;

  /// The image URL of the blog post.
  final String imageUrl;

  /// Creates a `BlogListItem` instance from a JSON map.
  ///
  /// * `json`: A JSON map representing a blog post.
  factory BlogListItem.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': String id,
          'title': String title,
          'image_url': String imageUrl,
        }) {
      return BlogListItem(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
    } else {
      throw const FormatException('BlogListItem: could not parse JSON, received an invalid JSON structure');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
    };
  }

  @override
  Model copyWith({
    String? id,
    String? title,
    String? imageUrl,
  }) {
    return BlogListItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
      ];

  @override
  String toString() {
    return 'id: $id, title: $title, imageUrl: $imageUrl';
  }
}
