import 'dart:io';

class MockHttpHeaders implements HttpHeaders {
  MockHttpHeaders({
    Map<String, List<String>>? headers,
    String? contentType,
    int? contentLength,
    DateTime? date,
    DateTime? expires,
    DateTime? ifModifiedSince,
    String? host,
    bool? persistentConnection,
    int? port,
    bool? chunkedTransferEncoding,
    Iterable<String>? nonFoldingHeadersList,
  })  : _headers = headers ?? <String, List<String>>{},
        _headerNames = <String, String>{},
        _contentType =
            contentType != null ? ContentType.parse(contentType) : null,
        _contentLength = contentLength,
        _date = date,
        _expires = expires,
        _ifModifiedSince = ifModifiedSince,
        _host = host,
        _persistentConnection = persistentConnection ?? true,
        _port = port,
        _chunkedTransferEncoding = chunkedTransferEncoding ?? false {
    if (nonFoldingHeadersList != null) {
      for (final name in nonFoldingHeadersList) {
        _doNotFold.add(name.toLowerCase());
      }
    }
  }

  factory MockHttpHeaders.fromJson(Map<String, dynamic> json) {
    final headers = <String, List<String>>{};
    final headerNames = <String, String>{};
    final jsonHeaders = json['headers'] as Map<String, dynamic>?;
    if (jsonHeaders != null) {
      for (final key in jsonHeaders.keys) {
        final lowerKey = key.toLowerCase();
        headers[lowerKey] = (jsonHeaders[key] as List).cast<String>();
        headerNames[lowerKey] = key;
      }
    }

    // JSONからheaderNamesを読み込む
    final jsonHeaderNames = json['headerNames'] as Map<String, dynamic>?;
    if (jsonHeaderNames != null) {
      jsonHeaderNames.forEach((key, value) {
        headerNames[key] = value as String;
      });
    }

    final noFoldingList = json['noFolding'] as List<dynamic>?;
    final nonFoldingHeadersList = <String>[];
    if (noFoldingList != null) {
      for (final name in noFoldingList) {
        nonFoldingHeadersList.add(name as String);
      }
    }

    final result = MockHttpHeaders(
      headers: headers,
      contentType: json['contentType'] as String?,
      contentLength: json['contentLength'] as int?,
      date:
          json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      expires: json['expires'] != null
          ? DateTime.parse(json['expires'] as String)
          : null,
      ifModifiedSince: json['ifModifiedSince'] != null
          ? DateTime.parse(json['ifModifiedSince'] as String)
          : null,
      host: json['host'] as String?,
      persistentConnection: json['persistentConnection'] as bool?,
      port: json['port'] as int?,
      chunkedTransferEncoding: json['chunkedTransferEncoding'] as bool?,
      nonFoldingHeadersList: nonFoldingHeadersList,
    );

    // ヘッダー名のマッピングを設定
    headerNames.forEach((lowerKey, originalName) {
      result._headerNames[lowerKey] = originalName;
    });

    return result;
  }

  factory MockHttpHeaders.makeMock(HttpHeaders headers) {
    final mockHeaders = <String, List<String>>{};
    final headerNames = <String, String>{};

    headers.forEach((name, values) {
      final lowerName = name.toLowerCase();
      mockHeaders[lowerName] = List<String>.from(values);
      headerNames[lowerName] = name;
    });

    final nonFoldingHeadersList = <String>[];
    try {
      if (headers is MockHttpHeaders) {
        nonFoldingHeadersList.addAll(headers.nonFoldingHeaders);
      } else {
        headers.forEach((name, values) {
          // noFoldingメソッドが呼ばれた可能性のあるヘッダーは追加しない
          // ここでは単純にすべてのヘッダーを非折りたたみとして扱う
          nonFoldingHeadersList.add(name.toLowerCase());
        });
      }
    } catch (e) {
      // エラーが発生した場合は無視してデフォルト設定で続行
    }

    final result = MockHttpHeaders(
      headers: mockHeaders,
      contentType: headers.contentType?.toString(),
      contentLength: headers.contentLength,
      date: headers.date,
      expires: headers.expires,
      ifModifiedSince: headers.ifModifiedSince,
      host: headers.host,
      persistentConnection: headers.persistentConnection,
      port: headers.port,
      chunkedTransferEncoding: headers.chunkedTransferEncoding,
      nonFoldingHeadersList: nonFoldingHeadersList,
    );

    // 元のヘッダー名のマッピングを設定
    headerNames.forEach((lowerKey, originalName) {
      result._headerNames[lowerKey] = originalName;
    });

    // Mockから元のヘッダー名を保持
    if (headers is MockHttpHeaders) {
      headers._headerNames.forEach((lowerKey, originalName) {
        if (!result._headerNames.containsKey(lowerKey)) {
          result._headerNames[lowerKey] = originalName;
        }
      });
    }

    return result;
  }

