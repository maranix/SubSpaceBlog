part of 'blog_bloc.dart';

/// Enum for the status of a blog.
enum BlogStatus {
  /// The initial state of a blog.
  initial,

  /// The state of a blog while it is being fetched.
  fetching,

  /// The state of a blog while it is being updated.
  updating,

  /// The state of a blog after it has been fetched successfully.
  fetched,

  /// The state of a blog after it has failed to be fetched or updated.
  failure,
}

/// The state of the blog bloc.
final class BlogState extends Equatable {
  /// Creates a new `BlogState` instance.
  const BlogState({
    this.status = BlogStatus.initial,
    this.blogs = BlogList.empty,
    this.favourites = const [],
  });

  /// The status of the blog.
  final BlogStatus status;

  /// The list of all blogs.
  final BlogList blogs;

  /// The list of favourited blogs.
  final Iterable<BlogListItem> favourites;

  /// Copies the `BlogState` with the given changes.
  BlogState copyWith({
    BlogStatus? status,
    BlogList? blogs,
    Iterable<BlogListItem>? favourites,
  }) {
    return BlogState(
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
      favourites: favourites ?? this.favourites,
    );
  }

  @override
  List<Object?> get props => [
        status,
        blogs,
        favourites,
      ];
}
