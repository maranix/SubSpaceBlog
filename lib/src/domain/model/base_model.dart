import 'package:equatable/equatable.dart';

/// An abstract base class for all models in the application.
///
/// This class provides a common set of functionality for models, such as equality checking and serialization.
abstract class Model extends Equatable {
  /// Creates a new `Model` instance.
  const Model();

  /// Converts the model to a JSON map.
  ///
  /// This method should be implemented by subclasses to convert the model to a JSON map that can be serialized.
  Map<String, dynamic> toJson();

  /// Creates a copy of the model with the specified changes.
  ///
  /// This method should be implemented by subclasses to create a copy of the model with the specified changes.
  Model copyWith();
}
