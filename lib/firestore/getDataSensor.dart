import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/home/sensor.dart';

class GetSensorData extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final classroom;

  const GetSensorData({Key? key, required this.classroom}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetSensorDataState createState() => _GetSensorDataState();
}

class _GetSensorDataState extends State<GetSensorData> {

  late Stream<DocumentSnapshot> sensorDataStream;

  static String temperature = '';
      
  static String humidity  = '';
        
  static String airQuality  = '';
          
  static String soundQuality  = '';

  List myElement = [
    ["Temperature (°C)", "assets/icons/temperature_cold.png", temperature],
    ["Humidity (%)", "assets/icons/humidity_cold.png", humidity],
    ["Air Quality", "assets/icons/air_quality_normal.png", airQuality],
    ["Sound Quality", "assets/icons/quiet.png", soundQuality],
  ];

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
    sensorDataStream = FirebaseFirestore.instance.collection('Classroom').doc('Sensor').snapshots();
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

          if (data != null && data.containsKey(widget.classroom)) {
            
            myElement[1][2] = data[widget.classroom]['Humidity'].toString();
            myElement[0][2] = data[widget.classroom]['Temperature'].toString();
            myElement[2][2] = data[widget.classroom]['Air Quality'].toString();
            myElement[3][2] = data[widget.classroom]['Sound Quality'].toString();

            return Expanded(
              child: GridView.builder(
                itemCount: myElement.length,
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 16, 
                  mainAxisSpacing: 16, 
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return SensorWidget(
                        nameSensor: myElement[index][0],
                        img: myElement[index][1],
                        firestoreData:  myElement[index][2],
                        myElementLength: myElement.length,
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
