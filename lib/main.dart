
import 'package:canteen_app/Authentications/dashboard.dart';
import 'package:canteen_app/Authentications/mobile.dart';
import 'package:canteen_app/Services/dbdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CommonScreens/homeView.dart';
import 'package:canteen_app/CommonScreens/recommendations.dart';
import 'package:canteen_app/Admin/predict_demand.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // Retrieve the device cameras

  } on Exception catch (e) {
    print(e);
  }

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
    // Don't block startup waiting for user data — fetch asynchronously after app starts
    if (FirebaseAuth.instance.currentUser != null) {
      fetchData();
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kk food',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primaryColor: Colors.white,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    
     //Real Login
      home: FirebaseAuth.instance.currentUser != null && phn!=null
          ? HomeView()
          :FirebaseAuth.instance.currentUser != null && phn==null ? Mobile() : Dashboard(),
      routes: {
        '/recommendations': (ctx) => RecommendationsPage(),
        '/predict-demand': (ctx) => PredictDemandPage(),
      },
      debugShowCheckedModeBanner: false,
      );
  }
}
