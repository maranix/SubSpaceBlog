part of 'blog_bloc.dart';

/// Sealed class for blog events.
sealed class BlogEvent extends Equatable {
  /// Creates a new `BlogEvent` instance.
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

/// Event fired when the blog bloc is initialized.
final class BlogInitial extends BlogEvent {
  /// Creates a new `BlogInitial` event instance.
  const BlogInitial();
}

/// Event fired when the blog list has been fetched successfully.
final class BlogFetched extends BlogEvent {
  /// Creates a new `BlogFetched` event instance.
  const BlogFetched();
}

/// Event fired when a blog is liked.
final class BlogLiked extends BlogEvent {
  /// Creates a new `BlogLiked` event instance.
  ///
  /// * `blog`: The blog that was liked.
  const BlogLiked({
    required this.blog,
  });

  /// The blog that was liked.
  final BlogListItem blog;

  @override
  List<Object?> get props => [blog];
}

/// Event fired when a blog is disliked.
final class BlogDisliked extends BlogEvent {
  /// Creates a new `BlogDisliked` event instance.
  ///
  /// * `id`: The ID of the blog that was disliked.
  const BlogDisliked({
    required this.id,
  });

  /// The ID of the blog that was disliked.
  final String id;

  @override
  List<Object?> get props => [id];
}
