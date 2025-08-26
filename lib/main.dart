
import 'package:achievr/src/constants/constants.dart';
import 'package:achievr/src/constants/strings.dart';
import 'package:achievr/src/providers/auth_provider.dart';
import 'package:achievr/src/providers/goal_provider.dart';
import 'package:achievr/src/services/local_noti_services.dart';
import 'package:achievr/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Constants.prefs = await SharedPreferences.getInstance();
  await LocalNotificationService().localNotificationInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes().onGenerateRoutes,
        initialRoute: '/$loadingScreen',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.yellow,
        ),
        // home: ,
      ),
    );
  }
}
