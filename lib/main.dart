import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase/background_service/background_service.dart';
import 'firebase/firebase_options.dart';
import 'pages/home/control_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initservice();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.transparent,
        ledColor: Colors.white
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group'
      )
    ],
    debug: true
  );
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
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