import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase/firebase_options.dart';
import 'pages/home/control_page.dart';

void main() async {
   FlutterError.onError = (FlutterErrorDetails details) {
    if (details.library == 'image resource service' &&
        details.exception.toString().contains('404')) {
        print('Suppressed cachedNetworkImage Exception');
      return;
    }
    FlutterError.presentError(details);
  };
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    // name: 'flutter_firebase',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: const ControlPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}