import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreNotesService {
  FirestoreNotesService();
  final CollectionReference _collectionReference = _firestore
      .collection('vehicle_notes')
      .withConverter<NoteItemModel>(
          fromFirestore: (snapshot, _) =>
              NoteItemModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Future<List<NoteItemModel>> getNotesPerUserAndVehicle(
      {required String email, required String vin}) async {
    List<NoteItemModel> list = <NoteItemModel>[];
    await _collectionReference
        .where('user', isEqualTo: email)
        .where('vin', isEqualTo: vin)
        .get()
        .then((value) {
      for (QueryDocumentSnapshot<NoteItemModel> item in value.docs as dynamic) {
        list.add(item.data());
      }
    }).catchError((e) {
      print('Firestore error: $e');
    });
    return list;
  }

  Future<bool> addNote({required NoteItemModel noteItemModel}) async {
    bool isSuccess = false;
    String id = await _collectionReference.add(noteItemModel).then((value) {
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
}
