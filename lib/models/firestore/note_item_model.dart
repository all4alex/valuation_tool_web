class NoteItemModel {
  String? id;
  String? note;
  String? user;
  String? vin;

  NoteItemModel({this.id, this.note, this.user, this.vin});

  factory NoteItemModel.fromJson(Map<String, dynamic> json) => NoteItemModel(
        id: json['id'] as String?,
        note: json['note'] as String?,
        user: json['user'] as String?,
        vin: json['vin'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'note': note,
        'user': user,
        'vin': vin,
      };
}
