import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore

class UsagePage extends StatefulWidget {
  const UsagePage({super.key});

  @override
  State<UsagePage> createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  
  late List<LiveData> chartData;
  late StreamSubscription<DocumentSnapshot> _firestoreSubscription;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    chartData = [];
    _startListeningToFirestore();
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
            chartData.add(LiveData(DateTime.now(), humidity));
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
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          backgroundColor: Colors.transparent, // Optional for transparent background
          series: <LineSeries<LiveData, DateTime>>[
            LineSeries<LiveData, DateTime>(
              dataSource: chartData,
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.humidity,
              color: const Color.fromRGBO(192, 108, 132, 1),
              markerSettings: const MarkerSettings(isVisible: true),
            )
          ],
          primaryXAxis: DateTimeAxis(
            minimum: DateTime.now().subtract(const Duration(minutes: 60)), // Past 60 minutes
            maximum: DateTime.now(),
            intervalType: DateTimeIntervalType.minutes,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10.0),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0, // Adjust minimum and maximum based on your humidity range
            maximum: 100, // Adjust maximum based on your humidity range
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10.0),
          ),
          legend: const Legend(isVisible: true), // Optional for legend
        ),
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.humidity);
  final DateTime time;
  final double humidity;
}
