import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class VehicleStorageService {
  Reference reference =
      FirebaseStorage.instanceFor(bucket: 'gs://carketa-valuation-web')
          .ref()
          .child('vehicle_images/');

  Future<String> uploadVehicleImage(
      {required Uint8List imageByte, required String fileName}) async {
    UploadTask uploadTask = reference
        .child('$fileName')
        .putData(imageByte, SettableMetadata(contentType: 'image/jpeg'));

    TaskSnapshot storageTaskSnapshot = await uploadTask;
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}
