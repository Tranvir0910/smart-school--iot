import 'package:flutter/material.dart';

import '../../element/responsive.dart';

class SensorWidget extends StatelessWidget {

  final int myElementLength;
  final String nameSensor;
  final String img;
  final dynamic firestoreData;


  const SensorWidget({
    Key? key,
    required this.nameSensor,
    required this.img,
    required this.firestoreData, 
    required this.myElementLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                width: Responsive.isSmallScreen(context) ? 70 : 300,
                height: Responsive.isSmallScreen(context) ? 35 : 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Image.asset(
                  img,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nameSensor,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    firestoreData.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 40,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}