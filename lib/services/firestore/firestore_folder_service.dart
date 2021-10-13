import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreFolderService {
  FirestoreFolderService();
  final CollectionReference _collectionReference = _firestore
      .collection('folders')
      .withConverter<FolderItem>(
          fromFirestore: (snapshot, _) => FolderItem.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Future<List<FolderItem>> getAllFolders({required String email}) async {
    List<FolderItem> list = <FolderItem>[];
    await _collectionReference
        .where('user', isEqualTo: email)
        .get()
        .then((value) {
      for (QueryDocumentSnapshot<FolderItem> item in value.docs as dynamic) {
        list.add(item.data());
      }
    }).catchError((e) {
      print('Firestore error: $e');
    });
    return list;
  }

  Future<bool> addFolder({required FolderItem folderItem}) async {
    bool isSuccess = false;
    String id = await _collectionReference.add(folderItem).then((value) {
      return value.id;
    }).catchError((e) {
      isSuccess = false;
      print('SAVING error: ${e.toString()}');
    });
    await _collectionReference
        .doc(id)
        .update({'id': id}).then((value) => isSuccess = true);

    return isSuccess;
  }

  Future<FolderItem> getFolderData(String email) async {
    FolderItem folderItem = await _collectionReference
        .where('user', isEqualTo: email)
        .get()
        .then((value) => value.docs.first.data() as FolderItem);

    return folderItem;
  }

// WILL DELETE LATER
  Future<bool> updatePin(String imageUrl, String title, String description,
      String pinType, String id) async {
    bool isSuccess = false;

    await _collectionReference.doc(id).update({
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'pinType': pinType
    }).then((value) => isSuccess = true);

    return isSuccess;
  }

// WILL DELETE LATER
  Future<bool> deletePin(String id) async {
    bool isSuccess = false;

    await _collectionReference
        .doc(id)
        .delete()
        .then((value) => isSuccess = true);

    return isSuccess;
  }
}
