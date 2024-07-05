part of '../spotify.dart';

/// A custom HTTP client with logging capabilities.
class SpotifyClient with http.BaseClient {
  final FutureOr<oauth2.Client> _inner;

  final Logger _logger = Logger();

  bool _enableLogging = false;
  get enableLogging => _enableLogging;
  set enableLogging(value) => _enableLogging = value;

  SpotifyClient(this._inner);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (!enableLogging) {
      return await (await _inner).get(url, headers: headers);
    }
    try {
      // Log GET request details
      String headersLog = headers != null && headers.isNotEmpty
          ? '\n${headers.entries.map((entry) => '  • ${entry.key}: ${entry.value}').join('\n')}'
          : ': None';
      _logger.i(
          '🚀 🌐 Sending GET Request 🌐 🚀\n🔗 URL: $url\n📋 Headers$headersLog');

      // Perform the GET request
      final response = await (await _inner).get(url, headers: headers);

      // Log GET response details
      String responseLog =
          '✅ 🌐 GET Response 🌐 ✅\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers:\n${response.headers.entries.map((entry) => '  • ${entry.key}: ${entry.value}').join('\n')}\n📥 Response Data: ${response.body}';
      _logger.i(responseLog);

      return response;
    } catch (error) {
      // Log GET error
      _logger.e('❌ ❗ GET Request Failed ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!enableLogging) {
      return await (await _inner).send(request);
    }
    try {
      // Log request details
      String requestData = (request is http.Request)
          ? '\n📤 Request Data: ${request.body}'
          : '\n📤 Request Data: Not applicable for this type of request';
      _logger.i(
          '🚀 🌐 Request 🌐 🚀\n🔗 URL: ${request.url}\n🤔 Method: ${request.method}\n📋 Headers: ${jsonEncode(request.headers)}\n🔍 Query Parameters: ${request.url.queryParameters}$requestData');

      // Send the request and get the response
      final streamedResponse = await (await _inner).send(request);

      // Log response details
      String responseData =
          '\n🔗 URL: ${streamedResponse.request?.url}\n🔒 Status Code: ${streamedResponse.statusCode}\n📋 Headers: ${jsonEncode(streamedResponse.headers)}';
      _logger.i('✅ 🌐 Response 🌐 ✅$responseData');

      // Read the response stream and create a new http.Response
      final body = await streamedResponse.stream.bytesToString();
      final response = http.Response(
        body,
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
        request: request as http.Request,
      ); // Cast to http.Request

      _logger.i('📥 Response Data: ${response.body}');

      return streamedResponse;
    } catch (error) {
      // Log request error
      String requestErrorData =
          (request is http.Request) ? '\n❗ Request Data: ${request.body}' : '';
      _logger.e('❌ ❗ ERROR ❗ ❌\n❗ Error Message: $error$requestErrorData');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!enableLogging) {
      return await (await _inner)
          .delete(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log delete request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Delete Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the delete request
      final response = await (await _inner)
          .delete(url, headers: headers, body: body, encoding: encoding);
      // Log delete response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Delete Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');
      return response;
    } catch (error) {
      // Log delete error
      _logger.e('❌ ❗ Delete ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!enableLogging) {
      return await (await _inner)
          .post(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log post request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Post Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the post request
      final response = await (await _inner)
          .post(url, headers: headers, body: body, encoding: encoding);

      // Log post response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Post Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log post error
      _logger.e('❌ ❗ Post ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!enableLogging) {
      return await (await _inner).patch(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log patch request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Patch Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the patch request
      final response = await (await _inner)
          .patch(url, headers: headers, body: body, encoding: encoding);

      // Log patch response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Patch Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log patch error
      _logger.e('❌ ❗ Patch ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!enableLogging) {
      return await (await _inner).put(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log put request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Put Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the put request
      final response = await (await _inner)
          .put(url, headers: headers, body: body, encoding: encoding);

      // Log put response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Put Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log put error
      _logger.e('❌ ❗ Put ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    if (!enableLogging) {
      return await (await _inner).head(url, headers: headers);
    }
    try {
      // Log head request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 Head Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the head request
      final response = await (await _inner).head(url, headers: headers);

      // Log head response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i('✅ 🌐 Head Response 🌐 ✅$responseData');

      return response;
    } catch (error) {
      // Log head error
      _logger.e('❌ ❗ Head ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    if (!enableLogging) {
      return await (await _inner).read(url, headers: headers);
    }
    try {
      // Log read request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 Read Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the read request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log read response details
      _logger.i(
          '✅ 🌐 Read Response 🌐 ✅\n🔗 URL: $url\n📥 Response Data: ${response.body}');

      return response.body;
    } catch (error) {
      // Log read error
      _logger.e('❌ ❗ Read ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    if (!enableLogging) {
      return await (await _inner).readBytes(url, headers: headers);
    }
    try {
      // Log readBytes request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 ReadBytes Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the readBytes request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log readBytes response details
      _logger.i(
          '✅ 🌐 ReadBytes Response 🌐 ✅\n🔗 URL: $url\n📥 Response Data: ${response.bodyBytes}');

      return response.bodyBytes;
    } catch (error) {
      // Log readBytes error
      _logger.e('❌ ❗ ReadBytes ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  void close() async => (await _inner).close();
}
