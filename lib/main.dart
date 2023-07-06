import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/user_model.dart';
import 'package:monitorproduct/state/authen.dart';
import 'package:monitorproduct/state/main_home_rider.dart';
import 'package:monitorproduct/state/main_home_user.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/User',
    page: () => const MainHomeUser(),
  ),
  GetPage(
    name: '/Rider',
    page: () => const MainHomeRider(),
  ),
];

String? name;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        // Sign Out
        name = '/authen';
        runApp(const MyApp());
      } else {
        // Sign In
        await FirebaseFirestore.instance
            .collection('user')
            .doc(event.uid)
            .get()
            .then((value) {
          UserModel userModel = UserModel.fromMap(value.data()!);
          name = '/${userModel.typeuser}';
          runApp(const MyApp());
        });
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: name,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
