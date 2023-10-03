import 'package:equatable/equatable.dart';

abstract interface class Model extends Equatable {
  const Model();

  Map<String, dynamic> toJson();

  Model copyWith();
}
