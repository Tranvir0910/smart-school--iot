import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/add_devices_page/add_devices_page.dart';
import '../../const/const.dart';
import '../../model/device_model.dart';
import '../../model/tabbar_get_devices.dart';

class DevicesActivePage extends StatefulWidget {
  const DevicesActivePage({super.key});

  @override
  State<DevicesActivePage> createState() => _DevicesActivePageState();
}

class _DevicesActivePageState extends State<DevicesActivePage> {

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

    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants(); 

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: myConstants.primaryColor,
        title: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Smart Class',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ]
            ),
            // Navigator.push(context, MaterialPageRoute<void>(
            //       builder: (BuildContext context) {
            //         return const NextPage();
            //       },
            //     ));
          ],
        ),
        actions: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white70,
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active Devices",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // OutlinedButton(
                //   style: OutlinedButton.styleFrom(
                //     foregroundColor: myConstants.primaryColor,
                //     side: BorderSide(
                //       color: myConstants.primaryColor, // Set the desired outline color (e.g., Colors.red)
                //       width: 2.0, // Set the outline thickness
                //       style: BorderStyle.solid, // Set the outline style (e.g., BorderStyle.solid, BorderStyle.dotted)
                //     ),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                //   ),
                //   onPressed: () => Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (e) => const AddDevices())),
                //   child: const Text(
                //       'Add Devices',
                //       style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
              ],
            ),

            Expanded(
              child: TabbarDataDevices(),
            ),
            // Line chart
            // Container(
            //   width: size.width,
            //   height: 130,
            //   decoration: BoxDecoration(
            //     color: Colors.transparent,
            //     borderRadius: BorderRadius.circular(15),
            //     boxShadow: [
            //       BoxShadow(
            //         color: myConstants.primaryColor.withOpacity(.5),
            //         offset: const Offset(0, 25),
            //         blurRadius: 10,
            //         spreadRadius: -12,
            //       )
            //     ]
            //   ),
              
            //   // child: Chart(
            //   //   layers: [
            //   //     ChartAxisLayer(
            //   //       settings: ChartAxisSettings(
            //   //         x: ChartAxisSettingsAxis(
            //   //           min: 7.0,
            //   //           max: 13.0,
            //   //           frequency: 1.0,
            //   //           textStyle: TextStyle(
            //   //             color: Colors.white.withOpacity(0.6),
            //   //             fontSize: 10.0,
            //   //             ),
            //   //         ),
            //   //         y: ChartAxisSettingsAxis(
            //   //           frequency: 100.0,
            //   //           max: 300.0,
            //   //           min: 0.0,
            //   //           textStyle: TextStyle(
            //   //             color: Colors.white.withOpacity(0.6),
            //   //             fontSize: 10.0,
            //   //           ),
            //   //         ),
            //   //       ),
            //   //       labelX: (value) => value.toInt().toString(),
            //   //       labelY: (value) => value.toInt().toString(),
            //   //     ),
            //   //     ChartLineLayer(
            //   //       items: List.generate(
            //   //         13 - 7 + 1,
            //   //         (index) => ChartLineDataItem(
            //   //           value: Random().nextInt(280) + 20,
            //   //           x: index.toDouble() + 7,
            //   //         ),
            //   //       ),
            //   //       settings: ChartLineSettings(
            //   //         thickness: 5, 
            //   //         color: myConstants.secondaryColor,
            //   //       ),
            //   //     ),
            //   //   ],
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}