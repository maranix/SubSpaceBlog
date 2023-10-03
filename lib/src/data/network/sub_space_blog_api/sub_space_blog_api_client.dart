import 'dart:io';

import 'package:sub_space_blog/src/data/network/base_api_client.dart';
import 'package:sub_space_blog/src/utils/utils.dart';

final class SubSpaceBlogsApiClient extends ApiClient {
  SubSpaceBlogsApiClient({
    super.client,
  })  : assert(
          Platform.environment['ADMIN_SECRET'] != null,
          'environment variable ADMIN_SECRET key is null',
        ),
        assert(
          Platform.environment['ADMIN_SECRET']!.isNotEmpty,
          'environment variable ADMIN_SECRET key cannot be empty',
        ),
        super(
          baseUrl: 'https://intent-kit-16.hasura.app/api',
          headers: {
            'x-hasura-admin-secret': Platform.environment['ADMIN_SECRET']!,
          },
        );

  Future<Map<String, dynamic>> getBlogs() async {
    final uri = Uri.parse('$baseUrl/rest/blogs');

    final response = await client.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      return response.toMap();
    } else {
      throw Exception();
    }
  }
}
