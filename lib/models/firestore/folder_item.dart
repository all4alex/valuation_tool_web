class FolderItem {
  FolderItem({this.id, this.folderName, this.user, this.folderCount});

  factory FolderItem.fromJson(Map<String, dynamic> json) => FolderItem(
        id: json['id'],
        folderName: json['folderName'],
        user: json['user'],
        folderCount: json['folderCount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'folderName': folderName,
        'user': user,
        'folderCount': folderCount,
      };

  FolderItem copyWith({
    String? id,
    String? folderName,
    String? user,
    int? folderCount,
  }) =>
      FolderItem(
          id: id ?? this.id,
          folderName: folderName ?? this.folderName,
          user: user ?? this.user,
          folderCount: folderCount ?? this.folderCount);

  String? id;
  String? folderName;
  String? user;
  int? folderCount;
}
