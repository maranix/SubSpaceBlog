import 'package:flutter/material.dart';
import 'package:sub_space_blog/src/app/app.dart';
import 'package:sub_space_blog/src/data/data.dart';

Future<void> main() async {
  await LocalStorage.init();
  runApp(const SubSpaceApp());
}
