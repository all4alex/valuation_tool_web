import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreVehicleService {
  FirestoreVehicleService();
  final CollectionReference _collectionReference = _firestore
      .collection('vehicles')
      .withConverter<VehicleItem>(
          fromFirestore: (snapshot, _) =>
              VehicleItem.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Future<List<VehicleItem>> getAllVehicles({required String email}) async {
    List<VehicleItem> pinModelList = <VehicleItem>[];
    await _collectionReference
        .where('user', isEqualTo: email)
        .get()
        .then((value) {
      for (QueryDocumentSnapshot<VehicleItem> item in value.docs as dynamic) {
        pinModelList.add(item.data());
      }
    }).catchError((e) {
      print('Firestore error: $e');
    });
    return pinModelList;
  }

  Future<List<VehicleItem>> getVehiclesPerFolder(
      {required String folderName}) async {
    List<VehicleItem> pinModelList = <VehicleItem>[];
    await _collectionReference
        .where('folder', isEqualTo: folderName)
        .get()
        .then((value) {
      for (QueryDocumentSnapshot<VehicleItem> item in value.docs as dynamic) {
        pinModelList.add(item.data());
      }
    }).catchError((e) {
      print('Firestore error: $e');
    });
    return pinModelList;
  }

  Future<bool> addVehicle({required VehicleItem vehicleItem}) async {
    bool isSuccess = false;
    String id = await _collectionReference.add(vehicleItem).then((value) {
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

  Future<VehicleItem> getVehicleData(String vin, String email) async {
    VehicleItem vehicleItem = await _collectionReference
        .where('user', isEqualTo: email)
        .where('vin', isEqualTo: vin)
        .get()
        .then((value) => value.docs.first.data() as VehicleItem);

    return vehicleItem;
  }

  Future<bool> updateFolder(
      {required String folderName, required String id}) async {
    bool isSuccess = false;
    await _collectionReference.doc(id).update({
      'folder': folderName,
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
