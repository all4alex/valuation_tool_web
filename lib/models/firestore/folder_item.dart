class FolderItem {
  FolderItem({this.folderName, this.user, this.folderCount});

  factory FolderItem.fromJson(Map<String, dynamic> json) => FolderItem(
        folderName: json['folderName'],
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'folderName': folderName,
        'user': user,
      };

  String? folderName;
  String? user;
  int? folderCount;
}
