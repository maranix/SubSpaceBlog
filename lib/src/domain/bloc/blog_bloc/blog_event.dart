part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

final class BlogInitial extends BlogEvent {
  const BlogInitial();
}

final class BlogFetched extends BlogEvent {
  const BlogFetched();
}

final class BlogLiked extends BlogEvent {
  const BlogLiked({
    required this.blog,
  });

  final BlogListItem blog;

  @override
  List<Object?> get props => [blog];
}

final class BlogDisliked extends BlogEvent {
  const BlogDisliked({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
