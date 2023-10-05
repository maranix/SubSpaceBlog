import 'package:go_router/go_router.dart';
import 'package:sub_space_blog/src/bloc/bloc.dart';
import 'package:sub_space_blog/src/presentation/presentation.dart';

/// An enum for the different routes in the app.
enum Routes {
  /// The root route.
  root('/'),

  /// The blog route.
  blogs('/blogs'),

  /// The favourite blogs route.
  favouriteBlogs('/blogs/favourite_blogs');

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
    redirect: (context, _) {
      context.read<BlogBloc>()
        ..add(const BlogInitial())
        ..add(const BlogFetched());

      return Routes.blogs.name;
    },
    routes: [
      _blogRoutes,
    ],
  ),
];

final _blogRoutes = GoRoute(
  name: Routes.blogs.name,
  path: 'blogs',
  builder: (context, state) => const BlogPage(),
  routes: [
    GoRoute(
      path: ':id',
      builder: (context, state) => const BlogDetailsPage(),
    ),
    GoRoute(
      name: Routes.favouriteBlogs.name,
      path: 'favourites',
      builder: (context, state) => const FavouriteBlogsPage(),
    ),
  ],
);
