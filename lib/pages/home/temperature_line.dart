import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class HumidityLine extends StatefulWidget {
  const HumidityLine({super.key});

  @override
  State<HumidityLine> createState() => _HumidityLineState();
}

class _HumidityLineState extends State<HumidityLine> {
  
  late List<LiveData> chartData;
  late StreamSubscription<DocumentSnapshot> _firestoreSubscription;
  final _firestore = FirebaseFirestore.instance;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  DateTime time = DateTime.now();
  
  @override
  void initState() {
    chartData = [];
    _startListeningToFirestore();
    _tooltipBehavior = TooltipBehavior(enable: true);
     _zoomPanBehavior = ZoomPanBehavior(
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 2,
        selectionRectColor: Colors.grey,
        enablePanning: true,
        zoomMode: ZoomMode.x,
        enableMouseWheelZooming: true,
        maximumZoomLevel: 0.7);
    super.initState();
    super.initState();
  }

  @override
  void dispose() {
    _firestoreSubscription.cancel(); // Clean up subscription on dispose
    super.dispose();
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

        final humidity = result['Humidity'];

        if (humidity != null) {
          setState(() {
            chartData.add(LiveData(DateFormat("h:mm:ss a - yy-MM-dd").format(time).toString(), humidity));
            FirebaseFirestore.instance
              .collection('Usage')
              .doc('2A08') // Use device name as document ID
              .update({
                DateFormat("h:mm:ss a - yy-MM-dd").format(time).toString() : {
                  "Humidity": humidity,
                }
              })
              .then((_) => print('Successfully updated data state on Firestore'))
              .catchError((error) => print('Error updating data state: $error'));
          });
        } else {
          print('Missing humidity data in Firestore document');
        }
      } else {
        print('Document not found in Firestore');
      }
    });
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
          title: const ChartTitle(text: 'Humidity'),
          legend: const Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          backgroundColor: Colors.transparent, // Optional for transparent background
          series: <LineSeries<LiveData, String>>[
            LineSeries<LiveData, String>(
              name: 'Humidity',
              dataSource: chartData,
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.humidity,
              color: const Color.fromRGBO(192, 108, 132, 1),
              
            )
          ],
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 3,
            title: AxisTitle(text: 'Time (seconds)'),
          ),
          primaryYAxis: const NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            title: AxisTitle(text: 'Humidity ( % )')
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
