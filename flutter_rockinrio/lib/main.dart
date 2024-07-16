import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_rockinrio/LoginPage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  // Initialize sqflite for desktop (if necessary)
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => RockInRio(),
    ),
  );
}

class RockInRio extends StatelessWidget {
  RockInRio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
      },
    );
  }
}
