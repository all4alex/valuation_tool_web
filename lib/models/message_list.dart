class MessageList {
  String? description;
  int? code;
  String? type;

  MessageList({this.description, this.code, this.type});

  factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
        description: json['description'] as String?,
        code: json['code'] as int?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'code': code,
        'type': type,
      };
}
