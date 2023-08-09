import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_getx/app/controllers/auth_controller.dart';
import 'package:qr_code_getx/app/modules/loading/loading.dart';
import 'package:qr_code_getx/setup.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await initialize();
  Get.put(AuthController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //UNTUK AUTO LOGIN -> Firebase AUTH
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "QR Code",
          initialRoute: snapshot.hasData ? Routes.home : Routes.login,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
