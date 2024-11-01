// import 'dart:ffi';

/*---------------------------------- */
/* -- Importing Required packages -- */
/*---------------------------------- */
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gt_bank_app/firebase_options.dart';
import 'package:gt_bank_app/services/utils.dart';
import 'package:gt_bank_app/services/firebase_messaging.dart';

/*------------------------------ */
/* -- Importing Reuired Pages -- */
/*------------------------------ */
import 'package:gt_bank_app/pages/my_home_page.dart';
import 'package:gt_bank_app/pages/dashboard.dart';
import 'package:gt_bank_app/pages/register.dart';
import 'package:gt_bank_app/pages/current_customers.dart';
import 'package:gt_bank_app/pages/base_profile.dart';
import 'package:gt_bank_app/pages/notifications_page.dart';

/*------------------------------ */
/* -- App Start Main function -- */
/*------------------------------ */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessagingAPI().initializeFirebaseMessaging;

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

/*------------------------- */
/* -- Defining App class -- */
/*------------------------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        scaffoldMessengerKey: Utils().messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 4, 247, 37)),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        routes: {
          '/dashboard': (context) => const Dashboard(),
          '/home': (context) => const MyHomePage(),
          '/register': (context) => const Register(),
          '/customers': (context) => const CurrentCustomers(),
          '/profile': (context) => const BaseProfile(),
          '/notifications_page': (context) => const NotificatonsPage()
        });
  }
}
