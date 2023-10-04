part of 'blog_bloc.dart';

enum BlogStatus {
  initial,
  fetching,
  updating,
  fetched,
  failure,
}

final class BlogState extends Equatable {
  const BlogState({
    this.status = BlogStatus.initial,
    this.blogs = BlogList.empty,
    this.favourites = const [],
  });

  final BlogStatus status;
  final BlogList blogs;
  final Iterable<BlogListItem> favourites;

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
