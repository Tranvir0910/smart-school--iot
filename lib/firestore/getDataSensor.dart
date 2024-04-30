import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_firebase/controller/notification_controller.dart';
import '../pages/home/sensor.dart';

class GetSensorData extends StatefulWidget {

  const GetSensorData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetSensorDataState createState() => _GetSensorDataState();
}

class _GetSensorDataState extends State<GetSensorData> {

  late Stream<DocumentSnapshot> sensorDataStream;

  static String temperature = '';
      
  static String humidity  = '';
        
  static int airQuality = 0;
          
  static int soundQuality  = 0;

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
    AwesomeNotifications().setListeners(
      onActionReceivedMethod:
        NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
    // getSensorInClass();
    sensorDataStream = FirebaseFirestore.instance.collection('2A08').doc('Sensor').snapshots();
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

          if (data != null) {
            
            // myElement[1][2] = data[widget.classroom]['Humidity'].toString();
            // myElement[0][2] = data[widget.classroom]['Temperature'].toString();
            // myElement[2][2] = data[widget.classroom]['AirQuality'].toString();
            // myElement[3][2] = data[widget.classroom]['SoundQuality'].toString();

            // FlutterBackgroundService().startService();

            if(int.parse(data['AirQuality']) < 2000){
              myElement[2][2] = 'Good';
            }else if(int.parse(data['AirQuality']) < 2500){
              myElement[2][2] = 'Moderate';
            }else{
              myElement[2][2] = 'Unhealthy';
            }

            if(int.parse(data['SoundQuality']) < 100){
              myElement[3][2] = 'Normal';
            }else if(int.parse(data['SoundQuality']) < 2500){
              myElement[3][2] = 'Noise';
            }else{
              myElement[3][2] = 'Very Noise';
            }
            
            if(myElement[3][2] == 'Very Noise'){
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  channelKey: "basic_channel" ,
                  title: "Warning!!!",
                  body: "Your classroom is very noisy 🚨🚨🚨", 
                  id: 1 
                ),
              );
            }
            if(myElement[2][2] == 'Unhealthy'){
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  channelKey: "basic_channel" ,
                  title: "Warning!!!",
                  body: "Your classroom is experiencing air pollution. Please step outside! 🚨🚨🚨", 
                  id: 1 
                ),
              );
            }

            myElement[1][2] = data['Humidity'].toString();
            myElement[0][2] = data['Temperature'].toString();

            return Expanded(
              child: GridView.builder(
                itemCount: myElement.length,
                padding: const EdgeInsets.all(10),
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
