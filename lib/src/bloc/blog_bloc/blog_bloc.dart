import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/domain.dart';

part 'blog_event.dart';
part 'blog_state.dart';

/// A bloc for managing the state of the blog related functionalities.
final class BlogBloc extends Bloc<BlogEvent, BlogState> {
  /// Creates a new `BlogBloc` instance.
  ///
  /// * `repo`: The blog repository to use to fetch and update blog data.
  /// * `storage`: The blog storage service to use to store and retrieve blog data locally.
  BlogBloc({
    required BlogRepository repo,
    required BlogStorageService storage,
  })  : _repo = repo,
        _storage = storage,
        super(const BlogState()) {
    /// Listens for the `BlogInitial` event and loads the blog list from local storage.
    on<BlogInitial>(_onInitial);

    /// Listens for the `BlogFetched` event and fetches the latest blog list from the server.
    on<BlogFetched>(_onFetched);

    /// Listens for the `BlogLiked` event and likes the given blog locally.
    on<BlogFavourited>(_onFavourite);
  }

  /// Handles the `BlogInitial` event.
  Future<void> _onInitial(
    BlogInitial event,
    Emitter<BlogState> emit,
  ) async {
    final (blogs, favourites) = await _restoreState();

    /// Emits a new state with the retrieved blog list and favourites.
    emit(state.copyWith(blogs: blogs, favourites: favourites));
  }

  /// Handles the `BlogFetched` event.
  Future<void> _onFetched(
    BlogFetched event,
    Emitter<BlogState> emit,
  ) async {
    /// If the blog list is empty, then emit a new state with the `fetching` status.
    if (state.blogs.isEmpty) {
      emit(state.copyWith(status: BlogStatus.fetching));
    } else {
      /// Otherwise, emit a new state with the `updating` status.
      emit(state.copyWith(status: BlogStatus.updating));
    }

    /// Tries to fetch the latest blog list from the server.
    try {
      /// If the fetch is successful, then emit a new state with the fetched blog list and the `fetched` status.
      final blogs = await _repo.getBlogs();
      emit(state.copyWith(status: BlogStatus.fetched, blogs: blogs));
    } catch (e) {
      /// If the fetch fails, then emit a new state with the `failure` status.
      emit(state.copyWith(status: BlogStatus.failure));
    }
  }

  /// Handles the `BlogLiked` event.
  Future<void> _onFavourite(
    BlogFavourited event,
    Emitter<BlogState> emit,
  ) async {
    if (state.favourites.contains(event.blog)) {
      /// Unlikes and removes the given blog locally.
      await _storage.removeLikedBlog(event.blog.id);

      emit(state.copyWith(favourites: [...state.favourites.takeWhile((value) => value != event.blog)]));
    } else {
      /// Likes and stores the given blog locally.
      emit(state.copyWith(favourites: [...state.favourites, event.blog]));
      await _storage.storeLikedBlog(event.blog);
    }
  }

  Future<(BlogList, Iterable<BlogListItem>)> _restoreState() async {
    await _storage.open();

    /// Retrieves the blog list from local storage.
    final favourites = _storage.retrieveLikedBlogs();
    final blogs = await _storage.retrieveBlogList();

    return (blogs, favourites);
  }

  /// Closes the bloc and stores the blog list to local storage.
  @override
  Future<void> close() async {
    /// Stores the blog list to local storage.
    await _storage.storeBlogList(state.blogs);

    /// Closes the bloc.
    return super.close();
  }

  /// The blog repository to use to fetch and update blog data.
  final BlogRepository _repo;

  /// The blog storage service to use to store and retrieve blog data locally.
  final BlogStorageService _storage;
}
