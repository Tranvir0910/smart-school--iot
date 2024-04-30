import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import '../../const/const.dart';
import '../../firestore/getDataSensor.dart';
import 'control_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _wf.currentWeatherByCityName("Ho Chi Minh City").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        print('App paused');
        break;
      case AppLifecycleState.resumed:
        print('App resumed');
        break;
      case AppLifecycleState.inactive:
        print('App inactive');
        break;
      case AppLifecycleState.detached:
        print('App detached');
        break;
      case AppLifecycleState.hidden:
        print('App hidden');
        break;
    }
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();

    DateTime time = DateTime.now();

    const duration = Duration(seconds:1); //duration is set to one second
    void updateState(Timer t) {
      if (mounted) {
        setState(() {
          time = DateTime.now();
        });
      }
    }

    Timer.periodic(duration, updateState);
    
    // DateTime time = DateTime.now();
    // const duration = Duration(seconds:1); //duration is set to one second
    // Timer.periodic(duration, (Timer t) => setState((){
    //   time = DateTime.now();  
    // }));
    String dateString = time.toString();
    var dateTime = DateTime.parse(dateString);
    String dateUpdate = DateFormat.jm().format(time).toString();
    var date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    ref
      .child("FirebaseIOT")
      .child("History")
      .child(date)
      .set({'datetime': dateUpdate});

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: myConstants.primaryColor,
        title: Row(
          children: [
            Image.asset("assets/icons/school.png", 
              fit: BoxFit.contain,
              height: 40,
            ),
            const SizedBox(width: 15),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome!,',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                  "Tran Vi",
                  style: TextStyle(
                      height: 1.1,
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
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
        //   IconButton(
        //     icon: const Icon(Icons.add_alert),
        //     tooltip: 'Show Snackbar',
        //     onPressed: () {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(content: Text('This is a snackbar')));
        //     },
        //   ),
        // ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 90,
            ),
            _myData(time),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: size.width,
              height: 130,
              decoration: BoxDecoration(
                color: myConstants.primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: myConstants.primaryColor.withOpacity(.5),
                    offset: const Offset(0, 25),
                    blurRadius: 10,
                    spreadRadius: -12,
                  )
                ]
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Image.network(
              //       'http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png',
              //       height: 150,
              //       width: 150,
              //     ),
              //     Container(
              //       height: 50,
              //       width: 1,
              //       color: myConstants.thirdColor,
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //         TextSpan(
              //             text: "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°",
              //             style: const TextStyle(
              //               fontWeight: FontWeight.w600,
              //               fontSize: 68,
              //               color: Colors.black54,
              //             )),
              //         TextSpan(
              //             text: _weather?.weatherDescription ?? '',
              //             style: const TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 18,
              //               color: Colors.white70,
         
              //             )),
              //       ]),
              //     )
              //   ],
              // ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 10,
                    left: -15,
                    child: Image.network(
                            'http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png',
                            width: 200,
                          ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 30,
                    child: Text(
                      _weather?.weatherDescription ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 160,
                    top: 20,
                    child: Container(
                      width: 1,
                      height: 90,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: -5,
                    right: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: _currentTemp(),
                          ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: _minMaxCelius(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset("assets/icons/windspeed.png"),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset("assets/icons/clouds.png"),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset("assets/icons/humidity.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 60,
                      child: Text(
                        "${_weather?.windSpeed?.toStringAsFixed(2)} m/s",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 60,
                      child: Text(
                        "${_weather?.cloudiness?.toStringAsFixed(0)} %",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500,),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 60,
                      child: Text(
                        "${_weather?.humidity?.toStringAsFixed(1)} %",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500,),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Sensor",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Text(
                    //   "Data sensor in Classroom",
                    //   style: TextStyle(
                    //     height: 1.1,
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w600
                    //   ),
                    // ),
                  ],
                ),
                // Icon(
                //   Icons.more_horiz,
                //   color: Colors.grey[300],
                //   size: 30,
                // ),
                // Column(
                //   children: [
                //     Text(
                //       DateFormat.MMMMEEEEd().format(time),
                //       style: const TextStyle(
                //         fontSize: 13,
                //         color: Colors.grey,
                //         fontWeight: FontWeight.normal
                //       ),
                //     ),
                //     Text(
                //       DateFormat.jms().format(time),
                //       style: const TextStyle(
                //         height: 1.1,
                //         fontSize: 14,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600
                //       ),
                //     ),
                //   ]
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // const GetSensorData(classroom: '2A08'),
            const Expanded(child: GetSensorData()),   
            const SizedBox(
              height: 5,
            ),
            // Expanded(
            //   child: GridView.builder(
            //     itemCount: myElement.length,
            //     padding: const EdgeInsets.all(15),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, 
            //       crossAxisSpacing: 16, 
            //       mainAxisSpacing: 16, 
            //       childAspectRatio: 2,
            //     ),
            //     itemBuilder: (context, index) {
            //       return Material(
            //         elevation: 3,
            //         color: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Container(
            //           decoration: BoxDecoration(
            //           color: Colors.white,
            //             borderRadius: BorderRadius.circular(30)
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Expanded(
            //                 flex: 0,
            //                 child: Container(
            //                   width: Responsive.isSmallScreen(context) ? 70 : 300,
            //                   height: Responsive.isSmallScreen(context) ? 35 : 300,
            //                   decoration: const BoxDecoration(
            //                     borderRadius: BorderRadius.all(Radius.circular(0)),
            //                     color: Color.fromARGB(255, 255, 255, 255),
            //                   ),
            //                   child: Image.asset(
            //                     myElement[index][1],
            //                     width: 20,
            //                     height: 20,
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                 flex: 1,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text(
            //                       myElement[index][0],
            //                       style: TextStyle(
            //                         fontSize: MediaQuery.of(context).size.width / 40,
            //                         fontWeight: FontWeight.w600,
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text(
            //                       myElement[index][3].toString(),
            //                       style: TextStyle(
            //                         fontSize: MediaQuery.of(context).size.width / 40,
            //                         fontWeight: FontWeight.normal,
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}",
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        foreground: Paint()..shader = linearGradient,
      )
    );
  }
  Widget _minMaxCelius() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)} °C",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
        const SizedBox(
          width: 15,
        ),
        Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)} °C",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
      ],
    );
  }
  Widget _myData (DateTime time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_weather?.areaName}",
              style: const TextStyle(
                height: 1.1,
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              DateFormat("h:mm a - EEEE, d MMMM").format(time),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        // Icon(
        //   Icons.more_horiz,
        //   color: Colors.grey[300],
        //   size: 30,
        // ),
      ],
    );
  }
}