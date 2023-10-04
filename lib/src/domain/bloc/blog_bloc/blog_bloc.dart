import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/domain.dart';

part 'blog_event.dart';
part 'blog_state.dart';

final class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({
    required BlogRepository repo,
    required BlogStorageService storage,
  })  : _repo = repo,
        _storage = storage,
        super(const BlogState()) {
    on<BlogInitial>(_onInitial);
    on<BlogFetched>(_onFetched);
    on<BlogLiked>(_onLiked);
    on<BlogDisliked>(_onDisliked);
  }

  Future<void> _onInitial(
    BlogInitial event,
    Emitter<BlogState> emit,
  ) async {
    final favourites = _storage.retrieveLikedBlogs();
    final blogs = await _storage.retrieveBlogList();

    emit(state.copyWith(blogs: blogs, favourites: favourites));
  }

  Future<void> _onFetched(
    BlogFetched event,
    Emitter<BlogState> emit,
  ) async {
    if (state.blogs.isEmpty) {
      emit(state.copyWith(status: BlogStatus.fetching));
    } else {
      emit(state.copyWith(status: BlogStatus.updating));
    }

    try {
      final blogs = await _repo.getBlogs();

      emit(state.copyWith(status: BlogStatus.fetched, blogs: blogs));
    } catch (e) {
      emit(state.copyWith(status: BlogStatus.failure));
    }
  }

  Future<void> _onLiked(
    BlogLiked event,
    Emitter<BlogState> emit,
  ) async {
    await _storage.storeLikedBlog(event.blog);
  }

  Future<void> _onDisliked(
    BlogDisliked event,
    Emitter<BlogState> emit,
  ) async {
    await _storage.removeLikedBlog(event.id);
  }

  @override
  Future<void> close() async {
    await _storage.storeBlogList(state.blogs);

    return super.close();
  }

  final BlogRepository _repo;
  final BlogStorageService _storage;
}
