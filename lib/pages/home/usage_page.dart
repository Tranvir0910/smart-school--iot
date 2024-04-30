import 'package:flutter/material.dart';
import 'package:flutter_firebase/const/const.dart';
import 'package:flutter_firebase/pages/home/humidity_line.dart';
import 'package:flutter_firebase/pages/home/temperature_line.dart';

class UsagePage extends StatefulWidget {
  const UsagePage({super.key});

  @override
  State<UsagePage> createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  @override
  Widget build(BuildContext context) {
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
                  'Usage Page',
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
        // actions: <Widget>[
        //   CircleAvatar(
        //     radius: 20,
        //     backgroundColor: Colors.white70,
        //     child: IconButton(
        //       icon: const Icon(Icons.filter_list),
        //       tooltip: 'Show Snackbar',
        //       onPressed: () {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('This is a snackbar')));
        //       },
        //     ),
        //   ),
        //   const SizedBox(width: 10,)
        // ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Temperature Usage",
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
              child: TemperatureLine()
            ),
            Text(
              "Humidity Usage",
              style: TextStyle(
                fontSize: 19,
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(child: HumidityLine())
          ]
        )
      )
    );
  }
}