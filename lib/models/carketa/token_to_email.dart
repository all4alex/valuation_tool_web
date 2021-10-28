class TokenToEmail {
  bool? success;
  Data? data;
  dynamic error;
  List<dynamic>? meta;

  TokenToEmail({this.success, this.data, this.error, this.meta});

  factory TokenToEmail.fromJson(Map<String, dynamic> json) => TokenToEmail(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        error: json['error'],
        meta: json['meta'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'error': error,
        'meta': meta,
      };
}

class Data {
  String? email;
  int? id;

  Data({this.email, this.id});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json['email'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
      };
}
