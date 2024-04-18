import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home/home_page.dart';
import 'package:flutter_firebase/pages/home/devices_active_page.dart';
import 'package:flutter_firebase/pages/home/usage_page.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../model/tabbar_get_sensor.dart';
import '../add_devices_page/add_devices_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});
  @override
  State<ControlPage> createState() => _ControlPageState();
}

var temperature = "0".obs;
var humidity = "0".obs;
var light = "0".obs;
var moisture = "0".obs;
var soundQuality = "0".obs;
var airQuality = "0".obs;
var classCheck = "0".obs;


var ref = FirebaseDatabase.instance.ref().child("FirebaseIOT");

getData() async {
  ref.onValue.listen(
    (event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      Object? data = snapshot.value;
      Map<dynamic, dynamic> map = data as Map<dynamic, dynamic>;
      temperature.value = map["temperature"].toString();
      humidity.value = map["humidity"].toString();
      moisture.value = map["moisture"].toString();
      soundQuality.value = map["sound quality"].toString();
      airQuality.value = map["air quality"].toString();
      classCheck.value = map["classroom is"].toString();
    }
  });
}


class _ControlPageState extends State<ControlPage> {

  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  
  @override
  void initState() {
    super.initState();
    getData();
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DevicesActivePage(),
    UsagePage(),
    AddDevices(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: const Color.fromARGB(255, 29, 214, 128),
              hoverColor: const Color.fromARGB(255, 29, 214, 128),
              gap: 8,
              activeColor: const Color.fromARGB(255, 29, 214, 128),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: const Color.fromARGB(255, 211, 211, 211),
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.desktop,
                  text: 'Devices',
                ),
                GButton(
                  icon: LineIcons.lineChart,
                  text: 'Usage',
                ),
                GButton(
                  icon: LineIcons.plusSquareAlt,
                  text: 'Add Devices',
                ),
                // IconButton(
          //   icon: const Icon(Icons.navigate_next),
          //   tooltip: 'Go to the next page',
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute<void>(
          //       builder: (BuildContext context) {
          //         return const NextPage();
          //       },
          //     ));
          //   },
          // ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


