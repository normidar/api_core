import 'dart:io';

class MockCookie implements Cookie {
  MockCookie({
    required this.name,
    required this.value,
    required this.httpOnly,
    required this.secure,
    this.domain,
    this.path,
    this.expires,
    this.maxAge,
    this.sameSite,
  });

  factory MockCookie.fromJson(Map<String, dynamic> json) => MockCookie(
        name: json['name'] as String,
        value: json['value'] as String,
        domain: json['domain'] as String?,
        path: json['path'] as String?,
        expires: json['expires'] as DateTime?,
        httpOnly: json['httpOnly'] as bool,
        maxAge: json['maxAge'] as int?,
        secure: json['secure'] as bool,
        sameSite: json['sameSite'] as SameSite?,
      );

  factory MockCookie.makeMock(Cookie cookie) => MockCookie(
        name: cookie.name,
        value: cookie.value,
        domain: cookie.domain,
        path: cookie.path,
        expires: cookie.expires,
        httpOnly: cookie.httpOnly,
        maxAge: cookie.maxAge,
        secure: cookie.secure,
        sameSite: cookie.sameSite,
      );

  @override
  String name;

  @override
  String value;

  @override
  bool httpOnly;

  @override
  bool secure;

  @override
  String? domain;

  @override
  String? path;

  @override
  DateTime? expires;

  @override
  int? maxAge;

  @override
  SameSite? sameSite;

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'domain': domain,
        'path': path,
        'expires': expires,
        'httpOnly': httpOnly,
        'maxAge': maxAge,
        'secure': secure,
        'sameSite': sameSite,
      };
}
