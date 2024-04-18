import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../const/const.dart';
import '../firestore/getDevicesData.dart';

class TabbarDataDevices extends StatefulWidget {
  const TabbarDataDevices({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TabbarDataDevicesState createState() => _TabbarDataDevicesState();
}

class _TabbarDataDevicesState extends State<TabbarDataDevices> {

  String selectedTabName = '2A08';

  String collectionName = 'Classroom';

  static const List<Tab> _tabs = [
    Tab(icon: Icon(Icons.room), text: "2A08  "),
    Tab(icon: Icon(Icons.room), text: "2A16  "),
    Tab(icon: Icon(Icons.room), text: "2A27  "),
    Tab(icon: Icon(Icons.room), text: "2A34  "),
  ];

  static const List<Widget> _views = [
    GetDevicesData(classroom: '2A08'),
    GetDevicesData(classroom: '2A16'),
    GetDevicesData(classroom: '2A27'),
    GetDevicesData(classroom: '2A34'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();
    DocumentReference classroom = FirebaseFirestore.instance.collection('Classroom').doc("Status Classroom Check");

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.width,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                height: 50,
                labelSpacing: 10,
                borderWidth: 1,
                borderColor: myConstants.primaryColor,
                buttonMargin: const EdgeInsets.all(5),
                backgroundColor: myConstants.primaryColor,
                unselectedBackgroundColor: Colors.transparent,
                unselectedLabelStyle: TextStyle(color: myConstants.primaryColor),
                labelStyle:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: _tabs,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    if (index == 0) {
                      selectedTabName = '2A08';
                    } else if (index == 1) {
                      selectedTabName = '2A16';
                    } else if (index == 2) {
                      selectedTabName = '2A27';
                    } else if (index == 3) {
                      selectedTabName = '2A34';
                    }
                    Map<String, dynamic> updateData = {
                        "2A08": false,
                        "2A16": false,
                        "2A27": false,
                        "2A34": false,
                    };
                    if (selectedTabName == '2A08') {
                      updateData["2A08"] = true;
                    } else if (selectedTabName == '2A16') {
                      updateData["2A16"] = true;
                    } else if (selectedTabName == '2A27') {
                      updateData["2A27"] = true;
                    } else if (selectedTabName == '2A34') {
                      updateData["2A34"] = true;
                    }

                    classroom.set(updateData)
                      .then((value) => print("Check Complete"))
                      .catchError((error) => print("Check Failed: $error"));
                  }
                );
              },
              ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: _views,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}