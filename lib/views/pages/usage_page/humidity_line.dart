import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/const/const.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HumidityLine extends StatefulWidget {
  const HumidityLine({super.key});

  @override
  State<HumidityLine> createState() => _HumidityLineState();
}

class _HumidityLineState extends State<HumidityLine> {
  
  Constants myConstants = Constants(); 
  List<LiveData> chartDataHumidity = [];
  late StreamSubscription<DocumentSnapshot> _firestoreSubscription;
  final _firestore = FirebaseFirestore.instance;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  DateTime time = DateTime.now();
  Set<String> processedKeys = {}; // Set to store processed keys

  final timestampDateNow = DateFormat("dd-MM-yy").format(DateTime.now());
  
  @override
  void initState() {
    readInitialDataHumidity(timestampDateNow).then((data) {
      setState(() {
        chartDataHumidity = data;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
      // Handle error gracefully, if needed
    });
    _startListeningToFirestore();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      selectionRectBorderWidth: 2,  
      selectionRectColor: Colors.grey,
      enablePanning: true,
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: true,
      maximumZoomLevel: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    _firestoreSubscription.cancel(); // Clean up subscription on dispose
    super.dispose();
  }

Future<void> updateDataAndChart(double? temperature, double? humidity) async {
    final timestampHour = DateFormat("h:mm:ss a - dd-MM-yy").format(DateTime.now());
    final timestampDate = DateFormat("dd-MM-yy").format(DateTime.now());

    if (temperature != null && humidity != null) {
      chartDataHumidity.add(LiveData(timestampHour, humidity));
      // Update Firestore using a merge operation to preserve existing data
      final docRef = await _firestore.collection('Usage').doc(timestampDate).get();
      if (docRef.exists) {
        final DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Usage")
            .doc(timestampDate);
        return await documentReference.update({
          timestampHour: {
            "Temperature": temperature,
            "Humidity": humidity,
          },
        }).then((_) => print('Successfully updated data on Firestore'))
          .catchError((error) => print('Error updating data on Firestore: $error'));;
      } else {
        final DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Usage")
            .doc(timestampDate);
        return await documentReference.set({
          timestampHour: {
            "Temperature": temperature,
            "Humidity": humidity,
          },
        });
      }
    } else {
      print('Missing humidity data in Firestore document');
    }
  }


  void _startListeningToFirestore() {

    final docRef = _firestore.collection('2A08').doc('Sensor');
    _firestoreSubscription = docRef.snapshots().listen((snapshot) {
      
      if (snapshot.exists) {

        Map<String, dynamic>? data = snapshot.data();
        final Map<String, double> result = Map.fromIterables(
          data!.keys,
          data.values.map((e) => (double.tryParse(e.toString()) ?? 0.0)),
        );

        final temperature = result['Temperature'];
        final humidity = result['Humidity'];

        if (temperature != null) {
          setState(() {
            updateDataAndChart(temperature, humidity);      
          });
        } else {
          print('Missing humidity data in Firestore document');
        }
      } else {
        print('Document not found in Firestore');
      }
    });
  }

  Future<List<LiveData>> readInitialDataHumidity(String timestampDate) async {
    final docRef = _firestore.collection('Usage').doc(timestampDate);

    try {
      final querySnapshot = await docRef.get(); // Use get() for one-time retrieval

      if (querySnapshot.exists) {
        final data = querySnapshot.data() as Map<String, dynamic>;
        data.forEach((timestamp, value) {
          final humidity = value['Humidity'] as double?;
          
          if (humidity != null) {
            chartDataHumidity.add(LiveData(timestamp, humidity));
          }
        });
      } else {
        print('Document not found in Firestore');
      }
      return chartDataHumidity; // Return the populated list
    } on FirebaseException catch (error) {
      print('Error reading data from Firestore: $error');
      return []; // Return an empty list on error (optional)
    } catch (error) {
      print('Unexpected error: $error');
      return []; // Return an empty list on error (optional)
    }
  }



  @override
  Widget build(BuildContext context) {

    const duration = Duration(seconds:1); //duration is set to one second
    void updateState(Timer t) {
      if (mounted) {
        setState(() {
          time = DateTime.now();
        });
      }
    }
    Timer.periodic(duration, updateState);

    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          margin: const EdgeInsets.all(15),
          enableAxisAnimation: true,
          legend: const Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          backgroundColor: Colors.transparent, // Optional for transparent background
          zoomPanBehavior: _zoomPanBehavior,
          series: <LineSeries<LiveData, String>>[
            LineSeries<LiveData, String>(
              name: 'Humidity ( % )',
              dataSource: chartDataHumidity,
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.humidity,
              color: const Color.fromARGB(255, 204, 255, 0),
              
            )
          ],
          primaryXAxis: const CategoryAxis(
            isVisible: false,
            majorGridLines: MajorGridLines(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 300,
            title: AxisTitle(text: 'Time (s)'),
          ),
          primaryYAxis: const NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            // title: AxisTitle(text: 'Humidity ( % )')
          ),
        ),
      ),
    );
  }
}


class LiveData {
  LiveData(this.time, this.humidity);
  final String time;
  final double humidity;
}
