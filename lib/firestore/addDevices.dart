import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDevicesFireStore extends StatelessWidget {
  final String name;
  final String room;
  final String svg;
  final bool isActive = false;

  AddDevicesFireStore(this.name, this.room, this.svg);

  @override
  Widget build(BuildContext context) {
    
    DocumentReference users = FirebaseFirestore.instance.collection('Classroom').doc('Devices');

    Future<void> addDevices() {
      return users
          .set({
            'name': name,
            'room': room,
            'svg': svg
          })
          .then((value) => print("Devices Added"))
          .catchError((error) => print("Failed to add devices: $error"));
    }

    return TextButton(
      onPressed: addDevices,
      child: const Text(
        "Add Devices",
      ),
    );
  }
}