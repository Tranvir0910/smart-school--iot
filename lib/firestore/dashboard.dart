import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../const/custom_styles.dart';
import '../model/sensor.dart';
import '../widgets/my_sensor_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  List<double>? tempList;
  List<double>? rhList;

  static String collectionName = 'EspData';
  final sensorRef = FirebaseFirestore.instance
      .collection(collectionName)
      .withConverter<Sensor>(
        fromFirestore: (snapshots, _) => Sensor.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Sensor>>(
      stream: sensorRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        if (tempList == null) {
          tempList = List.filled(5, data.docs.first.data().temperature,
              growable: true);
        } else {
          tempList!.add(data.docs.first.data().temperature);
          tempList!.removeAt(0);
        }

        if (rhList == null) {
          rhList =
              List.filled(5, data.docs.first.data().humidity, growable: true);
        } else {
          rhList!.add(data.docs.first.data().humidity);
          rhList!.removeAt(0);
        }

        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            collectionName,
                            style: kHeadline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.docs.first.id,
                            style: kHeadline,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MySensorCard(
                                value: data.docs.first.data().humidity,
                                unit: '%',
                                name: 'Humidity',
                                assetImage: const AssetImage(
                                  'assets/icons/humidity_cold.png',
                                ),
                                trendData: rhList!,
                                linePoint: Colors.blueAccent,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MySensorCard(
                                value: data.docs.first.data().temperature,
                                unit: '\'C',
                                name: 'Temperature',
                                assetImage: const AssetImage(
                                  'assets/images/temperature_cold.png',
                                ),
                                trendData: tempList!,
                                linePoint: Colors.redAccent,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    ));
  }
}