  final Map<String, List<String>> _headers;
  final Map<String, String> _headerNames;
  ContentType? _contentType;
  int? _contentLength;
  DateTime? _date;
  DateTime? _expires;
  DateTime? _ifModifiedSince;
  String? _host;
  bool _persistentConnection;
  int? _port;
  bool _chunkedTransferEncoding;
  final Set<String> _doNotFold = <String>{};

  @override
  bool get chunkedTransferEncoding => _chunkedTransferEncoding;

  @override
  set chunkedTransferEncoding(bool chunkedTransferEncoding) {
    _chunkedTransferEncoding = chunkedTransferEncoding;
  }

  @override
  int get contentLength => _contentLength ?? -1;

  @override
  set contentLength(int contentLength) {
    _contentLength = contentLength;
  }

  @override
  ContentType? get contentType => _contentType;

  @override
  set contentType(ContentType? contentType) {
    _contentType = contentType;
  }

  @override
  DateTime? get date => _date;

  @override
  set date(DateTime? date) {
    _date = date;
  }

  @override
  DateTime? get expires => _expires;

  @override
  set expires(DateTime? expires) {
    _expires = expires;
  }

  @override
  String? get host => _host;

  @override
  set host(String? host) {
    _host = host;
  }

  @override
  DateTime? get ifModifiedSince => _ifModifiedSince;

  @override
  set ifModifiedSince(DateTime? ifModifiedSince) {
    _ifModifiedSince = ifModifiedSince;
  }

  Iterable<String> get names => _headers.keys;

  Iterable<String> get nonFoldingHeaders =>
      List<String>.unmodifiable(_doNotFold);

  @override
  bool get persistentConnection => _persistentConnection;

  @override
  set persistentConnection(bool persistentConnection) {
    _persistentConnection = persistentConnection;
  }

  @override
  int? get port => _port;

  @override
  set port(int? port) {
    _port = port;
  }

  @override
  List<String>? operator [](String name) {
    return _headers[name.toLowerCase()];
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    final lowercaseName = name.toLowerCase();
    if (preserveHeaderCase && !_headerNames.containsKey(lowercaseName)) {
      _headerNames[lowercaseName] = name;
    }
    _headers[lowercaseName] ??= <String>[];
    _headers[lowercaseName]!.add(value.toString());
  }

  @override
  void clear() {
    _headers.clear();
    _headerNames.clear();
    _contentType = null;
    _contentLength = null;
    _date = null;
    _expires = null;
    _ifModifiedSince = null;
    _host = null;
    _port = null;
    _chunkedTransferEncoding = false;
    _doNotFold.clear();
  }

  @override
  void forEach(void Function(String name, List<String> values) action) {
    _headers.forEach((name, values) {
      // 保存されている元のヘッダー名がある場合はそれを使用
      final headerName = _headerNames[name] ?? name;
      action(headerName, values);
    });
  }

  @override
  void noFolding(String name) {
    _doNotFold.add(name.toLowerCase());
  }

  @override
  void remove(String name, Object value) {
    final lowercaseName = name.toLowerCase();
    if (_headers.containsKey(lowercaseName)) {
      _headers[lowercaseName]!.remove(value.toString());
      if (_headers[lowercaseName]!.isEmpty) {
        _headers.remove(lowercaseName);
        _headerNames.remove(lowercaseName);
      }
    }
  }

  @override
  void removeAll(String name) {
    final lowercaseName = name.toLowerCase();
    _headers.remove(lowercaseName);
    _headerNames.remove(lowercaseName);
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    final lowercaseName = name.toLowerCase();
    if (preserveHeaderCase) {
      _headerNames[lowercaseName] = name;
    }
    _headers[lowercaseName] = [value.toString()];
  }

  Map<String, dynamic> toJson() {
    return {
      'headers': _headers,
      'headerNames': _headerNames,
      'contentType': _contentType?.toString(),
      'contentLength': _contentLength,
      'date': _date?.toIso8601String(),
      'expires': _expires?.toIso8601String(),
      'ifModifiedSince': _ifModifiedSince?.toIso8601String(),
      'host': _host,
      'persistentConnection': _persistentConnection,
      'port': _port,
      'chunkedTransferEncoding': _chunkedTransferEncoding,
      'noFolding': _doNotFold.toList(),
    };
  }

  @override
  String? value(String name) {
    final values = _headers[name.toLowerCase()];
    return values != null && values.isNotEmpty ? values.first : null;
  }
}
