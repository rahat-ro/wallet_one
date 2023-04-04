import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wallet_one/auth/sign_in.dart';
import 'package:wallet_one/auth/sign_up.dart';

import 'home/home.dart';

import 'package:objectid/objectid.dart';
import 'package:intl/intl.dart';
import 'package:dart_std/dart_std.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade700
      ),
      routes: {
        '/' : (context) => const SignIn(),
      },
    );
  }
}


