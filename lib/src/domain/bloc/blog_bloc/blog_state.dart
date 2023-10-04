part of 'blog_bloc.dart';

enum BlogStatus {
  initial,
  fetching,
  fetched,
  failure,
}

final class BlogState extends Equatable {
  const BlogState({
    this.status = BlogStatus.initial,
  });

  final BlogStatus status;

  BlogState copyWith({BlogStatus? status}) {
    return BlogState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
