import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_space_blog/bloc_observer.dart';
import 'package:sub_space_blog/src/app/app.dart';
import 'package:sub_space_blog/src/data/data.dart';

Future<void> main() async {
  await LocalStorage.init();

  Bloc.observer = AppBlocObserver();

  runApp(const SubSpaceApp());
}
