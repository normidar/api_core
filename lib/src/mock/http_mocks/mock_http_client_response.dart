import 'dart:async';
import 'dart:io';

import 'package:api_http/api_http.dart';

class MockHttpClientResponse implements HttpClientResponse {
  MockHttpClientResponse({
    List<List<int>>? chunks,
    int statusCode = 200,
    String reasonPhrase = 'OK',
    List<Cookie>? cookies,
    bool isRedirect = false,
    List<RedirectInfo>? redirects,
    HttpHeaders? headers,
    HttpClientResponseCompressionState compressionState =
        HttpClientResponseCompressionState.notCompressed,
  })  : _chunks = chunks ?? <List<int>>[],
        _statusCode = statusCode,
        _reasonPhrase = reasonPhrase,
        _cookies = cookies?.map(MockCookie.makeMock).toList() ?? <MockCookie>[],
        _isRedirect = isRedirect,
        _redirects = redirects?.map(MockRedirectInfo.makeMock).toList() ??
            <MockRedirectInfo>[],
        _headers = headers != null ? MockHttpHeaders.makeMock(headers) : null,
        _compressionState = compressionState {
    // Stream作成のためにコントローラーにデータを追加
    Future.microtask(() {
      for (final chunk in _chunks) {
        _controller.add(chunk);
      }
      _controller.close();
    });
  }
  factory MockHttpClientResponse.fromJson(Map<String, dynamic> json) =>
      MockHttpClientResponse(
        chunks: json['chunks'] as List<List<int>>,
        statusCode: json['statusCode'] as int,
        reasonPhrase: json['reasonPhrase'] as String,
        cookies: (json['cookies'] as List<Map<String, dynamic>>)
            .map(MockCookie.fromJson)
            .toList(),
        isRedirect: json['isRedirect'] as bool,
        redirects: (json['redirects'] as List<Map<String, dynamic>>)
            .map(MockRedirectInfo.fromJson)
            .toList(),
        headers:
            MockHttpHeaders.fromJson(json['headers'] as Map<String, dynamic>),
        compressionState: HttpClientResponseCompressionState.values.firstWhere(
          (state) => state.name == json['compressionState'],
          orElse: () => HttpClientResponseCompressionState.notCompressed,
        ),
      );
  final List<List<int>> _chunks;
  final StreamController<List<int>> _controller = StreamController<List<int>>();
  final int _statusCode;
  final String _reasonPhrase;
  final List<MockCookie> _cookies;
  final bool _isRedirect;
  final List<MockRedirectInfo> _redirects;
  final HttpClientResponseCompressionState _compressionState;

  final MockHttpHeaders? _headers;

  // HttpClientResponse実装
  @override
  X509Certificate? get certificate => null;

  @override
  HttpClientResponseCompressionState get compressionState => _compressionState;

  @override
  HttpConnectionInfo? get connectionInfo => null;

  @override
  int get contentLength => -1; // 不明として-1を返す

  @override
  List<MockCookie> get cookies => _cookies;

  @override
  Future<List<int>> get first => _controller.stream.first;

  @override
  HttpHeaders get headers => _headers!;

  @override
  bool get isBroadcast => _controller.stream.isBroadcast;

  @override
  Future<bool> get isEmpty => _controller.stream.isEmpty;

  @override
  bool get isRedirect => _isRedirect;

  @override
  Future<List<int>> get last => _controller.stream.last;

  @override
  Future<int> get length => _controller.stream.length;

  @override
  bool get persistentConnection => false;

  @override
  String get reasonPhrase => _reasonPhrase;

  @override
  List<RedirectInfo> get redirects => _redirects;

  @override
  Future<List<int>> get single => _controller.stream.single;

  @override
  int get statusCode => _statusCode;

  @override
  Future<bool> any(bool Function(List<int> element) test) {
    return _controller.stream.any(test);
  }

  @override
  Stream<List<int>> asBroadcastStream({
    void Function(StreamSubscription<List<int>> subscription)? onListen,
    void Function(StreamSubscription<List<int>> subscription)? onCancel,
  }) {
    return _controller.stream.asBroadcastStream(
      onListen: onListen,
      onCancel: onCancel,
    );
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(List<int> event) convert) {
    return _controller.stream.asyncExpand(convert);
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(List<int> event) convert) {
    return _controller.stream.asyncMap(convert);
  }

  @override
  Stream<R> cast<R>() {
    return _controller.stream.cast<R>();
  }

