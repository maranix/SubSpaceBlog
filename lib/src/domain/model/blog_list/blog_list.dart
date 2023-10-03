import 'package:sub_space_blog/src/domain/model/base_model.dart';

final class BlogList implements Model {
  const BlogList({
    required this.blogs,
  });

  final List<BlogListItem> blogs;

  factory BlogList.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'blogs': List<dynamic> items,
        }) {
      final blogs = items
          .map((e) => BlogListItem.fromJson(e as Map<String, dynamic>))
          .toList();

      return BlogList(blogs: blogs);
    } else {
      throw const FormatException(
          'BlogList: could not parse JSON, received an invalid JSON structure');
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
    final items = blogs.map((e) => e.toJson()).toList();

    return {
      'blogs': items,
    };
  }

  @override
  List<Object?> get props => [
        blogs,
      ];

  @override
  bool? get stringify => true;
}

final class BlogListItem implements Model {
  const BlogListItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

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
      throw const FormatException(
          'BlogListItem: could not parse JSON, received an invalid JSON structure');
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
  bool? get stringify => true;
}
