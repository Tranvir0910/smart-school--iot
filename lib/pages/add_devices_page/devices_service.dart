import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addDevice(String selectedClassroom, Map<String, dynamic> deviceData) async {
    final docRef = _firestore.collection('Devices').doc(selectedClassroom);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists && docSnapshot.data()!.containsKey(deviceData['devicesName'])) {
      return false; // Device name already exists
    } else {
      await docRef.set(deviceData, SetOptions(merge: true));
      return true; // Device added successfully
    }
  }
}