  @override
  Future<bool> contains(Object? needle) {
    return _controller.stream.contains(needle);
  }

  @override
  Future<Socket> detachSocket() {
    throw UnsupportedError(
      'detachSocket is not supported in MockHttpClientResponse',
    );
  }

  @override
  Stream<List<int>> distinct([
    bool Function(List<int> previous, List<int> next)? equals,
  ]) {
    return _controller.stream.distinct(equals);
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    return _controller.stream.drain(futureValue);
  }

  @override
  Future<List<int>> elementAt(int index) {
    return _controller.stream.elementAt(index);
  }

  @override
  Future<bool> every(bool Function(List<int> element) test) {
    return _controller.stream.every(test);
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(List<int> element) convert) {
    return _controller.stream.expand(convert);
  }

  @override
  Future<List<int>> firstWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    return _controller.stream.firstWhere(test, orElse: orElse);
  }

  @override
  Future<S> fold<S>(
    S initialValue,
    S Function(S previous, List<int> element) combine,
  ) {
    return _controller.stream.fold(initialValue, combine);
  }

  @override
  Future<void> forEach(void Function(List<int> element) action) {
    return _controller.stream.forEach(action);
  }

  @override
  Stream<List<int>> handleError(
    Function onError, {
    bool Function(dynamic error)? test,
  }) {
    return _controller.stream.handleError(onError, test: test);
  }

  @override
  Future<String> join([String separator = '']) {
    return _controller.stream.join(separator);
  }

  @override
  Future<List<int>> lastWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    return _controller.stream.lastWhere(test, orElse: orElse);
  }

  // Stream実装
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Stream<S> map<S>(S Function(List<int> event) convert) {
    return _controller.stream.map(convert);
  }

  @override
  Future<void> pipe(StreamConsumer<List<int>> streamConsumer) {
    return _controller.stream.pipe(streamConsumer);
  }

  @override
  Future<HttpClientResponse> redirect([
    String? method,
    Uri? url,
    bool? followLoops,
  ]) {
    throw UnsupportedError(
      'redirect is not supported in MockHttpClientResponse',
    );
  }

  @override
  Future<List<int>> reduce(
    List<int> Function(List<int> previous, List<int> element) combine,
  ) {
    return _controller.stream.reduce(combine);
  }

  @override
  Future<List<int>> singleWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    return _controller.stream.singleWhere(test, orElse: orElse);
  }

  @override
  Stream<List<int>> skip(int count) {
    return _controller.stream.skip(count);
  }

  @override
  Stream<List<int>> skipWhile(bool Function(List<int> element) test) {
    return _controller.stream.skipWhile(test);
  }

  @override
  Stream<List<int>> take(int count) {
    return _controller.stream.take(count);
  }

  @override
  Stream<List<int>> takeWhile(bool Function(List<int> element) test) {
    return _controller.stream.takeWhile(test);
  }

  @override
  Stream<List<int>> timeout(
    Duration timeLimit, {
    void Function(EventSink<List<int>> sink)? onTimeout,
  }) {
    return _controller.stream.timeout(timeLimit, onTimeout: onTimeout);
  }

  Map<String, dynamic> toJson() => {
        'chunks': _chunks,
        'statusCode': _statusCode,
        'reasonPhrase': _reasonPhrase,
        'cookies': _cookies.map((cookie) => cookie.toJson()).toList(),
        'isRedirect': _isRedirect,
        'redirects': _redirects.map((redirect) => redirect.toJson()).toList(),
        'headers': _headers?.toJson(),
        'compressionState': _compressionState.name,
      };

  @override
  Future<List<List<int>>> toList() {
    return _controller.stream.toList();
  }

  @override
  Future<Set<List<int>>> toSet() {
    return _controller.stream.toSet();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S> streamTransformer) {
    return _controller.stream.transform(streamTransformer);
  }

  @override
  Stream<List<int>> where(bool Function(List<int> event) test) {
    return _controller.stream.where(test);
  }

  static Future<MockHttpClientResponse> makeMock(
    HttpClientResponse response,
  ) async {
    final chunks = await response.toList();
    return MockHttpClientResponse(
      chunks: chunks,
      statusCode: response.statusCode,
      reasonPhrase: response.reasonPhrase,
      cookies: response.cookies,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      headers: response.headers,
      compressionState: response.compressionState,
    );
  }
}
