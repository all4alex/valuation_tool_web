import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreFolderService {
  FirestoreFolderService();
  final CollectionReference _collectionReference = _firestore
      .collection('folders')
      .withConverter<FolderItem>(
          fromFirestore: (snapshot, _) => FolderItem.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());
  final CollectionReference _collectionReference2 = _firestore
      .collection('vehicles')
      .withConverter<VehicleItem>(
          fromFirestore: (snapshot, _) =>
              VehicleItem.fromJson(snapshot.data()!),
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
      print(' error: ${e.toString()}');
    });
    await _collectionReference
        .doc(id)
        .update({'id': id}).then((value) => isSuccess = true);

    return isSuccess;
  }

  Future<bool> deleteFolder({required FolderItem folderItem}) async {
    bool isSuccess = false;
    await _collectionReference.doc(folderItem.id).delete().then((value) {
      isSuccess = true;
    }).catchError((e) {
      isSuccess = false;
      print(' error: ${e.toString()}');
    });

    return isSuccess;
  }

  Future<FolderItem> getFolderData({required String folderName}) async {
    FolderItem folderItem = await _collectionReference
        .where('folderName', isEqualTo: folderName)
        .get()
        .then((value) => value.docs.first.data() as FolderItem);

    return folderItem;
  }

  Future<bool> updateFolder(
      {required String folderName,
      required String id,
      required String oldFolderName}) async {
    bool isSuccess = false;

    await _collectionReference.doc(id).update({
      'folderName': folderName,
    }).then((value) {
      isSuccess = true;
    });
    await _collectionReference2
        .where('folder', isEqualTo: oldFolderName)
        .get()
        .then((value) async {
      for (QueryDocumentSnapshot<VehicleItem> item in value.docs as dynamic) {
        await _collectionReference2.doc(item.id).update({
          'folder': folderName,
        }).then((value) {
          isSuccess = true;
        });
      }
    });
    return isSuccess;
  }
}
