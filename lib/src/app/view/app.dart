import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_space_blog/src/app/routes/routes.dart';
import 'package:sub_space_blog/src/app/theme/theme.dart';
import 'package:sub_space_blog/src/bloc/bloc.dart';
import 'package:sub_space_blog/src/data/data.dart';
import 'package:sub_space_blog/src/domain/domain.dart';

class SubSpaceApp extends StatefulWidget {
  const SubSpaceApp({super.key});

  @override
  State<SubSpaceApp> createState() => _SubSpaceAppState();
}

class _SubSpaceAppState extends State<SubSpaceApp> {
  late SubSpaceBlogRepository _blogRepository;
  late BlogStorageService _storageService;

  @override
  void initState() {
    super.initState();

    _blogRepository = SubSpaceBlogRepository();
    _storageService = BlogStorageService();

    _storageService.open();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => _blogRepository,
        ),
        RepositoryProvider(
          create: (_) => _storageService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => BlogBloc(
              repo: _blogRepository,
              storage: _storageService,
            ),
          ),
        ],
        child: const _AppConfiguration(),
      ),
    );
  }
}

class _AppConfiguration extends StatelessWidget {
  const _AppConfiguration();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: routes,
      ),
      theme: appTheme(context),
    );
  }
}
