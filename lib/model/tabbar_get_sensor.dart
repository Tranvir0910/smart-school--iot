import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/firestore/getDataSensor.dart';
import '../const/const.dart';

class TabbarSensorData extends StatefulWidget {
  const TabbarSensorData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TabbarSensorDataState createState() => _TabbarSensorDataState();
}

class _TabbarSensorDataState extends State<TabbarSensorData> with TickerProviderStateMixin {

  String selectedTabName = '2A08';
  String collectionName = 'Classroom';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                controller: _tabController,
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
                tabs: const [
                  Tab(
                    icon: Icon(Icons.room),
                    text: "2A08  ",
                  ),
                  Tab(
                    icon: Icon(Icons.room),
                    text: "2A16  ",
                  ),
                  Tab(
                    icon: Icon(Icons.room),
                    text: "2A27  ",
                  ),
                  Tab(
                    icon: Icon(Icons.room),
                    text: "2A34  ",
                  ),
                ],
                onTap: (index) {
                  setState(() {
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
                      // ignore: avoid_print
                      .then((value) => print("Check Complete"))
                      // ignore: avoid_print
                      .catchError((error) => print("Check Failed: $error"));
                  }
                );
              },
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const <Widget>[
                    // GetSensorData(classroom: '2A08'),
                    // GetSensorData(classroom: '2A16'),
                    // GetSensorData(classroom: '2A27'),
                    // GetSensorData(classroom: '2A34'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}