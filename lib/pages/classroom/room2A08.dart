import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/string_to_color.dart';

import '../../model/device_model.dart';
import '../home/control_page.dart';
import '../home/devices.dart';

class room2A08 extends StatefulWidget {
  const room2A08({super.key});

  @override
  State<room2A08> createState() => _room2A08State();
}

// ignore: camel_case_types
class _room2A08State extends State<room2A08> {

  List<DeviceModel> devices = [
    DeviceModel(
        name: 'Lighting',
        isActive: false,
        color: "#fef7e2",
        icon: 'assets/svg/light.svg'),
    DeviceModel(
        name: 'Fan',
        isActive: false,
        color: "#cee7f0",
        icon: 'assets/svg/ac.svg'),
    DeviceModel(
        name: 'Watering',
        isActive: false,
        color: "#9fe3ee",
        icon: 'assets/svg/watering.svg'),
    // DeviceModel(
    //     name: 'Smart Sound',
    //     isActive: false,
    //     color: "#c207db",
    //     icon: 'assets/svg/speaker.svg'),
  ];

  @override
  Widget build(BuildContext context) {
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
  }
}