import 'package:go_router/go_router.dart';
import 'package:sub_space_blog/src/bloc/bloc.dart';
import 'package:sub_space_blog/src/domain/domain.dart';
import 'package:sub_space_blog/src/presentation/presentation.dart';

/// An enum for the different routes in the app.
enum Routes {
  /// The root route.
  root('/'),

  /// The blog route.
  blog('/blog'),

  /// The favourite blogs route.
  favouriteBlogs('/favourites');

  /// The name of the route.
  final String name;

  /// Creates a new `Routes` enum instance.
  ///
  /// * `name`: The name of the route.
  const Routes(this.name);
}

final routes = [
  GoRoute(
    name: Routes.root.name,
    path: '/',
    builder: (context, _) {
      context.read<BlogBloc>()
        ..add(const BlogInitial())
        ..add(const BlogFetched());

      return const BlogPage();
    },
    routes: [
      GoRoute(
        name: Routes.favouriteBlogs.name,
        path: 'favourites',
        builder: (context, state) => const FavouriteBlogsPage(),
      ),
      GoRoute(
        name: Routes.blog.name,
        path: 'blog/:id',
        builder: (context, state) {
          final blog = state.extra as BlogListItem;

          return BlogDetailsPage(
            blog: blog,
          );
        },
      ),
    ],
  ),
];
