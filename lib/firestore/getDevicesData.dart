import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/string_to_color.dart';
import '../model/device_model.dart';
import '../pages/home/control_page.dart';
import '../pages/home/devices.dart';
import '../pages/home/devices_active_page.dart';
import '../pages/home/sensor.dart';

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
            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
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
                        if(devices[index].name == 'Lighting'){
                            devices[index].isActive = !devices[index].isActive;
                            ref.child("status led").set(devices[index].isActive);
                        }else if(devices[index].name == 'Fan'){
                          devices[index].isActive = !devices[index].isActive;
                          ref.child("status fan").set(devices[index].isActive);
                        }else if(devices[index].name == 'Watering'){
                          devices[index].isActive = !devices[index].isActive;
                          ref.child("status motor").set(devices[index].isActive);
                        }
                      });
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
