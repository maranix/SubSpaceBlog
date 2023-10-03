import 'package:sub_space_blog/src/data/network/base_api_client.dart';

/// An abstract base class for repositories.
///
/// This class provides a common set of functionality for repositories, such as providing access to the API client.
abstract class Repository<T extends BaseApiClient> {
  /// Creates a new `Repository` instance.
  ///
  /// * `client`: The API client to use.
  const Repository(this._client);

  /// The API client.
  final BaseApiClient _client;

  /// Returns the API client.
  T get client => _client as T;
}
