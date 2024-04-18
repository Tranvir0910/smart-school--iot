import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/string_to_color.dart';
import '../model/device_model.dart';
import '../pages/home/control_page.dart';
import '../pages/home/devices.dart';

class GetDevicesData extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final classroom;

  const GetDevicesData({Key? key, required this.classroom}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetDevicesDataState createState() => _GetDevicesDataState();
}

class _GetDevicesDataState extends State<GetDevicesData> {

  late Stream<DocumentSnapshot> sensorDataStream;

  List<DeviceModel> devices = [];
  List<String> dataMapKey = [];
  Set<String> processedKeys = {}; // Set to store processed keys
  Set<String> iconPath = {};

  // late Stream<Map<String, dynamic>> sensor;

  // Future<void> getSensorInClass() async {
  //   try {
  //     sensor = await GetNameClass.getFieldMapStream();
  //     print('Data sensor is: $sensor');
  //   } catch (error) {
  //     print('Error retrieving field names: $error');
  //   }
  // }
  
  @override
  void initState() {
    super.initState();
    // getSensorInClass();
    sensorDataStream = FirebaseFirestore.instance.collection('Devices').doc(widget.classroom).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: sensorDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else {

          Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;

          print('Data is: $data');
          if (data != null) {
            for (var entry in data.entries) {
              if(!processedKeys.contains(entry.key)) {
                processedKeys.add(entry.key); // Mark key as processed
                devices.add(
                  DeviceModel(
                    name: entry.key,
                    color: entry.value['color'],
                    isActive: entry.value['isActive'],
                    icon: entry.value['iconPath'],
                  )
                );
                iconPath.add(entry.value['iconPath']);
              }
            }
            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: devices.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Devices(
                    name: devices[index].name,
                    svg: devices[index].icon,
                    color: devices[index].color.toColor(),
                    isActive: devices[index].isActive,
                    onChanged: (val) {
                      setState(() {
                        for (var keyIndex in processedKeys) {
                          if(devices[index].name == keyIndex){
                            devices[index].isActive = !devices[index].isActive;
                            FirebaseFirestore.instance
                              .collection('Devices')
                              .doc('2A08') // Use device name as document ID
                              .update({
                                devices[index].name : {
                                  'isActive' : devices[index].isActive,
                                  'classRoom' : '2A08',
                                  'color' : devices[index].color,
                                  'devicesName' : devices[index].name,
                                  'iconPath': devices[index].icon,
                                }
                              })
                              .then((_) => print('Successfully updated device state on Firestore'))
                              .catchError((error) => print('Error updating device state: $error'));
                          }
                        }
                      }
                    );
                    },
                  );
                }
              ),
            );
          } else {
            return const Text('Data not available');
          }
        }
      },
    );
  }
}
